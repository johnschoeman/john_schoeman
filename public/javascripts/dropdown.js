let navToggle

document.addEventListener('DOMContentLoaded', () => {
  const dropdown = document.getElementById("dropdown");
  const menuList = document.getElementById("menulist");
  const menuItems = document.getElementsByClassName("menuitems");
  const menuButton = document.getElementById("menubtn");

  const menuHeight = "225px" //Todo make this calculate from the size of the list items
  const dropdownStartHeight = "80px"
  //default to measure if/else from
  dropdown.style.height = dropdownStartHeight
  for (let i = 0; i < menuItems.length; i++){
    menuItems[i].style.marginBottom="100px";
  };
  
  menuButton.addEventListener("click", function(){
    let menuIcon = menuButton.children;
    for (i = 0; i < menuIcon.length; i++){
      menuIcon[i].classList.toggle("active");
    }   
  });
  
   navToggle = () => {	
    //to menuButton
    if (dropdown.style.height <= menuHeight) {
      dropdown.style.height = dropdownStartHeight;
      
      for (let i = 0; i < menuItems.length; i++){
        menuItems[i].style.marginBottom="100px";
        menuItems[i].style.opacity="0.0";
      };
      document.body.style.backgroundColor = "rgba(0,0,0,0.0)";
    } else if (dropdown.style.height <= dropdownStartHeight) {
      dropdown.style.height = menuHeight;
      
      for (let i = 0; i < menuItems.length; i++){
        menuItems[i].style.opacity="1.0";
        menuItems[i].style.marginBottom="0px";
      };
    }
  };
  
});