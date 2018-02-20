let navToggle

document.addEventListener('DOMContentLoaded', () => {
  const dropdown = document.getElementById("dropdown");
  const menuList = document.getElementById("menulist");
  const menuItems = document.getElementsByClassName("menuitems");
  const menuButton = document.getElementById("menubtn");

  const dropdownOpenHeight = `${menuItems.length * 60}px`
  const dropdownClosedHeight = "80px"

  dropdown.style.height = dropdownClosedHeight
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
    if (dropdown.style.height <= dropdownOpenHeight) {
      dropdown.style.height = dropdownClosedHeight;
      
      for (let i = 0; i < menuItems.length; i++){
        menuItems[i].style.marginBottom="100px";
        menuItems[i].style.opacity="0.0";
      };
      document.body.style.backgroundColor = "rgba(0,0,0,0.0)";
    } else if (dropdown.style.height <= dropdownClosedHeight) {
      dropdown.style.height = dropdownOpenHeight;
      
      for (let i = 0; i < menuItems.length; i++){
        menuItems[i].style.opacity="1.0";
        menuItems[i].style.marginBottom="0px";
      };
    }
  };
  
});