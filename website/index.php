<html>
<script src="https://www.gstatic.com/firebasejs/4.5.0/firebase.js"></script>
<script src="https://www.gstatic.com/firebasejs/4.5.0/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/4.5.0/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/4.5.0/firebase-database.js"></script>
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.5/jquery.mobile.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.5/jquery.mobile.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Ubuntu:regular,bold&subset=Latin">
<style>
.boxThingy{
	position:relative;
	width:100%;
	height: 56;
	border-bottom: thin solid #777777;
	background-color:white;
}
body{
	
}
.middleText{
color:black;
position:absolute;
top:14;
left: 60px;
right:7px;
font-size:26px;
background-color: white;
overflow:hidden;
 white-space: nowrap;
text-overflow:ellipsis;
  /*vertical-align: middle;*/
  /*line-height: normal;*/
  font-family: Ubuntu, sans-serif;
}
.servicePic{
	position:relative;
	width:48px;
	height:48px;
	top:4px;
	left:4px;
	border-radius:5px;
}
</style>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>


var code = "<?php echo $_GET['info']; ?>".substring(0,8);
// alert(code);
var uid = "<?php echo $_GET['info']; ?>".substring(8);


var arr4 = []

$(document).ready(function(){
   $(document).on("click", ".boxThingy" , function() {
        var temp = arr4[$(this).attr('id')]
        if(temp != "skype" && temp != "peri", temp!= "aim" && temp != "xbox"){
        	window.open(temp);
        }
    });
});

// Set the configuration for your app
  // TODO: Replace with your project's config object
  var config = {
    apiKey: "AIzaSyBiiFVzhwEWaZejgFk38F-sMfKFY9pdbT4",
    authDomain: "vite-a7f75.firebaseapp.com",
    databaseURL: "https://vite-a7f75.firebaseio.com/",
    storageBucket: "bucket.appspot.com"
  };
  firebase.initializeApp(config);

  // Get a reference to the database service
  var database = firebase.database();

firebase.auth().signInWithEmailAndPassword("viteappllc@gmail.com", "AnAwesomePassworddot123098").catch(function(error) {
  // Handle Errors here.
  document.write("hiiiii")
  var errorCode = error.code;
  var errorMessage = error.message;
  // ...
});


function clickLink(res, num){
var arr3 = ["https://"+res,
        	"http://twitter.com/"+res,
            "tel:"+res,
            "http://snapchat.com/add/"+res,
            "http://instagram.com/"+res,
            "mailto:"+res,
            "http://" + res,
            "http://pinterest.com/"+res,
            "http://"+res+".tumblr.com",
            "https://github.com/"+res,
            "https://"+res,
            "skype",
            "http://reddit.com/"+res,
            "https://"+res,
            "http://youtube.com/channel/"+res,
            "https://"+res,
            "https://venmo.com/"+res,
            "https://"+res,
            "https://dribbble.com/"+res,
            "peri",
            "http://500px.com/"+res,
            "http://myspace.com/"+res,
            "https://"+res,
            "https://"+res,
            "aim",
            "xbox"];
            return arr3[num];
        }


var codeVals = "";
var ref4 = firebase.database().ref('/users/'+uid+'/codes/'+code);
ref4.once('value', function(snapshot) {
	codeVals = snapshot.val();
	window.location = ("vite://inner/"+codeVals);
document.body.innerHTML = document.body.innerHTML + ("<a id='toApp' href='vite://inner/"+codeVals+"'>Click me</a>");
});

var place = 0;
var pics = ["fb.png", "twitter.jpg", "phone.png", "snap.jpg", "insta.jpg", "mail.png", "link.png", "pint.png", "tumblr.png", "git.png", "plus.png", "skype.jpg", "reddit.jpg", "stack.png", "youtube.png", "yelp.png", "venmo.png", "linkedin.jpg", "dribbble.jpg", "peri.png", "500px.png", "myspace.png", "spotify.png", "flickr.png", "aim.jpg", "xbox.jpg"];
var ref = firebase.database().ref('/users/'+uid+'/info');
var counter = 0
var temp123 = "";

ref.once('value', function(snapshot) {
snapshot.forEach(function(childSnapshot) {
    var childKey = childSnapshot.key;

    if(codeVals.indexOf(childKey) >= 0){

    var num = parseInt(childKey.substring(0,2));
    // document.write(num);
    var childData = childSnapshot.val();
    if(num == 19){
    	temp123 = childData;
    }
    if(num >= 20){
    	if([20, 30, 33, 35, 37, 42, 43].indexOf(num) == -1 || childKey == "20MAIN" || childKey == "21MAIN"){
    document.body.innerHTML = document.body.innerHTML + ("<div class='boxThingy' id='"+counter+"' style='top:" + place + "'>"+
    	"<img src='"+pics[num-20]+"' class='servicePic' />"+
    	"<span class='middleText'>"+childData+"</span></div>\n");
    if(childKey == "20MAIN"/* || childKey == "21MAIN"*/){
				arr4.push("https://www.facebook.com/"+temp123);
    	// if(childKey == "20MAIN"){
    	// }else{
    	// }
	}else{
		arr4.push(clickLink(childData, (num-20)));
	}
    counter+=1;
    // place+=57
}else{
	var ref2 = firebase.database().ref('/users/'+uid+'/info2/'+childKey);
	ref2.once('value', function(snapshot) {
	document.body.innerHTML = document.body.innerHTML + ("<div class='boxThingy' id='"+counter+"' style='top:" + place + "'>"+
		"<img src='"+pics[num-20]+"' class='servicePic' />"+
		"<span class='middleText'>"+snapshot.val()+"</span></div>\n");
	arr4.push(clickLink(childData, (num-20)));
	counter+=1;
	// place+=57
});
}
}
    }
  });
});
  
</script>
</body>
</html>