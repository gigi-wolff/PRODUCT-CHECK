class Product < ApplicationRecord
  # dependent: :destroy, rails will destroy all reactions associated with Product when its deleted
  has_many  :reactions, dependent: :destroy
  # A has_many :through association is often used to set up a many-to-many connection 
  # with another model (Reaction). This association indicates that the declaring model (Product) can be 
  # matched with zero or more instances of another model (Allergen) by proceeding through a third model (Reaction).
  has_many  :allergens, through: :reactions
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'

  validates :name, presence: true
  #to validate more than one column (or more), you can add that to the scope
  validates_uniqueness_of :name, presence: true, :case_sensitive => false, :scope => [:user_id], length: {minimum: 3}
  validates :ingredients, presence: true
  #validates :ingredients, format: { with: /\w+,\s/, :message => 'Ingredients must be seperated by comma(,) followed by a space' }
  validates :ingredients, format: { without: /;/, :message => "contains a ';' which is not a valid charcter" }


  # The model should be able to answer the question "Can user x do y to this object?"
  # When you write regular methods in the model those methods are all instance methods.  
  # In other words def some_method will be a method available on each retrieved product record
  def get_ingredients 
    # get rid of all characters that are not: a-z A-Z 0-9 - [] () . ' / , blank;
    clean_ingredients = self.ingredients.gsub(%r{[^a-zA-Z0-9\-\[\]\.\,\'\(\)\/\s]}, '')
    return clean_ingredients.split(', ').each { |ingredient| ingredient.strip! }
  end

  def causes_reaction
    if Reaction.exists?(product_id: self.id, user_id: self.user_id)
      return Reaction.where("product_id = ? AND user_id = ?", self.id, self.user_id)
    else
      return []
    end
  end

  def check_for_allergens
    #require "pry"

    # test each ingredient in product
    self.get_ingredients.each do |ingredient|
      # create an array of allergen categories which contain substance that match the ingredient
      allergen_categories_causing_reactions = Allergen.where "user_id = ? AND substances ILIKE ?", self.user_id, "%#{ingredient}%"
      unless allergen_categories_causing_reactions.empty? 
        # check each allergen that contains a substance(s) that matches an ingredient
        allergen_categories_causing_reactions.each do |allergen_category|
          # add only those matching substances to the Reaction db
          allergen_substances_matching_ingredient =
           allergen_category.get_substances.select {|substance| substance.upcase.include?(ingredient.upcase)}.join(';')
          unless allergen_substances_matching_ingredient.blank?
            # logger.info("!!!!!!!!----- matching substances: #{allergen_substances_matching_ingredient} -- ")
            Reaction.create(product_id: self.id, 
            allergen_id: allergen_category.id, 
            reactive_substances: allergen_substances_matching_ingredient,
            reactive_ingredient: ingredient.upcase,
            user_id: self.user_id)
          end
        end
      end
    end
    
  end


  # After product has been created or updated (and saved) check if product contains allergens
  # and modify Reaction db accordingly
  after_save do
    # Clear Reaction db of this product if it already exists
    unless self.causes_reaction.empty?
      Reaction.where("product_id = ? AND user_id = ?", self.id, self.user_id).destroy_all
    end
    check_for_allergens
  end

end

