function handleShow() {
  // var name = document.getElementsById('product-name');
  // test.style.color="orange";
  alert('I am here in handleShow');
  // return false;
}

function setupForm(obj) {

  document.getElementById('form-input1').style.height = "50px";
  document.getElementById('form-input1').style.fontSize = "18pt";
  document.getElementById('form-input2').style.height = "250px";
  document.getElementById('form-input2').style.fontSize = "18pt";

  // var label = document.getElementsByClassName('form-label');

  if (obj == "product") {
    document.getElementsByTagName('input').name = "product[name]";
    document.getElementsByTagName('textarea').name = "product[ingredients]";
    document.getElementById('form-input1').placeholder = "Name of Product";
    document.getElementById('form-input2').placeholder = "ingredient 1, ingredient 2...";
    document.getElementById('form-button').innerHTML = "Check and Save"
  } else if (obj == "allergen") {
    document.getElementsByTagName('input').name = "allergen[category]";
    document.getElementsByTagName('textarea').name = "allergen[substances]";
    document.getElementById('form-input1').placeholder = "Allergen Category";
    document.getElementById('form-input2').placeholder = "substance 1; substance 2;...";
    document.getElementById('form-button').innerHTML = "Save"

  }

  return;
}