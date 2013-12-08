//if ((typeof cordova == 'undefined') && (typeof Cordova == 'undefined')) alert('Cordova variable does not exist. Check that you have included cordova.js correctly');
//if (typeof CDV == 'undefined') alert('CDV variable does not exist. Check that you have included cdv-plugin-fb-connect.js correctly');
//if (typeof FB == 'undefined') alert('FB variable does not exist. Check that you have included the Facebook JS SDK file.');

FB.Event.subscribe('auth.login', function(response) {
  //alert('auth.login event');
});

function getLoginStatus() {
  FB.getLoginStatus(function(response) {
    if (response.status == 'connected') {
      alert('logged in');
    } else {
      alert('not logged in');
    }
  });
}

function me() {
  FB.api('/me', { fields: 'id, name, first_name, last_name, email, birthday, gender' }, function(response) {
    if (response.error) {
      alert(JSON.stringify(response.error));
    } else {
      alert(response.name);
      InterestMatch.users.fbConnectUser(response);
    }
  });
}

function friends() {
  FB.api('/me/friends', { fields: 'id, name, picture' },  function(response) {
    if (response.error) {
      alert(JSON.stringify(response.error));
    } else {
      var data = document.getElementById('data');
      fdata=response.data;
      console.log("fdata: "+fdata);
      response.data.forEach(function(item) {
        var d = document.createElement('div');
        d.innerHTML = "<img src="+item.picture+"/>"+item.name;
        data.appendChild(d);
      });
    }

    var friends = response.data;
    console.log(friends.length); 
    for (var k = 0; k < friends.length && k < 200; k++) {
      var friend = friends[k];
      var index = 1;

      friendIDs[k] = friend.id;
      //friendsInfo[k] = friend;
    }
    console.log("friendId's: "+friendIDs);
  });
}

function login() {
  FB.login(
    function(response) {
      if (response.session) {
        alert('logged in');
      } else {
        alert('not logged in');
      }
    },
    { scope: "email" });
}
            
document.addEventListener('deviceready', function() {
  try {
    FB.init({ appId: "687059991327639", nativeInterface: CDV.FB, useCachedDialogs: false });
    document.getElementById('data').innerHTML = "";
  } catch (e) {
    alert(e);
  }
}, false);

