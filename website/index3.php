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
	  font-family: Ubuntu, sans-serif;
      visibility: hidden;
}
.avail{
	height:50px;
	position:relative;
	top:-20px;
}
#buttons{
	position: relative;
	top:-15px;
	margin-bottom:-45px;
}
#profPic{
	width:250px;
	height:250px;
	border-radius: 125px;
    visibility: hidden;
}
#vite{
	height:50px;
	position:relative;
	top:-20px;
	margin-left: 2px;
}
#name{
	font-size:30px;
	position:relative;
	top:-18px;
    visibility: hidden;
}
#bio{
	font-size:20px;
	position:relative;
	top:-33px;
	height:45px;
    visibility: hidden;
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
   $(document).on("click touchstart", ".boxThingy" , function() {
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
	// window.location = ("vite://inner/"+codeVals);
	if(snapshot.val() != null){
		console.log(snapshot);
document.body.innerHTML = document.body.innerHTML + ("<center><img src='' id='profPic' /><p id='name'>404 Error</p><p id='bio'>Sorry, we are having trouble finding this person's Vite!</p></br><div id='buttons'><a style='top:-20px;position:relative' id='toApp' href='vite://inner/"+codeVals+"'><button class='avail' style='background-color:#5eb4ff'>Open in Vite App</button></a>"+"<img id='vite' src='http://is5.mzstatic.com/image/thumb/Purple128/v4/7d/43/82/7d438203-699e-79a2-8d88-9c4fcd56d56b/source/175x175bb.jpg' /><a id='toApp' href='https://itunes.apple.com/us/app/vite-meet-greet-connect/id1289967327?ls=1&mt=8'><img class='avail' src='http://www.prosperityadvisers.com.au/SiteFiles/prosperityadviserscomau/app_store.png'/></a></span></center>");

var place = 0;
var pics = ["fb.png", "twitter.jpg", "phone.png", "snap.jpg", "insta.jpg", "mail.png", "link.png", "pint.png", "tumblr.png", "git.png", "plus.png", "skype.jpg", "reddit.jpg", "stack.png", "youtube.png", "yelp.png", "venmo.png", "linkedin.jpg", "dribbble.jpg", "peri.png", "500px.png", "myspace.png", "spotify.png", "flickr.png", "aim.jpg", "xbox.jpg"];
var ref = firebase.database().ref('/users/'+uid+'/info');
var counter = 0
var temp123 = "";
var fbTw = 0;

ref.once('value', function(snapshot) {
snapshot.forEach(function(childSnapshot) {
    var childKey = childSnapshot.key;
    var childData = childSnapshot.val();
    if(childKey == "00use" && childData == "tw"){
    	fbTw = 1;
    }
    if(childKey == "19DEF"){
    	if(fbTw == 0){
    		$.getJSON("http://graph.facebook.com/"+childData+"/picture?type=large&redirect=false", function(data) {
    			// var t = JSON.parse(data);
    $('#profPic').attr('src', data['data']['url']);
    $('#profPic').css('visibility', 'visible');
});
    		
    	}else{
    		$('img #profPic').attr('src', childData);
    	}
    }
    if(childKey == "17BIO"){
    		var obj = $('#bio').text(childData);
			obj.html(obj.html().replace(/\n/g,'<br/>'));
            $('#bio').css('visibility', 'visible');
    }
    if(childKey == "18NAME"){
    		$('#name').text(childData);
            $('#name').css('visibility', 'visible');
    }

    if(codeVals.indexOf(childKey) >= 0){

    var num = parseInt(childKey.substring(0,2));
    // document.write(num);
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
// setTimeout(function(){ alert("Hello"); }, 3000);
$("body").css("visibility", "visible");

}else{
    document.write("<iframe src='home.php' style='margin:0;border:none;width:100%;height:100%'> </iframe>")
}
});
  
</script>
</body>
</html>