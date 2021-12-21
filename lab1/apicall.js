<!-- JS to gather data from NASA -->
<script>
    fetch('https://api.nasa.gov/planetary/apod?api_key=30wKykhzibTOdpJo9xJ0waYUDXLdfBxfXBZE5SEr')
    .then(response => response.json())
    .then (function(data){
        console.log(data);
        document.getElementById("nasa_img").style = "background-image: url("+data.url+")";
        document.getElementById("pic_text").innerHTML = data.explanation;
    })
    .catch(function(error) {
        console.log("This is an ERROR");
    });
</script>
<noscript>Sorry, your browser does not support JavaScript!!</noscript>
