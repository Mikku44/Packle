modal = document.getElementById("nav");

function toggle(){

    nav.classList.toggle('hidden');
    console.log("clicked");
}


function tapToScroll(){
    window.scrollTo({ top: 800, behavior: "smooth" });
}