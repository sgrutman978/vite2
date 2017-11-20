// This registration token comes from the client FCM SDKs.
var registrationToken = "fSUM_XvqZnE:APA91bFKEVQriPLqgH8M6--5OqpI8z3OvAhKaaH3ofRh2f3jAvqYy148qqPK4H9hj_r-1HSYAsU4bLQuYrQ3MyIs4SptZ0vpMLw5-hMIpn6hi1O-oJSMjXwuRxwPoYIAHv3n9OF8T3nf";

// See the "Defining the message payload" section below for details
// on how to define a message payload.
var payload = {
  data: {
    score: "850",
    time: "2:45"
  }
};

// Send a message to the device corresponding to the provided
// registration token.
admin.messaging().sendToDevice(registrationToken, payload)
  .then(function(response) {
    // See the MessagingDevicesResponse reference documentation for
    // the contents of response.
    console.log("Successfully sent message:", response);
  })
  .catch(function(error) {
    console.log("Error sending message:", error);
  });