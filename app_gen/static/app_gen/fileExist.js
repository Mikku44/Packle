
var url = document.getElementById("urlfile");
var output = document.getElementById("output");
var http = new XMLHttpRequest();

var counter = 0;
setInterval(function() {

        http.open('HEAD', url.value, false);
        http.send();
        if (http.status === 200) {
            window.location = 'complete';
            // output.innerHTML = "File exists";
        } else {
            // output.innerHTML = "File doesn't exists";
            counter += 1;
        }

        if(counter > 5) {
            clearInterval();
        }
},10000)