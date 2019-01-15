function handleShow(event){}

function centerPanel() {
  // To replace all existing classes with one or more new classes, set the className attribute:
  
  document.getElementById("panel-allergen-details").className = "col-lg-6 col-lg-offset-3";
  document.getElementById("allergen-panel-body").style.height = "fit-content";

  // alert('in centerpanel');
  return;
}


function formStyle() {

  document.getElementById('form-input').style.height = "50px";
  document.getElementById('form-input').style.fontSize = "18pt";
  document.getElementById('form-textarea').style.height = "250px";
  document.getElementById('form-textarea').style.fontSize = "18pt";
  // alert('in formStyle');
  // var label = document.getElementsByClassName('form-label');

  if (1<0) {
    if (obj == "product") {
      document.getElementById('form-input').name = "product[name]";
      document.getElementById('form-textarea').name = "product[ingredients]";
      document.breakme()
      document.getElementById('form-input').placeholder = "Name of Product";
      document.getElementById('form-textarea').placeholder = "ingredient 1, ingredient 2...";
      document.getElementById('form-button').innerHTML = "Check and Save"
    } else if (obj == "allergen") {
      document.getElementById('form-input').name = "allergen[category]";
      document.getElementById('form-textarea').name = "allergen[substances]";
      document.getElementById('form-input').placeholder = "Allergen Category";
      document.getElementById('form-textarea').placeholder = "substance 1; substance 2;...";
      document.getElementById('form-button').innerHTML = "Save"
    }
  }
  return;
}