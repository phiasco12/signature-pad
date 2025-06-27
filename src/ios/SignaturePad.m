var originalFormData;
var fileName = '';
var serial_numbers = [];
var asset_sps = [];
var descriptions = [];
var innerNotes = [];
var new_asset_notes = [];
var app = {};
var comps = 0;
var howMany = 0;
var names = [];
var ticketMediaToSend = [];
var results = {};
var viewing = '';
var asset_images = [];
var newTicketImgs = [];
var newTicketasset = [];
var remoerClicked ='';
var removeWithOdometerID = '';
var removeWithOdometerSerial = '';
var count = '';
var current_appendable_assets = [];
var host = 'https://api-tube.com/apps/.orbit4_new/';
var apiType = 'bid';
var addedExtraAsset = [];
var scroller;
var calArray = [];
var combinedNotes = [];
var newAddImgs = [];
var priority = 'Faulty';
var tiAdmin = '';
var ticketDeatilsNotes = [];
var totalUnredOpen = 0;
var totalUnredOpenSub = 0;
var totalUnredOpenDeployed = 0;
var notdetected = 'Not detected';
var techToDeploy = 'other';
var segQuote = [];
var segInvoice = [];
var segWorksheet = [];
var segPurchaseOrders = [];
var filesToUpload = [];
var whoToSend = '';
var newTicketAdminQR = '';
var manualTicketType = '';
var upholsteryImg = 0;
var newTicketType ='';
var engineer_id_isSet = null;
var bottomToolbar = document.querySelector('.bottomToolbar');
var appName = 'O4-v3.1.3';
var oneSignalId = 'c0fb4d70-6ad2-4fb6-b77e-95e225b744cf';
//working onesignal version: https://github.com/OneSignal/OneSignal-Cordova-SDK#3.3.2
//gymBox 81892a9f-2192-4122-a99a-78a8a01a4dc5
//Eleiko 885b726f-4f61-4494-9867-a0fbcf127632"
//Orbit4 c0fb4d70-6ad2-4fb6-b77e-95e225b744cf
        function toggleUniqueContent(contentId, arrowId) {
            var content = document.getElementById(contentId);
            var arrow = document.getElementById(arrowId);
            content.classList.toggle('show');
            arrow.classList.toggle('down');
        }

//format the dates
function convertToReadableDate(dateString) {
    // Create a Date object from the provided string
    const date = new Date(dateString);

    // Extract date components
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, '0'); // Months are zero-indexed
    const day = date.getDate().toString().padStart(2, '0');
    const hours = date.getHours().toString().padStart(2, '0');
    const minutes = date.getMinutes().toString().padStart(2, '0');
    const seconds = date.getSeconds().toString().padStart(2, '0');

    // Construct human-readable date string
    const readableDate = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;

    return readableDate;
}

//modern modal
function addModernSheetModal(options) {
    // Create the main popup container
    const $popup = $('<div/>').addClass('modernpopup');
  
    // Create the inner container to hold the content
    const $popupInner = $('<div/>').addClass('popup-inner');
  
    // Create the swipe handle
    const $swipeHandle = $(`
    <div class="modal-header">
      <div class="swipe-handle"></div>
    </div>
  `);
    // Insert the custom HTML content
    $popupInner.html(options.modalContent);
  
    // Append the swipe handle and inner container to the main popup container
    $popup.append($swipeHandle);
    $popup.append($popupInner);
  
    // Append the popup to the body
    $('body').append('<div class="sheet-backdrop backdrop-in"></div>');
    $('body').append($popup);
  
    // Variables to track swipe movement
    let startY = 0;
    let moveY = 0;
    let isSwiping = false;
  
    // Swipe functionality for the swipe handle
    $swipeHandle.on('touchstart', function(e) {
      startY = e.originalEvent.touches[0].pageY;
      isSwiping = true;
      // Prevent scrolling the background
      e.preventDefault();
    });
  
    $swipeHandle.on('touchmove', function(e) {
      if (!isSwiping) return;
      moveY = e.originalEvent.touches[0].pageY - startY;
  
      if (moveY > 0) { // Downward swipe
        $popup.css('transform', `translateY(${moveY}px)`);
      }
    });
  
    $swipeHandle.on('touchend', function() {
      isSwiping = false;
      if (moveY > 100) { // Threshold for closing
        $popup.remove(); // Remove the popup from the DOM
        $('.sheet-backdrop').remove();
      } else {
        $popup.css('transform', 'translateY(0)'); // Reset position
      }
    });
  
    // Show the popup with a delay to apply the transition
    setTimeout(() => {
      $popup.addClass('modernpopupshow');
    }, 10);
  }
  
  
  

/*setTimeout(doSomething, 5000);

function doSomething() {
  addModernSheetModal({
    modalContent: '<p style="text-align: center;" class="engTitle">tttttttt</p>' +
      '<div class="card custom_card">' +
      '<ons-list class="enginnersList_m">fdsfsdf</ons-list>' +
      '</div>' +
      '<div style="width:100%;display:inline-block;text-align:center;font-weight:bold;margin-bottom:10px;margin-top:10px;" class="trn">OR</div>' +
      '<div style="width:100%;display:inline-block;text-align:center;" class="trn">Invite a new technician</div>' +
      '<div class="card custom_card">' +
      '<input type="email" class="englineerEmailToInv inps" placeholder="Email"/>' +
      '</div>' +
      '<div class="card custom_card">' +
      '<button class="button button--large trn finalDeployEngBtn">Deploy Technician</button>' +
      '</div><p style="text-align: center;" class="engTitle">tttttttt</p>' +
      '<div class="card custom_card">' +
      '<ons-list class="enginnersList_m">fdsfsdf</ons-list>' +
      '</div>' +
      '<div style="width:100%;display:inline-block;text-align:center;font-weight:bold;margin-bottom:10px;margin-top:10px;" class="trn">OR</div>' +
      '<div style="width:100%;display:inline-block;text-align:center;" class="trn">Invite a new technician</div>' +
      '<div class="card custom_card">' +
      '<input type="email" class="englineerEmailToInv inps" placeholder="Email"/>' +
      '</div>' +
      '<div class="card custom_card">' +
      '<button class="button button--large trn finalDeployEngBtn">Deploy Technician</button>' +
      '</div>'
  });
}*/



function insertElementInOrder(elementHtml) {
    var $newElement = $(elementHtml);
    var newElementDate = new Date($newElement.data('created'));
    var inserted = false;

    $('.msg').each(function() {
        var currentElementDate = new Date($(this).data('created'));
        if (newElementDate < currentElementDate && !inserted) {


            $newElement.insertBefore($(this));
            inserted = true;
            return false; // Break the loop
        }

    });

    // If the new element is later than all existing elements or if there are no elements, append it at the end
    if (!inserted) {
        $newElement.insertBefore(".gapper");

    }


}

function formatDate(dateString) {
    const months = ["January", "February", "March", "April", "May", "June",
                    "July", "August", "September", "October", "November", "December"];
    
    const date = new Date(dateString);
    
    // Pad the day and hours with a leading zero if they are less than 10
    const day = String(date.getDate()).padStart(2, '0');
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    
    // Format the date string as requested
    const formattedDate = `${day} ${months[date.getMonth()]} ${date.getFullYear()} @ ${hours}:${minutes}`;
    
    return formattedDate;
}

var barCodeOptions = {
  barcodeFormats: {
    Code128: true,
    Code39: true,
    Code93: true,
    CodaBar: true,
    DataMatrix: true,
    EAN13: true,
    EAN8: true,
    ITF: true,
    QRCode: true,
    UPCA: true,
    UPCE: true,
    PDF417: true,
    Aztec: true,
  },
  beepOnSuccess: false,
  vibrateOnSuccess: false,
  detectorSize: 0.6,
  rotateCamera: false,
};

var showOnsPopover = function(target) {
  document
    .getElementById('popover')
    .show(target);
      setTimeout(function(){
      hideOnsPopover(target);
    },1000);
};

var hideOnsPopover = function() {
  document
    .getElementById('popover')
    .hide();
};

function objectLength(obj) {
  var result = 0;
  for(var prop in obj) {
    if (obj.hasOwnProperty(prop)) {
    // or Object.prototype.hasOwnProperty.call(obj, prop)
      result++;
    }
  }
  return result;
}

const loadStyle = function () {
    let cache = {};
    return function (src) {
        return cache[src] || (cache[src] = new Promise((resolve, reject) => {
            let s = document.createElement('link');
            s.rel = 'stylesheet';
            s.href = src;
            s.onload = resolve;
            s.onerror = reject;
            document.head.append(s);
        }));
    }
}();

var trimString = function (string, length) {
      return string.length > length ? 
             string.substring(0, length) + '...' :
             string;
    };

var hidecalDialog = function() {
  document
    .getElementById('my-calendar-dialog')
    .hide();
};

var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};





function uploadVideo(fileURI) {
    var serverUrl = host + 'postNewTicketMedia.php'; // Replace this with your PHP upload script URL
    var uuid = localStorage.getItem('uuid');
    var email = localStorage.getItem('email');
    var accessToken = localStorage.getItem('accesstoken');

    if (fileURI.startsWith('/private/')) {
        fileURI = 'file://' + fileURI;
    }

    $('.customProgreesBar').removeClass('customProgreesBarHidden');
    $('.customProgreesBar').addClass('customProgreesBarShown');
    $('.progress-percentage').text('0%').show();

    // Read the file as Blob object
    window.resolveLocalFileSystemURL(fileURI, function(fileEntry) {
        fileEntry.file(function(file) {
            var reader = new FileReader();
            reader.onloadend = function() {
                var blob = new Blob([new Uint8Array(this.result)], { type: "video/mp4" });

                // Create FormData object and append file and variables
                var formData = new FormData();
                formData.append('video', blob);
                formData.append('uuid', uuid);
                formData.append('email', email);
                formData.append('accessToken', accessToken);
                formData.append('type', 'video');

                // Create XMLHttpRequest for file upload
                var xhr = new XMLHttpRequest();

                xhr.open("POST", serverUrl, true);

                // Set up a handler for the progress event
                xhr.upload.addEventListener("progress", function(evt) {
                    if (evt.lengthComputable) {
                        var percentComplete = Math.round((evt.loaded / evt.total) * 100);
                        document.querySelector('.customProgreesBar').value = percentComplete;
                        document.querySelector('.progress-percentage').textContent = percentComplete + '%';

                        // Adjust the position of the percentage text
                        var progressBarWidth = document.querySelector('.customProgreesBar').offsetWidth;
                        var progressPercentageWidth = document.querySelector('.progress-percentage').offsetWidth;
                        var leftPosition = (progressBarWidth * (percentComplete / 100)) - (progressPercentageWidth / 2);
                        document.querySelector('.progress-percentage').style.left = leftPosition + 'px';
                    }
                }, false);

                // Set up a handler for the load event
                xhr.addEventListener("load", function() {
                    if (xhr.status >= 200 && xhr.status < 300) {
                        var responseData = JSON.parse(xhr.responseText);
                        console.log("Upload successful:", responseData);

                        // Extract video URL from the response data
                        const videoUrl = responseData.note.media.url;

                        // Add video to page here
                        $('.imghistory').append("<div class='grid__photo' style='overflow:hidden;position: relative;'><video class='custom-video' style='width: 100%;height: 100%;top: 0;left: 0;padding:0;margin:0;' src='" + videoUrl + "#t=0.2'></video><button class='play-pause-button'></button></div>");
                        $('.customProgreesBar').addClass('customProgreesBarHidden');
                        $('.progress-percentage').hide();
                    } else {
                        console.error("Upload failed:", xhr.statusText);
                        $('.customProgreesBar').addClass('customProgreesBarHidden');
                        $('.progress-percentage').hide();
                    }
                });

                // Set up a handler for the error event
                xhr.addEventListener("error", function() {
                    console.error("Upload error:", xhr.statusText);
                    $('.customProgreesBar').addClass('customProgreesBarHidden');
                    $('.progress-percentage').hide();
                });

                // Send the FormData object to the server
                xhr.send(formData);
            };
            reader.readAsArrayBuffer(file);
        });
    }, function(error) {
        console.error("File system error:", error);
    });
}


///function to send video to server to store it when raiusing tickets
function uploadTicketRaisingVideo(fileURI) {
    var serverUrl = ''+host+'uploadMedia_API.php'; // Replace this with your PHP upload script URL
    if (fileURI.startsWith('/private/')) {
        fileURI = 'file://' + fileURI;
    }
    // Read the file as Blob object
    window.resolveLocalFileSystemURL(fileURI, function(fileEntry) {
        fileEntry.file(function(file) {
            var reader = new FileReader();
            reader.onloadend = function() {
                var blob = new Blob([new Uint8Array(this.result)], { type: "video/mp4" });

                // Create FormData object and append file and variables
                var formData = new FormData();
                formData.append('video', blob);
                formData.append('type', 'video');
formData.append('fileName', fileName);
                // Send the FormData object to the server
                fetch(serverUrl, {
                    method: "POST",
                    body: formData
                })
                .then(function(response) {
                    if (response.ok) {
                        return response.text();
                    } else {
                        throw new Error("Upload failed: " + response.statusText);
                    }
                })
                .then(function(responseText) {
 

                    var response = JSON.parse(responseText);

                    var status = response[0].status;
        var url = response[0].url;
        
        // Use the data as needed
        console.log('Status:', status);
        console.log('URL:', url);


        if(status == 'OK'){
$('.fakeVid').remove();

$('.videoPrev').append("<div class='video-container' style='position: relative;width: 100%;padding-top: 56.25%;'><video style='position: absolute;width: 100%;height: 100%;top: 0;left: 0;' src='" + url + "#t=0.2' controls></video></div>");
                    }
                   
                })
                .catch(function(error) {
                    console.error("Upload error:", error);
                });
            };
            reader.readAsArrayBuffer(file);
        });
    });
}

function recordVideo() {
    var pmodal = document.getElementById('preloaderModal');
    pmodal.show();

    var captureSuccess = function(mediaFiles) {
        // Get the navigator element
        var navigator = document.querySelector('ons-navigator');
        // Get the current page object
        var currentPage = navigator.topPage;
        // Get the ID of the current page
        var currentPageId = currentPage.id;

        if (currentPageId !== 'ticket-details') {
            // Display the video in raising tickets sections
            $('.videoPrev').append(
                "<div class='video-container fakeVid' style='position: relative;width: 100%;padding-top: 56.25%;'>" +
                "<div class='preloader' style='position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: rgba(255, 255, 255, 0.8); z-index: 10;'>" +
                "<div style='position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); text-align: center;'>" +
                "<div style='display: inline-block; position: relative; width: 64px; height: 64px;'>" +
                "<div style='border: 6px solid #3498db; border-top: 6px solid transparent; border-radius: 50%; width: 50px; height: 50px; animation: spin 1s linear infinite;'></div>" +
                "</div>" +
                "<p style='font-size: 16px; margin-top: 10px;'>Processing the video</p>" +
                "</div>" +
                "</div>" +
                "<video style='position: absolute;width: 100%;height: 100%;top: 0;left: 0;' src='' controls></video>" +
                "</div>"
            );
            $('.TicketImgRaise').show();
        }

        var i, path, len;
        for (i = 0, len = mediaFiles.length; i < len; i += 1) {
            path = mediaFiles[i].fullPath;

            // Replace /private/ with file://
            if (path.startsWith('/private/')) {
                path = 'file://' + path;
            }

            console.log('Captured file path:', path);

            window.resolveLocalFileSystemURL(path, function(fileEntry) {
                fileEntry.file(function(file) {
                    var reader = new FileReader();
                    reader.onloadend = function() {
                        var dataURL = reader.result;

                        if (currentPageId == 'ticket-details') {
                            // Upload the video here
                            uploadVideo(path);

                            //console.log(dataURL);

                            
                        } else {
                            // Upload the video here
                            uploadTicketRaisingVideo(path);
                        }
                    };
                    reader.readAsDataURL(file);
                }, function(fileError) {
                    console.error('File entry error:', fileError);
                });
            }, function(fileURIError) {
                console.error('Resolve file URI error:', fileURIError);
            });
        }

        pmodal.hide();
    };

    var captureError = function(error) {
        pmodal.hide();
        navigator.notification.alert('Error code: ' + error.code, null, 'Capture Error');
    };

    // Start video capture
    navigator.device.capture.captureVideo(captureSuccess, captureError, { limit: 1, duration: 20, cameraDirection: 1 });
}

function recordAudio() {
    // capture callback
var captureSuccess = function(mediaFiles) {
    var i, path, len;
    for (i = 0, len = mediaFiles.length; i < len; i += 1) {
        path = mediaFiles[i].fullPath;
        // do something interesting with the file

         navigator.notification.alert('The media has been captured and the path to the video is: ' +path);
    }
};

// capture error callback
var captureError = function(error) {
    navigator.notification.alert('Error code: ' + error.code, null, 'Capture Error');
};

// start video capture
navigator.device.capture.captureAudio(captureSuccess, captureError, {limit:1});

};

function openCamera() {


navigator.camera.getPicture(onSuccess, onFail, { 
    quality: 100,
    destinationType: Camera.DestinationType.DATA_URL,
    sourceType: Camera.PictureSourceType.CAMERA,
    encodingType: Camera.EncodingType.JPEG,
       targetWidth: screen.width,
    targetHeight: screen.height,
    correctOrientation: true
});

function onSuccess(imageData) {
   

var page = document.querySelector('#myNavigator').topPage.id;



 if(page == 'raise'){
     
     newTicketImgs.push("data:image/jpeg;base64,"+imageData+"");

var serial = $('.addAassetBtn:last').attr('data-serial');
var item = newTicketasset.find(item => item.serial === serial);


var note = item.note;

newTicketasset = newTicketasset.filter(function( obj ) {
  return obj.serial !== serial;
});


var assetToAdd = {
  "serial": serial,
  "note": note,
  "image": "data:image/jpeg;base64,"+imageData+"",
}

newTicketasset.push(assetToAdd);


console.log(JSON.stringify(newTicketasset));


 }else{

$('.addedImgs').html('<img src="data:image/jpeg;base64,'+imageData+'">');

var serial = localStorage.getItem('serial-inner');

var modal = document.getElementById('ConfirmImageModal');
modal.show();
localStorage.setItem('imgToSend', "data:image/jpeg;base64,"+imageData+"");

 }


}

function onFail(message) {
var page = document.querySelector('#myNavigator').topPage.id;
if(page == 'raise'){
     newTicketImgs.push(null);
 }

}

    };

    
    function openGal() {


navigator.camera.getPicture(onSuccess, onFail, { 

        quality: 100,
        destinationType: Camera.DestinationType.DATA_URL,
        // In this app, dynamically set the picture source, Camera or photo gallery
        sourceType: Camera.PictureSourceType.PHOTOLIBRARY,
        encodingType: Camera.EncodingType.JPEG,
       targetWidth: screen.width,
    targetHeight: screen.height,
        correctOrientation: true
});

function onSuccess(imageData) {

var page = document.querySelector('#myNavigator').topPage.id;

  if(page == 'raise'){
     
     newTicketImgs.push("data:image/jpeg;base64,"+imageData+"");

var serial = $('.addAassetBtn:last').attr('data-serial');
var item = newTicketasset.find(item => item.serial === serial);


var note = item.note;

newTicketasset = newTicketasset.filter(function( obj ) {
  return obj.serial !== serial;
});


var assetToAdd = {
  "serial": serial,
  "note": note,
  "image": "data:image/jpeg;base64,"+imageData+"",
}

newTicketasset.push(assetToAdd);


console.log(JSON.stringify(newTicketasset));





 }else{




$('.addedImgs').html('<img src="data:image/jpeg;base64,'+imageData+'">');


var serial = localStorage.getItem('serial-inner');

var modal = document.getElementById('ConfirmImageModal');
modal.show();
localStorage.setItem('imgToSend', "data:image/jpeg;base64,"+imageData+"");

 }


}

function onFail(message) {
var page = document.querySelector('#myNavigator').topPage.id;
if(page == 'raise'){
     newTicketImgs.push(null);
 }
}

    };

    var showTemplateDialog = function() {
  var dialog = document.getElementById('my-dialog');

  if (dialog) {
    dialog.show();
  } else {
    ons.createElement('dialog.html', { append: true })
      .then(function(dialog) {
        dialog.show();
      });
  }
};

var showTemplateDialog2 = function() {
  var dialog = document.getElementById('my-dialog2');

  if (dialog) {
    dialog.show();
  } else {
    ons.createElement('dialog2.html', { append: true })
      .then(function(dialog) {
        dialog.show();
      });
  }
};

var hideDialog = function(id) {
  document
    .getElementById(id)
    .hide();
};




  function getMobileOperatingSystem() {
  var userAgent = navigator.userAgent || navigator.vendor || window.opera;




  if( userAgent.match( /iPad/i ) || userAgent.match( /iPhone/i ) || userAgent.match( /iPod/i ) || userAgent.match( /Macintosh/i ) )
  {

localStorage.setItem('deviceType', 'iOS');
    

  }
  else if( userAgent.match( /Android/i ) )
  {

localStorage.setItem('deviceType', 'Android');
   
  }
  else
  {
    //alert('unknown'); 
  }
}


getMobileOperatingSystem();

document.addEventListener("offline", onOffline, false);

function onOffline() {
    // Handle the offline event

    var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};

app.showFromObject = function () {
  ons.openActionSheet({
    title: 'Select a settings option',
    //cancelable: true,
    buttons: [
      'WIFI Settings',
      'Mobile Data Settings',
      {
        label: 'Cancel',
        icon: 'md-close',
        modifier: 'destructive'
      }
    ]
  }).then(function (index) { 

if (index == 0){

  if (window.cordova && window.cordova.plugins.settings) {
    console.log('openNativeSettingsTest is active');
    window.cordova.plugins.settings.open("wifi", function() {
            console.log('opened settings');
        },
        function () {
            console.log('failed to open settings');
        }
    );
} else {
    console.log('openNativeSettingsTest is not active!');
}

}

if (index == 1){

var de = localStorage.getItem('deviceType');

if (de == 'iOS'){

  if (window.cordova && window.cordova.plugins.settings) {
    console.log('openNativeSettingsTest is active');
    window.cordova.plugins.settings.open("mobile_data", function() {
            console.log('opened settings');
        },
        function () {
            console.log('failed to open settings');
        }
    );
} else {
    console.log('openNativeSettingsTest is not active!');
}

}else{


if (window.cordova && window.cordova.plugins.settings) {
    console.log('openNativeSettingsTest is active');
    window.cordova.plugins.settings.open("data_roaming", function() {
            console.log('opened settings');
        },
        function () {
            console.log('failed to open settings');
        }
    );
} else {
    console.log('openNativeSettingsTest is not active!');
}

}

  

}



   });
};


var notify = function() {





var lang = localStorage.getItem('lang');

function alertDismissed() {
    // do something
}

var offlineMessage;

if (lang == 'ge') {
    offlineMessage = 'Du bist offline! Bitte stellen Sie eine Verbindung zum Internet her, bevor Sie diese App verwenden. Für diese App und ihre Inhalte ist eine Internetverbindung erforderlich.';
} else if (lang == 'po') {
    offlineMessage = 'Você está offline! Por favor, conecte-se à internet antes de usar este aplicativo. Este aplicativo e seu conteúdo exigem conexão com a internet.';
} else if (lang == 'sp') {
    offlineMessage = 'Estás fuera de línea! Por favor, conéctate a internet antes de usar esta aplicación. Esta aplicación y su contenido requieren conexión a internet.';
} else if (lang == 'bul') {
    offlineMessage = 'Вие сте извън линия! Моля, свържете се с интернет, преди да използвате този приложение. Това приложение и неговото съдържание изискват интернет връзка.';
} else if (lang == 'it') {
    offlineMessage = 'Sei offline! Si prega di connettersi a Internet prima di utilizzare questa app. Questa app e il suo contenuto richiedono una connessione a Internet.';
} else if (lang == 'fr') {
    offlineMessage = 'Vous êtes hors ligne ! Veuillez vous connecter à Internet avant d\'utiliser cette application. Cette application et son contenu nécessitent une connexion Internet.';
}else if (lang == 'ar') {
    offlineMessage = 'أنت غير متصل بالإنترنت! يرجى الاتصال بالإنترنت قبل استخدام هذا التطبيق. هذا التطبيق ومحتواه يتطلبان اتصالاً بالإنترنت.';
}else if (lang == 'ja') {
offlineMessage = 'オフラインです！このアプリを使用する前にインターネットに接続してください。このアプリおよびそのコンテンツの使用にはインターネット接続が必要です。';
}else if (lang == 'tu') {
offlineMessage = 'Çevrimdışı! Bu uygulamayı kullanmadan önce lütfen internete bağlanın. Bu uygulamanın ve içeriğinin kullanılması internet bağlantısı gerektirir.';
} else {
    // Default to the original text if the language code is not recognized
    offlineMessage = 'You are offline! Please connect to the internet before using this App. This App and its content require an internet connection.';
}

// Now you can use the variable offlineMessage in your code.
navigator.notification.alert(offlineMessage, alertDismissed, 'Error', 'OK');





  //ons.notification.alert('');
};

notify();
}

    function logout(){


$(".goToUh").attr("class", "go-el myColHolder goToUh goToUpholsteryBtn");
var fingerPrintToken = localStorage.getItem('fingerPrintToken');
var fingerPrintUserName = localStorage.getItem('fingerPrintUserName');


var faceusername = localStorage.getItem('faceid_username');
var facepassword = localStorage.getItem('faceid_password');

var updateDate = localStorage.getItem('updateDate');
var externalUserId = localStorage.getItem('device_id');


        $('.cost-dialog').remove();
        $('.transfer-dialog').remove();
$('.textCanvas').show();
var colors = ['#0a6125', '#00aeef', '#a5c432', '#3498DB;'];
var random_color = colors[Math.floor(Math.random() * colors.length)];
var tCtx = document.getElementById('textCanvas').getContext('2d');
var canvas = document.getElementById("textCanvas");
  canvas.width = $(".homeAvi").width();
  canvas.height = $(".homeAvi").height();
canvas.style.backgroundColor = random_color

   //$('.langSelector').removeClass('animated fadeOut');
   //$('.langSelector').removeClass('animated rubberBand');
   $('.langHolder').removeClass('animated bounceOutDown');

        $('.pncircle').remove();

      var deviceToken = localStorage.getItem('device_id');

      localStorage.clear();

      localStorage.setItem('fingerPrintToken', fingerPrintToken);
        localStorage.setItem('fingerPrintUserName', fingerPrintUserName);


localStorage.setItem('faceid_username', faceusername);
localStorage.setItem('faceid_password', facepassword);
localStorage.setItem('updateDate', updateDate);
localStorage.setItem('device_id', externalUserId);
//document.querySelector('#myNavigator').popPage();

var modal = document.getElementById('loginmodal');
modal.show();

//localStorage.setItem('device_id', deviceToken);


    }

    function callQRscanner(){

      var lang = localStorage.getItem('lang');
      
if (lang == 'ge') {
    
    $('.sepratorHolder').html('<div class="separator qrTA">Wer sollte dieses Ticket erhalten?</div>');
} else if (lang == 'en') {
    $('.sepratorHolder').html('<div class="separator qrTA">Who should receive this ticket?</div>');
} else if (lang == 'po') {
    $('.sepratorHolder').html('<div class="separator qrTA">Não há histórico de serviço</div>');
} else if (lang == 'sp') {
    $('.sepratorHolder').html('<div class="separator qrTA">No hay historial de servicio</div>');
} else if (lang == 'fr') {
    $('.sepratorHolder').html('<div class="separator qrTA">Il n\'y a pas d\'historique de service</div>');
} else if (lang == 'it') {
    $('.sepratorHolder').html('<div class="separator qrTA">Non ci sono precedenti di servizio</div>');
} else if (lang == 'bul') {
    $('.sepratorHolder').html('<div class="separator qrTA">Няма история на обслужване</div>');
}else if (lang == 'ar') {
    offlineMessage = '<div class="separator qrTA">من يجب أن يتلقى هذه البطاقة؟</div>';
}else if (lang == 'ja') {
    offlineMessage = '<div class="separator qrTA">このカードを受け取るべき人は誰ですか？</div>';
}else if (lang == 'tu') {
    offlineMessage = '<div class="separator qrTA">Bu kartı alması gereken kişi kimdir?</div>';

}

var pr = localStorage.getItem('permissions_raise_internal_ticket');

/*if(pr == 'false' || pr == false){
$('.btnsHolder').hide();
$('.proceedbtns').show();
}else{
$('.btnsHolder').show();
$('.proceedbtns').hide();
}*/

if (lang == 'ge') {
    notdetected = 'QR-Code nicht erkannt';
} else if (lang == 'po') {
    notdetected = 'Código QR não reconhecido';
} else if (lang == 'sp') {
    notdetected = 'Código QR no reconocido';
} else if (lang == 'bul') {
    notdetected = 'QR-кодът не е разпознат';
} else if (lang == 'it') {
    notdetected = 'Codice QR non riconosciuto';
} else if (lang == 'fr') {
    notdetected = 'Code QR non reconnu';
} else if (lang == 'ar') {
    notdetected = 'رمز الاستجابة السريعة غير معروف';
}  else if (lang == 'ja') {
    notdetected = 'QRコードが見つかりません';
}  else if (lang == 'tu') {
    notdetected = 'QR kodu bulunamadı';

}else {
    // Default to the original text if the language code is not recognized
    notdetected = 'QR Code not detected';
}



 //check the devce type here
//SpinnerDialog.show(null, "Please wait...");

//start of the scanner...

cordova.plugins.mlkit.barcodeScanner.scan(
  barCodeOptions,
  (result) => {

      var serial = result.text;

/*monaca.BarcodeScanner.scan((result) => {
  if (result.cancelled) {
      // scan cancelled
   } else {

const serial = result.data.text;*/




localStorage.setItem('c_serial', serial);
var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

//$(this).prop('disabled', true);
//$('.loaderIcon').show();

var pmodal = document.getElementById('preloaderModal');
pmodal.show();

var permissions_raise_ticket = localStorage.getItem('permissions_raise_ticket');
var permissions_assign_ticket_admins = localStorage.getItem('permissions_assign_ticket_admins');
var permissions_manage_ticket_admins = localStorage.getItem('permissions_manage_ticket_admins');
var permissions_assign_caretakers = localStorage.getItem('permissions_assign_caretakers');
var permissions_manage_caretakers = localStorage.getItem('permissions_manage_caretakers');
var permissions_manage_engineers = localStorage.getItem('permissions_manage_engineers');
var permissions_raise_internal_ticket = localStorage.getItem('permissions_raise_internal_ticket');
var permissions_raise_adhoc_ticket = localStorage.getItem('permissions_raise_adhoc_ticket');


//this is where we will change the whole thing


var values = { 
    'email': email,
    'accesstoken': accesstoken,
};

    $.ajax({
    url: ''+host+'getTicketAdmins_new.php',
    //dataType: 'text',
     //dataType: 'text',
    data: values,
    type: 'POST',
    success: function( data, textStatus, jQxhr ){

    var json = JSON.stringify(data);

    $('.selectAdminDropDown').empty();
    $('.proceedBtnsHolder').hide();
tiAdmin = '';

  var parsed_data = JSON.parse(data);
if(parsed_data['status'] == 'OK'){
  for(i=0;i<parsed_data.ticket_admins.length;i++){

if (parsed_data.ticket_admins.length === 1) {
        // Only one ticket_admins
       $('.tawhom').click();
       $('.chooseAdminTicketSection').hide();
    } else if (parsed_data.ticket_admins.length > 1) {
        // More than one ticket_admins
        //alert('there are multiple TAs');
    } else {
        // No ticket_admins
        //alert('there is no TA');
    }

var full_name = parsed_data.ticket_admins[i].name;
var id = parsed_data.ticket_admins[i].id;
var email = parsed_data.ticket_admins[i].email;
var status = parsed_data.ticket_admins[i].status;


//new edits here

//whoToSend = 'ta';

if(parsed_data.ticket_admins.length > 1){

 $('.qrTA_card').show();
$('.custom_card').show();

$('.qrTA').show();


if(status == 'pending'){

 $('.selectAdminDropDown').append('<ons-list-item class="taSelector" data-value="'+id+'" tappable>'+
      '<label class="floatingRadio" data-value="'+id+'">'+full_name+
        '<ons-radio style="display:none;width:100% !important;text-align:center;" name="ta" class="taRadio" input-id="radio-'+id+'" value="'+id+'">'+full_name+'</ons-radio>'+
      '</label>'+
'</ons-list-item>');

}else{


     $('.selectAdminDropDown').append('<ons-list-item class="taSelector" data-value="'+id+'" tappable>'+
      '<label class="floatingRadio" data-value="'+id+'">'+full_name+' - '+email+
        '<ons-radio style="display:none;width:100% !important;text-align:center;" name="ta" class="taRadio" input-id="radio-'+id+'" value="'+id+'">'+full_name+' - '+email+'</ons-radio>'+
      '</label>'+
'</ons-list-item>');

}

}else{



   tiAdmin = id;

 /*$('.selectAdminDropDown').append('<ons-list-item class="taSelector" data-value="'+id+'" tappable>'+
      '<div class="floatingRadio" data-value="'+id+'">'+full_name+' - '+email+
        '<ons-radio style="display:none;width:100% !important;text-align:center;" name="ta" class="taRadio" input-id="radio-'+id+'" value="'+id+'" checked>'+full_name+' - '+email+'</ons-radio>'+
      '</div>'+
'</ons-list-item>');*/


//$('.qrTA').show();

$('.qrTA_card').hide();
$('.custom_card').hide();
$('.qrTA').hide();
$('.proceedbtns').show();


}

  }

}

    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
    }
});


$.ajax({
    url: ''+host+'getAsset.php?serial='+serial+'&email='+email+'&accesstoken='+accesstoken+'&force=1',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

var pmodal = document.getElementById('preloaderModal');
pmodal.hide();


console.log(data);

    var json = JSON.stringify(data);

     //var obj = parseJSON(data);
  var parsed_data = JSON.parse(data);

if(parsed_data['status'] == 'OK'){

var active_seller_packages_array = parsed_data.asset['active_seller_packages'];

var pr = localStorage.getItem('permissions_raise_internal_ticket');

//they can raise internal ticket
///////if(pr == 'true'){

$('.spgoholderClose').show();

if(parsed_data.asset['open_ticket'] == null){

var serial = parsed_data.asset['serial_number'];
var manufacturer_serial_number = parsed_data.asset['manufacturer_serial_number'];

var active_seller_packages = parsed_data.asset['active_seller_packages'];

console.log(JSON.stringify(parsed_data.asset['active_seller_packages']));

count = _.countBy(active_seller_packages, obj => obj.lot_title !== '');


if(count.true > 1){


//var modal = document.getElementById('spSelect');
  //modal.show({animation: 'lift'});



localStorage.setItem('moreSp', 'yes');

$('.spList').html('');



for(i=0;i<parsed_data.asset.active_seller_packages.length;i++){


var lot_title = parsed_data.asset.active_seller_packages[i].lot_title;
var company_name = parsed_data.asset.active_seller_packages[i].buyer.buyer_profile.company_name;


var sp = '<ons-list-item modifier="chevron" class="spSelectBtn" data-title="'+lot_title+'" data-company="'+company_name+'" data-serial="'+serial+'" style="bakcground:black !important;" tappable>'+lot_title+' '+company_name+'</ons-list-item>';


$('.spList').append(sp);


}



}else{

localStorage.setItem('moreSp', 'no');

}
  
  
$('.addAassetBtn').attr('data-serial', serial);


var max_spend_percentage = parsed_data.asset['max_spend_percentage'];

if (max_spend_percentage > 100){


var lang = localStorage.getItem('lang');


var alertTitle, alertMessage;

if (lang == 'ge') {
    alertTitle = 'Achtung';
    alertMessage = 'Das maximale Ausgabenbudget für Asset ' + serial + ' wurde erreicht. Bitte erhöhen Sie das maximale Ausgabenlimit für diesen Vermögenswert.';
} else if (lang == 'po') {
    alertTitle = 'Atenção';
    alertMessage = 'O orçamento máximo de gastos para o ativo ' + serial + ' foi atingido. Por favor, aumente o limite máximo de gastos para este ativo.';
} else if (lang == 'sp') {
    alertTitle = 'Atención';
    alertMessage = 'Se ha alcanzado el presupuesto máximo de gastos para el activo ' + serial + '. Por favor, aumente el límite máximo de gastos para este activo.';
} else if (lang == 'bul') {
    alertTitle = 'Внимание';
    alertMessage = 'Максималният бюджет за разходи за актива ' + serial + ' е достигнат. Моля, увеличете максималния лимит за разходи за този актив.';
} else if (lang == 'it') {
    alertTitle = 'Attenzione';
    alertMessage = 'Il budget massimo di spesa per l\'asset ' + serial + ' è stato raggiunto. Si prega di aumentare il limite massimo di spesa per questo asset.';
} else if (lang == 'fr') {
    alertTitle = 'Attention';
    alertMessage = 'Le budget maximal de dépenses pour l\'actif ' + serial + ' a été atteint. Veuillez augmenter la limite maximale de dépenses pour cet actif.';
} else if (lang == 'ar') {
    alertTitle = 'تنبيه';
    alertMessage = '.تم الوصول إلى الحد الأقصى لميزانية النفقات للأصل ' + serial + '. يرجى زيادة الحد الأقصى للنفقات لهذا الأصل';
}else if (lang == 'ja') {
alertTitle = '警告';
alertMessage = 'アセット ' + serial + ' の経費予算上限に達しました。このアセットの経費予算上限を増やしてください。';
}else if (lang == 'tu') {
alertTitle = 'Uyarı';
alertMessage = serial + ' seri numaralı varlığın harcama bütçesi sınırına ulaşıldı. Bu varlığın harcama bütçesi sınırını artırın, lütfen.';

}else {
    // Default to English if the language code is not recognized
    alertTitle = 'Attention';
    alertMessage = 'The maximum spend budget has been reached for asset ' + serial + '. Please raise the maximum spend limit for this asset.';
}

function alertDismissed() {
    // Do something when the alert is dismissed
}

navigator.notification.alert(
    alertMessage,  // message
    alertDismissed,         // callback
    alertTitle,            // title
    'OK'                  // buttonName
);

}//else{


var fullname = parsed_data.asset['full_name'];

var active_seller_packages = parsed_data.asset['active_seller_packages'];
$(".serviceConractSelect").empty();


console.log(JSON.stringify(parsed_data.asset.active_seller_packages));

for(i=0;i<parsed_data.asset.active_seller_packages.length;i++){




var cname= parsed_data.asset.active_seller_packages[i].buyer.buyer_profile.company_name;
var lot_title = parsed_data.asset.active_seller_packages[i].lot_title;

//adding sps here
$('.serviceConractSelect').append('<option value="'+lot_title+'">'+lot_title+' - '+cname+'</option>');


    if (parsed_data.asset.active_seller_packages.length === 1) {
        // Only one ticket_admins
        //alert('there is only 1 SP');
       $('.spwhom').click();
       $('.serviceContactHolder').hide();

    } else if (parsed_data.asset.active_seller_packages.length > 1) {
        // More than one ticket_admins
        //alert('there are multiple SPs');
    } else {
        // No ticket_admins
        //alert('there is no SP');
    }

}


$('.assetFullname').text(fullname);

if (parsed_data.asset['image'] == null) {
var pmodal = document.getElementById('preloaderModal');
pmodal.hide();



$('.assetImgShow').html("<ons-list-item ><div class='left' style='margin-right:10px;'><img class='list-item__thumbnail largeThumb' src='images/no_img.jpg'></div><div class='center'><span class='list-item__title smallerTitle'>"+fullname+"</span><span class='list-item__subtitle'><span class='trn'>Serial No':</span> "+manufacturer_serial_number+"</span><span class='list-item__subtitle'><span class='trn'>QR No':</span> "+serial+"</span></div></ons-list-item>");


}else{

var image = parsed_data.asset['image']['large'];


console.log('url(https://'+apiType+'.weservicegymequipment.com/'+image+') no-repeat center center');

$('.assetImgShow').html("<ons-list-item ><div class='left' style='margin-right:10px;'><img class='list-item__thumbnail largeThumb' src='https://"+apiType+".weservicegymequipment.com/"+image+"'></div><div class='center'><span class='list-item__title smallerTitle'>"+fullname+"</span><span class='list-item__subtitle'><span class='trn'>Serial No':</span> "+manufacturer_serial_number+"</span><span class='list-item__subtitle'><span class='trn'>QR No':</span> "+serial+"</span></div></ons-list-item>");

$('.addAassetBtn').attr('data-image', 'https://'+apiType+'.weservicegymequipment.com/'+image+'');

$('.imgRemover').attr('data-serial', serial);
 




}



//$('.asset_note').remove();
//$('<textarea class="asset_note trn" data-prev="" style="box-sizing: border-box; display: inline-block; min-height: 70px;  width: calc(100% - 18px);margin-left: 9px;margin-right: 9px;" placeholder="Write full description of the fault"></textarea>').insertAfter('.after');
  var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);


$('.toAddAsset').hide();
$('.newqrCaller').hide();
$('.proceedbtns').hide();
$('.scanUph').hide();
$('.raiseTicketOptions').show();
$('.assetsSelect').empty();
$('.assetsSelect').append('<option class="trn" value="'+serial+'">'+serial+'</option>');

$('.assetsQR').append('<ons-button id="'+serial+'" data-note="" data-serial="'+serial+'" data-name="'+fullname+'" data-image="" class="addedAsset '+serial+'" modifier="large">'+fullname+'</ons-button>');


//check if they can rasie TA and Ad-hoc ticket    
var pr = localStorage.getItem('permissions_raise_internal_ticket');
var pr2 = localStorage.getItem('permissions_raise_adhoc_ticket');
var pr3 = localStorage.getItem('permissions_manage_engineers');
var pr4 = localStorage.getItem('permissions_manage_caretakers');
var pr5 = localStorage.getItem('permissions_assign_caretakers');

var pr6 = localStorage.getItem('permissions_assign_ticket_admins');
var pr7 = localStorage.getItem('permissions_manage_ticket_admins');

var pr8 = localStorage.getItem('permissions_raise_ticket');


if((pr == 'true' || pr == true) && (pr5 == true || pr5 == 'true')){
$('.intwhom').show();
}

if(pr6 == 'true' || pr6 == true){
$('.tawhom').show();
}


if(pr8 == 'true' || pr8 == true){
$('.spwhom').show();
}


 const fieldset = document.querySelector('.custominputTextWrap');
  const catiElements = Array.from(fieldset.querySelectorAll('.cati_4'));

  function updateLayout() {
    const visibleCatiElements = catiElements.filter(el => getComputedStyle(el).display !== 'none');
    
    fieldset.classList.remove('one-visible', 'two-visible', 'three-visible');
    
    if (visibleCatiElements.length === 1) {
      fieldset.classList.add('one-visible');
    } else if (visibleCatiElements.length === 2) {
      fieldset.classList.add('two-visible');
    } else if (visibleCatiElements.length === 3) {
      fieldset.classList.add('three-visible');
    }
  }

  // Initial check
  updateLayout();



var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

var values = { 
    'email': email,
    'accesstoken': accesstoken,
};


//get ticket admins here
    $.ajax({
    url: ''+host+'getTicketAdmins_new.php',
    //dataType: 'text',
     //dataType: 'text',
    data: values,
    type: 'POST',
    success: function( data, textStatus, jQxhr ){

    var json = JSON.stringify(data);

    console.log(data);

     //var obj = parseJSON(data);
  var parsed_data = JSON.parse(data);
if(parsed_data['status'] == 'OK'){
  for(i=0;i<parsed_data.ticket_admins.length;i++){
var full_name = parsed_data.ticket_admins[i].name;
var id = parsed_data.ticket_admins[i].id;
var email = parsed_data.ticket_admins[i].email;
var status = parsed_data.ticket_admins[i].status;
$('.ticketAdminSelect').append('<option value="'+id+'">'+full_name+' ('+email+')</option>');

  }
}else{

console.log(data);
var parsed_data = JSON.parse(data);

    var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

function alertDismissed() {

}

navigator.notification.alert(
    parsed_data['msg'],  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);

}
    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
    }
});


//get internal techs here...
 $.ajax({
    url: ''+host+'getCareTakers.php',
    //dataType: 'text',
     //dataType: 'text',
    data: values,
    type: 'POST',
    success: function( data, textStatus, jQxhr ){

    var json = JSON.stringify(data);

    console.log(data);

     //var obj = parseJSON(data);
  var parsed_data = JSON.parse(data);
if(parsed_data['status'] == 'OK'){
  for(i=0;i<parsed_data.caretakers.length;i++){
var full_name = parsed_data.caretakers[i].name;
var id = parsed_data.caretakers[i].id;
var email = parsed_data.caretakers[i].email;
$('.inetrnalTechSelect').append('<option value="'+id+'">'+full_name+'</option>');

  }
}else{

console.log(data);
var parsed_data = JSON.parse(data);

    var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

function alertDismissed() {

}

navigator.notification.alert(
    parsed_data['msg'],  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);

}
    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
    }
});

var modal = document.getElementById('assetmodal');
modal.show({animation: 'lift'});




//}

}else{
//it has open tickets

var lang = localStorage.getItem('lang');


var alertTitle, alertMessage;

if (lang == 'ge') {
    alertTitle = 'Achtung';
    alertMessage = 'Für dieses Gerät wurde bereits ein Serviceticket erstellt';
} else if (lang == 'po') {
    alertTitle = 'Atenção';
    alertMessage = 'Já foi criado um ticket de serviço para este ativo.';
} else if (lang == 'sp') {
    alertTitle = 'Atención';
    alertMessage = 'Ya se ha creado un ticket de servicio para este activo.';
} else if (lang == 'bul') {
    alertTitle = 'Внимание';
    alertMessage = 'Вече е създаден билет за обслужване за този актив.';
} else if (lang == 'it') {
    alertTitle = 'Attenzione';
    alertMessage = 'È già stato creato un ticket di servizio per questa risorsa.';
} else if (lang == 'fr') {
    alertTitle = 'Attention';
    alertMessage = 'Un ticket de service a déjà été créé pour cet actif.';
} else if (lang == 'ar') {
    alertTitle = 'تنبيه';
    alertMessage = 'تم إنشاء تذكرة خدمة بالفعل لهذا الأصل';
} else if (lang == 'ja') {
alertTitle = '警告';
alertMessage = 'このアセットにはすでにサービスチケットが作成されています。';

} else if (lang == 'tu') {
alertTitle = 'Uyarı';
alertMessage = 'Bu varlığa zaten bir hizmet bileti oluşturulmuştur.';


} else {
    // Default to English if the language code is not recognized
    alertTitle = 'Warning';
    alertMessage = 'This asset is already in an open ticket!';
}

Swal.fire({
    title: alertTitle,
    icon: 'warning',
    html: alertMessage,
    showCloseButton: false,
    showCancelButton: false,
    focusConfirm: false,
});

}
///we have changed stuff here
//////////////////////////////////////////////
//}
/*else{

    $('.spgoholderClose').hide();
//Check if the asset is in a service contract
if (typeof active_seller_packages_array !== 'undefined' && active_seller_packages_array.length > 0 ) {
   

if(parsed_data.asset['open_ticket'] == null){


var serial = parsed_data.asset['serial_number'];
var manufacturer_serial_number = parsed_data.asset['manufacturer_serial_number'];

var active_seller_packages = parsed_data.asset['active_seller_packages'];

console.log(JSON.stringify(parsed_data.asset['active_seller_packages']));

count = _.countBy(active_seller_packages, obj => obj.lot_title !== '');


if(count.true > 1){
//more than 1 service poroviders exist 
localStorage.setItem('moreSp', 'yes');
$('.spList').html('');

for(i=0;i<parsed_data.asset.active_seller_packages.length;i++){


//this is the issue
var lot_title = parsed_data.asset.active_seller_packages[i].lot_title;
var company_name = parsed_data.asset.active_seller_packages[i].buyer.buyer_profile?.company_name;
var upholstery = parsed_data.asset.active_seller_packages[i].upholstery;

 $('.selectAdminDropDown').append('<ons-list-item class="spSelector '+upholstery+'" data-value="'+lot_title+'" tappable>'+
      '<label class="floatingRadio" data-value="'+lot_title+'">'+lot_title+' - '+company_name+
        '<ons-radio style="display:none;width:100% !important;text-align:center;" name="sp" class="taRadio" input-id="radio-'+lot_title+'" value="'+lot_title+'">'+lot_title+' - '+company_name+'</ons-radio>'+
      '</label>'+
'</ons-list-item>');

 $('.1').remove();

}



//check if one of the open tickets is an upholstery ticket
var active_seller_packages2 = parsed_data.asset['active_seller_packages'];
var count2 = _.countBy(active_seller_packages2, obj => obj.upholstery === 1);
//check if the asset's in an upholstery service contract here
if (count2.hasOwnProperty('true') && count2.true >= 1) {

//alert('one of them is upholstery sp');

}
if($('.spSelector').length === 1){


$('.custom_card').hide();
$('.qrTA_card').hide();
$('.qrTA').hide();
$('.floatingRadio').click();


}else{

$('.custom_card').show();
$('.qrTA_card').hide();
$('.qrTA').show();

}

}else{
//1 service provider exists
$('.spList').html('');
for(i=0;i<parsed_data.asset.active_seller_packages.length;i++){



var lot_title = parsed_data.asset.active_seller_packages[i].lot_title;
var company_name = parsed_data.asset.active_seller_packages[i].buyer.buyer_profile.company_name;
 $('.selectAdminDropDown').append('<ons-list-item class="spSelector" data-value="'+lot_title+'" tappable>'+
      '<label class="floatingRadio" data-value="'+lot_title+'">'+lot_title+' - '+company_name+
        '<ons-radio style="display:none;width:100% !important;text-align:center;" name="sp" class="taRadio" input-id="radio-'+lot_title+'" value="'+lot_title+'">'+lot_title+' - '+company_name+'</ons-radio>'+
      '</label>'+
'</ons-list-item>');

}

$('.custom_card').hide();
$('.qrTA_card').hide();
$('.qrTA').hide();
$('.floatingRadio').click();

}
  
  
$('.addAassetBtn').attr('data-serial', serial);


var max_spend_percentage = parsed_data.asset['max_spend_percentage'];

if (max_spend_percentage > 100){


var lang = localStorage.getItem('lang');


function alertDismissed() {
    // Add any necessary actions inside this function
}

var alertTitle, alertMessage;

if (lang == 'ge') {
    alertTitle = 'Achtung';
    alertMessage = 'Das maximale Ausgabenbudget für Asset ' + serial + ' wurde erreicht. Bitte erhöhen Sie das maximale Ausgabenlimit für diesen Vermögenswert.';
} else if (lang == 'po') {
    alertTitle = 'Atenção';
    alertMessage = 'O orçamento máximo de gastos para o ativo ' + serial + ' foi atingido. Por favor, aumente o limite máximo de gastos para este ativo.';
} else if (lang == 'sp') {
    alertTitle = 'Atención';
    alertMessage = 'Se ha alcanzado el presupuesto máximo de gastos para el activo ' + serial + '. Por favor, aumente el límite máximo de gastos para este activo.';
} else if (lang == 'bul') {
    alertTitle = 'Внимание';
    alertMessage = 'Бюджетът за максимални разходи за актив ' + serial + ' е изчерпан. Моля, увеличете максималния лимит за разходи за този актив.';
} else if (lang == 'it') {
    alertTitle = 'Attenzione';
    alertMessage = 'Il budget massimo di spesa per l\'asset ' + serial + ' è stato raggiunto. Si prega di aumentare il limite massimo di spesa per questo asset.';
} else if (lang == 'fr') {
    alertTitle = 'Attention';
    alertMessage = 'Le budget de dépenses maximum a été atteint pour l\'actif ' + serial + '. Veuillez augmenter la limite de dépenses maximale pour cet actif.';
}  else if (lang == 'ar') {
    alertTitle = 'تنبيه';
    alertMessage = 'تم الوصول إلى الحد الأقصى لميزانية النفقات للأصل ' + serial + '. يرجى زيادة الحد الأقصى للنفقات لهذا الأصل';
}  else if (lang == 'ja') {
alertTitle = '警告';
alertMessage = '資産 ' + serial + ' の経費予算の最大値に達しました。この資産の経費予算の最大値を増やしてください。';
}  else if (lang == 'tu') {
alertTitle = 'Uyarı';
alertMessage = 'Varlık ' + serial + ' için harcama bütçesi maksimum değerine ulaşıldı. Bu varlığın harcama bütçesi maksimum değerini artırın, lütfen.';

}else {
    // Default to English if the language code is not recognized
    alertTitle = 'Attention';
    alertMessage = 'The maximum spend budget has been reached for asset ' + serial + '. Please raise the maximum spend limit for this asset.';
}

navigator.notification.alert(
    alertMessage,
    alertDismissed,
    alertTitle,
    'OK'
);

}//else{





var fullname = parsed_data.asset['full_name'];
$('.assetFullname').text(fullname);

if (parsed_data.asset['image'] == null) {
var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

$('.assetImgShow').html("<ons-list-item ><div class='left' style='margin-right:10px;'><img class='list-item__thumbnail largeThumb' src='images/no_img.jpg'></div><div class='center'><span class='list-item__title smallerTitle'>"+fullname+"</span><span class='list-item__subtitle'><span class='trn'>Serial No':</span> "+manufacturer_serial_number+"</span><span class='list-item__subtitle'><span class='trn'>QR No':</span> "+serial+"</span></div></ons-list-item>");



}else{

var image = parsed_data.asset['image']['large'];


console.log('url(https://'+apiType+'.weservicegymequipment.com/'+image+') no-repeat center center');

$('.assetImgShow').html("<ons-list-item ><div class='left' style='margin-right:10px;'><img class='list-item__thumbnail largeThumb' src='https://"+apiType+".weservicegymequipment.com/"+image+"'></div><div class='center'><span class='list-item__title smallerTitle'>"+fullname+"</span><span class='list-item__subtitle'><span class='trn'>Serial No':</span> "+manufacturer_serial_number+"</span><span class='list-item__subtitle'><span class='trn'>QR No':</span> "+serial+"</span></div></ons-list-item>");

$('.addAassetBtn').attr('data-image', 'https://'+apiType+'.weservicegymequipment.com/'+image+'');

$('.imgRemover').attr('data-serial', serial);
 




}



$('.asset_note').remove();
$('<textarea class="asset_note trn" data-prev="" style="box-sizing: border-box; display: inline-block; min-height: 70px;  width: calc(100% - 18px);margin-left: 9px;margin-right: 9px;" placeholder="Write full description of the fault"></textarea>').insertAfter('.after');
  var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
//var modal = document.getElementById('assetmodal');
//modal.show({animation: 'lift'});



//}

}else{
//it has open tickets

var lang = localStorage.getItem('lang');


var alertTitle, alertMessage;

if (lang == 'ge') {
    alertTitle = 'Achtung';
    alertMessage = 'Für dieses Gerät wurde bereits ein Serviceticket erstellt';
} else if (lang == 'po') {
    alertTitle = 'Atenção';
    alertMessage = 'Este ativo já está em um chamado aberto!';
} else if (lang == 'sp') {
    alertTitle = 'Atención';
    alertMessage = 'Este activo ya está en un ticket abierto.';
} else if (lang == 'bul') {
    alertTitle = 'Внимание';
    alertMessage = 'За този актив вече е създадено отворено обаждане!';
} else if (lang == 'it') {
    alertTitle = 'Attenzione';
    alertMessage = 'Questo asset è già presente in un ticket aperto!';
} else if (lang == 'fr') {
    alertTitle = 'Attention';
    alertMessage = 'Cet actif est déjà inclus dans un ticket ouvert !';
} else if (lang == 'ar') {
    alertTitle = 'Attention';
    alertMessage = 'هذا الأصل مُدرج بالفعل في تذكرة مفتوحة';
} else if (lang == 'ja') {
alertTitle = '注意';
alertMessage = 'この資産はすでにオープンチケットに含まれています';
} else if (lang == 'tu') {
alertTitle = 'Dikkat';
alertMessage = 'Bu varlık zaten açık bir bilete dahil edilmiştir.';

}else {
    // Default to English if the language code is not recognized
    alertTitle = 'Attention';
    alertMessage = 'This asset is already in an open ticket!';
}

Swal.fire({
    title: alertTitle,
    icon: 'warning',
    html: alertMessage,
    showCloseButton: false,
    showCancelButton: false,
    focusConfirm: false
});

}



}else{
var lang = localStorage.getItem('lang');


var alertMessage, alertTitle;

if (lang == 'ge') {
    alertTitle = 'Achtung';
    alertMessage = 'Dieses Asset ist nicht in einem aktiven Servicevertrag enthalten!';
} else if (lang == 'po') {
    alertTitle = 'Atenção';
    alertMessage = 'Este ativo não está em um contrato de serviço ativo!';
} else if (lang == 'sp') {
    alertTitle = 'Atención';
    alertMessage = 'Este activo no está en un contrato de servicio activo.';
} else if (lang == 'bul') {
    alertTitle = 'Внимание';
    alertMessage = 'Този актив не е в активен договор за обслужване!';
} else if (lang == 'it') {
    alertTitle = 'Attenzione';
    alertMessage = 'Questo asset non è incluso in un contratto di servizio attivo!';
} else if (lang == 'fr') {
    alertTitle = 'Attention';
    alertMessage = 'Cet actif n\'est pas inclus dans un contrat de service actif !';
} else if (lang == 'ar') {
    alertTitle = 'انتباه';
    alertMessage = 'هذا الأصل غير مدرج في عقد خدمة نشط';
}  else if (lang == 'ja') {
alertTitle = '注意';
alertMessage = 'この資産はアクティブなサービス契約に含まれていません';

}  else if (lang == 'tu') {
alertTitle = 'Dikkat';
alertMessage = 'Bu varlık aktif bir hizmet sözleşmesi içermemektedir.';


}else {
    // Default to English if the language code is not recognized
    alertTitle = 'Attention';
    alertMessage = 'This asset is not in an active service contract!';
}

navigator.notification.alert(
    alertMessage,  // message
    alertDismissed,         // callback
    alertTitle,            // title
    'OK'                  // buttonName
);


}


}*/


  $('.note').val('');


}else{

console.log(data);
var parsed_data = JSON.parse(data);



function alertDismissed() {

}

navigator.notification.alert(
    parsed_data['msg'],  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);

}




    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
    }
});


////////////////
   /*}
  }, (error) => {
     //permission error
    const error_message = error;
  }, {
    "oneShot" : true,
    "timeoutPrompt" : {
     "show" : true,
    "timeout" : 5,
     "prompt" : "Not detected"
    }
});*/


    },
  (error) => {
    // Error handling
  },
);
//end of scanner



}

var externalUserId = new Date().getTime();

if (localStorage.getItem('device_id') != null){

}else{

localStorage.setItem('device_id', externalUserId);

}



    ons.ready(function() {
      console.log("Onsen UI is ready!");


                ons.disableDeviceBackButtonHandler();
    //document.addEventListener('backbutton', function () {}, false);
document.addEventListener("backbutton", onBackKeyDown, false);



    });

    function onBackKeyDown() {

$('.footerMsgHolder').remove();
$('.page').removeClass('scaled');
$('.bottomToolbar').removeClass('scaled');
$('html').removeClass('blacked');
$('body').removeClass('blacked');
$('.modal-in').css('bottom', '-3850px');
$('.sheet-backdrop').removeClass('backdrop-in');
$('.demo-sheet-swipe-to-close,.demo-sheet-swipe-to-step').scrollTop(0,0);
var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

var amodal = document.getElementById('assetmodal');
amodal.hide();
document.querySelector('#myNavigator').popPage();

$('.modernpopup').css('transform', `translateY(10000px)`);
$('.modernpopup').remove();
$('.arrowDowEnlargedimage').remove();
$('.backdropEnlargedImage').remove();

    }

    if (ons.platform.isIPhoneX()) {
      document.documentElement.setAttribute('onsflag-iphonex-portrait', '');
      document.documentElement.setAttribute('onsflag-iphonex-landscape', '');
    }




document.addEventListener('show', function(event){

var page = event.target;




//upholstery page

if (page.matches('#upholstery')) {


upholsteryImg = 0;

  callQRscannerUpholstery(); 
  newTicketasset = [];
  descriptions = [];
   newAddImgs = [];

var today = new Date();
var dd = String(today.getDate()).padStart(2, '0');
var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
var yyyy = today.getFullYear();

today = dd + '/' + mm + '/' + yyyy;
$('.todayDate').text(today);

var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);

}




if (page.matches('#deployed')) {



    //Check the scroll
    var lastScrollTop = 0;
$('.page__content').scroll(function() {
var scrolled_val = $('.page__content:last').scrollTop();
//console.log(scrolled_val);
if(scrolled_val > 10 ){
 bottomToolbar.style.transform = 'translateY(100%)';
}else{
  bottomToolbar.style.transform = 'translateY(0)';
}

});



localStorage.setItem('page_type', 'deployed');
 var uType = localStorage.getItem('usertype');


if(uType != 'Gym Operator'){

$('.addressList').show();
}else{
    //$('.descriptionList').show();

}

var pmodal = document.getElementById('preloaderModal');
pmodal.show();
  $('.tickets').remove();

var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

//$(this).prop('disabled', true);
//$('.loaderIcon').show();

$.ajax({
    url: ''+host+'getTickets.php?email='+email+'&accesstoken='+accesstoken+'&status=open_engineer_deployed',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

console.log(data);

      var json = JSON.stringify(data);

     var uType = localStorage.getItem('usertype');

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);


for(i=0;i<parsed_data.tickets.open_engineer_deployed_tickets.length;i++){

var output_string = "";


var is_service = parsed_data.tickets.open_engineer_deployed_tickets[i].is_service;
var type = parsed_data.tickets.open_engineer_deployed_tickets[i].type;


if(is_service == false){


var appendable = parsed_data.tickets.open_engineer_deployed_tickets[i].appendable;
var unactioned_notes = parsed_data.tickets.open_engineer_deployed_tickets[i].unactioned_notes;


unactioned_notes = objectLength(unactioned_notes);
var style = 'display: inline-table;';

if (unactioned_notes == '0'){

    style= 'display: none;';
}




var appendable_assets = parsed_data.tickets.open_engineer_deployed_tickets[i].appendable_assets;

var encodedObject = window.btoa(JSON.stringify(appendable_assets));
var ticket_number = parsed_data.tickets.open_engineer_deployed_tickets[i].ticket_number;


// Accessing the location if it's not null
let loc = parsed_data.tickets.open_engineer_deployed_tickets[i].location;
if (loc !== null) {
  // Do something with loc
  loc = parsed_data.tickets.open_engineer_deployed_tickets[i].location.name;
} else {
  loc = 'N/A';
}


if(parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package != null){

$('.descriptionList').append('<option value="'+parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.description+'">'+parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.description+'</option>');

}

var role = localStorage.getItem('role');
//changed here
if(uType == 'Gym Operator'){

    /*$('.addressList').append('<option value="'+parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.buyer.buyer_profile.site_name+'">'+parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.buyer.buyer_profile.site_name+'</option>');*/


}else if(uType == 'Service Provider' && role =='buyer'){

$('.addressList').append('<option value="'+parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.seller.seller_profile.site_name+'">'+parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.seller.seller_profile.site_name+'</option>');

}else if(uType == 'Service Provider' && role =='engineer'){

$('.addressList').append('<option value="'+parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.seller.seller_profile.site_name+'">'+parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.seller.seller_profile.site_name+'</option>');

}


var optionValues2 =[];
$('.addressList option').each(function(){
    //remove every undefined value here
    $(".addressList option[value='undefined']").remove();
   if($.inArray(this.value, optionValues2) >-1){
      $(this).remove()
   }else{
      optionValues2.push(this.value);
   }
});


var optionValues3 =[];
$('.descriptionList option').each(function(){
        //remove every undefined value here
    $(".descriptionList option[value='undefined']").remove();
   if($.inArray(this.value, optionValues3) >-1){
      $(this).remove()
   }else{
      optionValues3.push(this.value);
   }
});
    

  $('.noIcon').hide();

   var created_at = parsed_data.tickets.open_engineer_deployed_tickets[i].created_at;

  
  var date = new Date(created_at);
  
  var output = ((date.getMonth() > 8) ? (date.getMonth() + 1) : ('0' + (date.getMonth() + 1))) + '/' + ((date.getDate() > 9) ? date.getDate() : ('0' + date.getDate())) + '/' + date.getFullYear();

   var ticket_number = parsed_data.tickets.open_engineer_deployed_tickets[i].ticket_number;
   
   var uuid = parsed_data.tickets.open_engineer_deployed_tickets[i].uuid;
   if(uType == 'Gym Operator'){

if(type == 'standard'){

   var address = parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.buyer.buyer_profile.site_name;
   var location = parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.location;
   var des = parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.description;
}else{
var address = 'N/A';
var location = 'N/A';
var des = 'N/A';

}
   }else if(uType == 'Service Provider' && role =='buyer'){
  var address = parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.seller.seller_profile.site_name;
   }
   

var priority = parsed_data.tickets.open_engineer_deployed_tickets[i].priority;
if (priority != null){
priority = priority.replace('\u201d', '');

}else{
priority = 'N/A';
}

var notes = parsed_data.tickets.open_engineer_deployed_tickets[i].notes;
var nnotes = JSON.stringify(notes);

if(notes == null){

  notes = '';

}


var co = '<span class="trn">Club Name</span>';
if(uType == 'Gym Operator'){
if(type == 'standard'){
var company_name = parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.buyer.buyer_profile?.company_name;
}else{
var company_name = 'N/A';
}
co = '<span class="trn">Service Provider</span>';


var assets = parsed_data.tickets.open_engineer_deployed_tickets[i].assets;






//adding ad-hoc tickets here...
if(type == 'ad-hoc'){

        var de = '--';
        de = trimString(de, 10); 
        var p = '--';

var lang = localStorage.getItem('lang');
var tt = "Ticket No'";

if(lang == 'ge'){
    tt = "Ticket-Nr.";
} else if(lang == 'po'){
    tt = "Número do Bilhete";
} else if(lang == 'sp'){
    tt = "Número de Boletos";
} else if(lang == 'bul'){
    tt = "Билет номер";
} else if(lang == 'it'){
    tt = "Numero del biglietto";
} else if(lang == 'fr'){
    tt = "Numéro de billet";
}else if(lang == 'ar'){
    tt = "رقم التذكرة";
}else if(lang == 'ja'){
    tt = "チケット番";
}else if(lang == 'tu'){
    tt = "Bilet numarası";

}else {
    // Default to the original text if the language code is not recognized
    tt = "Ticket No'";
}

           
           $('<div class="tickets" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'"><div class="pn_in_circle" style="'+style+'"><span class="pn_in_circle__content">'+unactioned_notes+'</span></div><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="viewTicketBtn viewForLarge button trn" data-type="open" data-ticket="ad-hoc">View</button></div><div class="ticketSmallDetails" style="text-align:left;float:left;font-size:12px;padding-top:8px;"><b><span class="trn">Priority:</span> </b> '+priority +'<br><b><span class="trn">Location:</span> </b> '+loc +'<br><b><span class="trn">'+tt+':</span> </b> '+ticket_number +'<br><b><span class="trn">Date Raised:</span></b> '+created_at +'<br> <b>'+co+':</b> '+company_name+'<br> <b><span class="trn">Fault Description:</span></b> '+de+'<br> <b><span class="trn">Product:</span></b> Ad-hoc</div>').data('inner-notes', nnotes).appendTo('.de-tickets');

           var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
}


    for (var j = 0; j < assets.length; j++) {

        var lang = localStorage.getItem('lang');
var tt = "Ticket No'";

if(lang == 'ge'){
    tt = "Ticket-Nr.";
} else if(lang == 'po'){
    tt = "Número do Bilhete";
} else if(lang == 'sp'){
    tt = "Número de Boletos";
} else if(lang == 'bul'){
    tt = "Билет номер";
} else if(lang == 'it'){
    tt = "Numero del biglietto";
} else if(lang == 'fr'){
    tt = "Numéro de billet";
}else if(lang == 'ar'){
    tt = "رقم التذكرة";
}else if(lang == 'ja'){
    tt = "チケット番";
} else {
    // Default to the original text if the language code is not recognized
    tt = "Ticket No";
}


        var de = assets[j].description;
        de = trimString(de, 10); 
        var p = assets[j].product_name;
           $('.de-tickets').append('<div class="tickets" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'"><div class="pn_in_circle" style="'+style+'"><span class="pn_in_circle__content">'+unactioned_notes+'</span></div><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="viewTicketBtn viewForLarge button trn" data-type="open">View</button></div><div class="ticketSmallDetails" style="text-align:left;float:left;font-size:12px;padding-top:8px;"><b><span class="trn">Priority:</span> </b> '+priority +'<br><b><span class="trn">Location:</span> </b> '+loc +'<br><b><span class="trn">'+tt+':</span> </b> '+ticket_number +'<br><b><span class="trn">Date Raised:</span></b> '+created_at +'<br> <b>'+co+':</b> '+company_name+'<br> <b><span class="trn">Fault Description:</span></b> '+de+'<br> <b><span class="trn">Product:</span></b> '+p+'</div>');

var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
    }


}else if(uType == 'Service Provider' && role =='buyer'){


if(type == 'standard'){
var buyer_company_name = parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.buyer.buyer_profile?.company_name;

var company_name = parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.seller.seller_profile.site_name;
}else{
var company_name = 'N/A';
}



var cl = parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.seller.seller_profile.company_name;


var assets = parsed_data.tickets.open_engineer_deployed_tickets[i].assets;


//adding ad-hoc tickets here...
if(type == 'ad-hoc'){

        var de = '--';
        de = trimString(de, 10); 
        var p = '--';

                var lang = localStorage.getItem('lang');
var tt = "Ticket No'";

if(lang == 'ge'){
    tt = "Ticket-Nr.";
} else if(lang == 'po'){
    tt = "Número do Bilhete";
} else if(lang == 'sp'){
    tt = "Número de Boletos";
} else if(lang == 'bul'){
    tt = "Билет номер";
} else if(lang == 'it'){
    tt = "Numero del biglietto";
} else if(lang == 'fr'){
    tt = "Numéro de billet";
}else if(lang == 'ar'){
    tt = "رقم التذكرة";
}else if(lang == 'ja'){
    tt = "チケット番";
} else {
    // Default to the original text if the language code is not recognized
    tt = "Ticket No";
}

           
           $('<div class="tickets" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'"><div class="pn_in_circle" style="'+style+'"><span class="pn_in_circle__content">'+unactioned_notes+'</span></div><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="viewTicketBtn viewForLarge button trn" data-type="open" data-ticket="ad-hoc">View</button></div><div class="ticketSmallDetails" style="text-align:left;float:left;font-size:12px;padding-top:8px;"><b><span class="trn">Priority:</span> </b> '+priority +'<br><b><span class="trn">Location:</span> </b> '+loc +'<br><b><span class="trn">'+tt+':</span> </b> '+ticket_number +'<br><b><span class="trn">Date Raised:</span></b> '+created_at +'<br> <b>'+co+':</b> '+company_name+'<br> <b><span class="trn">Fault Description:</span></b> '+de+'<br> <b><span class="trn">Product:</span></b> Ad-hoc</div>').data('inner-notes', nnotes).appendTo('.de-tickets');

           var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
}

    for (var j = 0; j < assets.length; j++) {

        var lang = localStorage.getItem('lang');
var tt = "Ticket No'";

if(lang == 'ge'){
    tt = "Ticket-Nr.";
} else if(lang == 'po'){
    tt = "Número do Bilhete";
} else if(lang == 'sp'){
    tt = "Número de Boletos";
} else if(lang == 'bul'){
    tt = "Билет номер";
} else if(lang == 'it'){
    tt = "Numero del biglietto";
} else if(lang == 'fr'){
    tt = "Numéro de billet";
}else if(lang == 'ar'){
    tt = "رقم التذكرة";
}else if(lang == 'ja'){
    tt = "チケット番";
} else {
    // Default to the original text if the language code is not recognized
    tt = "Ticket No";
}

        
        var de = assets[j].description;
        de = trimString(de, 10);
        var p = assets[j].product_name;
           $('.de-tickets').append('<div class="tickets" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'"><div class="pn_in_circle" style="'+style+'"><span class="pn_in_circle__content">'+unactioned_notes+'</span></div><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="button viewTicketBtn viewForLarge trn" data-type="open">View</button></div><div class="ticketSmallDetails" style="text-align:left;float:left;font-size:12px;padding-top:8px;"><b><span class="trn">Priority:</span> </b> '+priority +'<br><b><span class="trn">Location:</span> </b> '+loc +'<br><b><span class="trn">'+tt+':</span> </b> '+ticket_number +'<br><b><span class="trn">Company Name:</span> </b> '+cl+'<br><b>'+co+':</b> '+company_name+'<br> <b><span class="trn">Date Raised:</span> </b>'+created_at +'<br> <b><span class="trn">Fault Description:</span> </b> '+de+'<br> <b><span class="trn">Product:</span> </b> '+p+'</div>');


var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
    }

}else{

if(type == 'standard'){
var company_name = parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.buyer.buyer_profile?.company_name;
}else{
var company_name = 'N/A';
}
co = '<span class="trn">Service Provider</span>';


var assets = parsed_data.tickets.open_engineer_deployed_tickets[i].assets;

//adding ad-hoc tickets here...
if(type == 'ad-hoc'){

        var de = '--';
        de = trimString(de, 10); 
        var p = '--';

                var lang = localStorage.getItem('lang');
var tt = "Ticket No'";

if(lang == 'ge'){
    tt = "Ticket-Nr.";
} else if(lang == 'po'){
    tt = "Número do Bilhete";
} else if(lang == 'sp'){
    tt = "Número de Boletos";
} else if(lang == 'bul'){
    tt = "Билет номер";
} else if(lang == 'it'){
    tt = "Numero del biglietto";
} else if(lang == 'fr'){
    tt = "Numéro de billet";
}else if(lang == 'ar'){
    tt = "رقم التذكرة";
}else if(lang == 'ja'){
    tt = "チケット番";
} else {
    // Default to the original text if the language code is not recognized
    tt = "Ticket No";
}

           
           $('<div class="tickets" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'"><div class="pn_in_circle" style="'+style+'"><span class="pn_in_circle__content">'+unactioned_notes+'</span></div><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="viewTicketBtn viewForLarge button trn" data-type="open" data-ticket="ad-hoc">View</button></div><div class="ticketSmallDetails" style="text-align:left;float:left;font-size:12px;padding-top:8px;"><b><span class="trn">Priority:</span> </b> '+priority +'<br><b><span class="trn">Location:</span> </b> '+loc +'<br><b><span class="trn">'+tt+':</span> </b> '+ticket_number +'<br><b><span class="trn">Date Raised:</span></b> '+created_at +'<br> <b>'+co+':</b> '+company_name+'<br> <b><span class="trn">Fault Description:</span></b> '+de+'<br> <b><span class="trn">Product:</span></b> Ad-hoc</div>').data('inner-notes', nnotes).appendTo('.de-tickets');

           var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
}

    for (var j = 0; j < assets.length; j++) {

        var lang = localStorage.getItem('lang');
var tt = "Ticket No'";

if(lang == 'ge'){
    tt = "Ticket-Nr.";
} else if(lang == 'po'){
    tt = "Número do Bilhete";
} else if(lang == 'sp'){
    tt = "Número de Boletos";
} else if(lang == 'bul'){
    tt = "Билет номер";
} else if(lang == 'it'){
    tt = "Numero del biglietto";
} else if(lang == 'fr'){
    tt = "Numéro de billet";
}else if(lang == 'ar'){
    tt = "رقم التذكرة";
}else if(lang == 'ja'){
    tt = "チケット番";
} else {
    // Default to the original text if the language code is not recognized
    tt = "Ticket No";
}


        var de = assets[j].description;
        de = trimString(de, 10); 
        var p = assets[j].product_name;
           $('.de-tickets').append('<div class="tickets" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'"><div class="pn_in_circle" style="'+style+'"><span class="pn_in_circle__content">'+unactioned_notes+'</span></div><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="viewTicketBtn viewForLarge button trn" data-type="open">View</button></div><div class="ticketSmallDetails" style="text-align:left;float:left;font-size:12px;padding-top:8px;"><b><span class="trn">Priority:</span> </b> '+priority +'<br><b><span class="trn">Location:</span> </b> '+loc +'<br><b><span class="trn">'+tt+':</span> </b> '+ticket_number +'<br><b><span class="trn">Date Raised:</span></b> '+created_at +'<br> <b>'+co+':</b> '+company_name+'<br> <b><span class="trn">Fault Description:</span></b> '+de+'<br> <b><span class="trn">Product:</span></b> '+p+'</div>');

var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
    }

}




//created_at = created_at.split(" ")[0];



var pmodal = document.getElementById('preloaderModal');
pmodal.hide();


}

}

    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

$('.noIcon').show();
    }
});



}


if(page.matches('#asset')){



var pmodal = document.getElementById('preloaderModal');
pmodal.show();


var today = new Date();
var dd = today.getDate();

var mm = today.getMonth()+1; 
var yyyy = today.getFullYear();
if(dd<10) 
{
    dd='0'+dd;
} 

if(mm<10) 
{
    mm='0'+mm;
} 
today = yyyy+'-'+mm;




var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');
var serial = localStorage.getItem('assetserial');

    //Check the scroll
    var lastScrollTop = 0;
$('.page__content').scroll(function() {
var scrolled_val = $('.page__content:last').scrollTop();
//console.log(scrolled_val);
if(scrolled_val > 10 ){
 bottomToolbar.style.transform = 'translateY(100%)';
}else{
  bottomToolbar.style.transform = 'translateY(0)';
}

});


$.ajax({
    url: ''+host+'getAsset.php?serial='+serial+'&email='+email+'&accesstoken='+accesstoken+'&force=1',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

    var json = JSON.stringify(data);

     //var obj = parseJSON(data);
  var parsed_data = JSON.parse(data);

 

  console.log(data);

if(parsed_data['status'] == 'OK'){




var serial = parsed_data.asset['serial_number'];
$('.serialNo').text(serial);

var has_odometer = parsed_data.asset['has_odometer']; 
var odometerReadings = parsed_data.asset['odometer_readings']; 
var serviceHistory = parsed_data.asset['service_history']; 
var manufacturing_date = parsed_data.asset['manufacturing_date'];
var installation_date = parsed_data.asset['installation_date'];
var unit_price = parsed_data.asset['unit_price'];
var max_spend = parsed_data.asset['max_spend'];
var current_spend = parsed_data.asset['current_spend'];
var current_spend = parsed_data.asset['current_spend'];
var max_spend = parsed_data.asset['max_spend'];
var max_spend_percentage = parsed_data.asset['max_spend_percentage'];
var manufacturer_serial_number = parsed_data.asset['manufacturer_serial_number'];
var full_name = parsed_data.asset['full_name'];
var warranty_end_date = parsed_data.asset['warranty_end_date'];

var mainimage = parsed_data.asset['image'];
if (mainimage != null){
var image = parsed_data.asset['image']['large'];

$('.hero-bg').css('background-image', 'url(https://'+apiType+'.weservicegymequipment.com/'+image+')');

$('.hero-bg').removeClass('blurred');

}else{

$('.hero-bg').removeClass('blurred');


}

var lang = localStorage.getItem('lang');
var currencySymbol = getCurrencySymbol(localStorage.getItem('country'));

var list = '';
for (var i = 0; i < serviceHistory.length; i++) {
    var service = serviceHistory[i];
    var cost = service.cost.toLocaleString('de-DE');
    var formatted_date = service.formatted_date;
    var category = service.category;
    var who = service.who;
    var description = service.description || 'N/A';

    list += '<ons-list-item class="odoListItem" expandable>';
  
   
    list += '<span class="trn">Date:</span> ' + formatted_date + '<div class="expandable-content">';
list += '<span class="trn">Ticket Number</span>: <a href="" class="serviceViewTicketBtn" data-ticketNumber="' + service.ticket_number + '" data-uuid="' + service.ticket_uuid + '">' + service.ticket_number + '</a><br>';
     
    list += '<span class="trn">Cost:</span> ' + currencySymbol + cost + '<br>';
    list += '<span class="trn">Category:</span> ' + category + '<br>';
    list += '<span class="trn">User:</span> ' + who + '<br>';
    list += '<span class="trn">Description:</span> ' + description + '</div></ons-list-item>';
}

$('.noHistory').remove();
$('.servicelist').append(list);

var translator = $(document).translate({ lang: "en", t: dict });
translator.lang(lang);



function getCurrencySymbol(country) {
    switch (country) {
        case 'turkey':
            return '₺';
        case 'japan':
            return '¥';
        case 'south_Africa':
            return 'R';
        case 'uk':
            return '£';
        case 'us':
            return '$';
        default:
            return '€';
    }
}



if ($('.noHistory').length) {
     var lang = localStorage.getItem('lang');

     if (lang == 'ge'){
$('.noHistory').text('Es gibt keine Servicehistorie');
     }else  if (lang == 'en'){
$('.noHistory').text('There is no service history.');
     }else  if (lang == 'po'){
$('.noHistory').text('Não há histórico de serviço');
     }else  if (lang == 'sp'){
$('.noHistory').text('No hay historial de servicio');
     }else  if (lang == 'fr'){
$('.noHistory').text('Il n\'y a pas d\'historique de service');
     }else  if (lang == 'it'){
$('.noHistory').text('Non ci sono precedenti di servizio');
     }else  if (lang == 'bul'){
$('.noHistory').text('Няма история на обслужване');
     }else  if (lang == 'ar'){
$('.noHistory').text('لا توجد سجلات للخدمة');
     }else  if (lang == 'ja'){
$('.noHistory').text('サービス履歴がありません。');
     }
} 


 


if(has_odometer == 1){
$('.odometerCard').css('visibility','visible');

for(i=0;i<odometerReadings.length;i++){

var value = odometerReadings[i].value;
var who = odometerReadings[i].who;
var formatted_created_at = odometerReadings[i].formatted_created_at;


var list = '<ons-list-item class="odoListItem" expandable>'+value+'<div class="expandable-content"><span class="trn">Created at:</span> '+formatted_created_at+'<br><span class="trn">User:</span> '+who+'</div></ons-list-item>';

$('.odolist').append(list);




var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);

 }

}



//changing currency symbole here
var currency = '';
if(localStorage.getItem('country') == 'turkey'){
currency = '₺';
$('.max_spend').html('<span class="boldSpan trn">Max Spend:</span> '+currency+'' +max_spend);
$('.current_spend').html('<span class="boldSpan trn">Current Spend:</span> '+currency+'' +current_spend);
}else if(localStorage.getItem('country') == 'japan'){
currency = '¥';

$('.max_spend').html('<span class="boldSpan trn">Max Spend:</span> '+currency+'' +max_spend);
$('.current_spend').html('<span class="boldSpan trn">Current Spend:</span> '+currency+'' +current_spend);
}
else if(localStorage.getItem('country') == 'south_Africa'){
currency = 'R';

$('.max_spend').html('<span class="boldSpan trn">Max Spend:</span> '+currency+'' +max_spend);
$('.current_spend').html('<span class="boldSpan trn">Current Spend:</span> '+currency+'' +current_spend);
}
else if(localStorage.getItem('country') == 'uk'){
currency = '£';

$('.max_spend').html('<span class="boldSpan trn">Max Spend:</span> '+currency+'' +max_spend);
$('.current_spend').html('<span class="boldSpan trn">Current Spend:</span> '+currency+'' +current_spend);
}
else if(localStorage.getItem('country') == 'us'){

currency = '$';

$('.max_spend').html('<span class="boldSpan trn">Max Spend:</span> '+currency+'' +max_spend);
$('.current_spend').html('<span class="boldSpan trn">Current Spend:</span> '+currency+'' +current_spend);
}else{
max_spend = max_spend.toLocaleString('de-DE');
current_spend = current_spend.toLocaleString('de-DE');
currency = '€';

$('.max_spend').html('<span class="boldSpan trn">Max Spend:</span> '+max_spend+''+currency);
$('.current_spend').html('<span class="boldSpan trn">Current Spend:</span> '+current_spend+''+currency);
}



$('.fullname').html('<span class="boldSpan trn">Full Name:</span> ' +full_name);
$('.manufacturer_serial_number').html('<span class="boldSpan trn">Manufacturer serial number:</span> ' +manufacturer_serial_number);

$('.warranty_end_date').html('<span class="boldSpan trn">Warranty end date:</span> ' +warranty_end_date);
$('.manufacturing_date').html('<span class="boldSpan trn">Manufacturing Date:</span> ' +manufacturing_date);
$('.installation_date').html('<span class="boldSpan trn">Installation Date:</span> ' +installation_date);
$('.unit_price').html('<span class="boldSpan trn">Unit Price:</span> ' +unit_price);


var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);


var active_seller_packages = parsed_data.asset['active_seller_packages'];

console.log(JSON.stringify(parsed_data.asset['active_seller_packages']));

count = _.countBy(active_seller_packages, obj => obj.lot_title !== '');

var warranty_end_date = parsed_data.asset['warranty_end_date'];
$('.warranty_end_date').html('<span class="boldSpan trn">Warranty End Date:</span> ' +warranty_end_date);

var fullname = parsed_data.asset['full_name'];
$('.assName').text(fullname);

var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);




if(Number(max_spend_percentage) < 50){
$('.animated-progress').addClass('progress-green');
}else{
$('.animated-progress').addClass('progress-red');
}

$(".animated-progress span").each(function () {
  $(this).animate(
    {
      width: Number(max_spend_percentage) + "%",
    },
    1000
  );
  $('.percenatgeHolder').text(Number(max_spend_percentage) + '%');
});





//chaning currency symboles here
if(localStorage.getItem('country') == 'turkey'){
$('.maxSpendCurrSpend').text('₺'+max_spend +' / ₺'+current_spend);
}else if(localStorage.getItem('country') == 'japan'){
$('.maxSpendCurrSpend').text('¥'+max_spend +' / ¥'+current_spend);
}else if(localStorage.getItem('country') == 'south_Africa'){
$('.maxSpendCurrSpend').text('Current Spend vs Cap Spend R'+max_spend +' / R'+current_spend);
}else if(localStorage.getItem('country') == 'uk'){
$('.maxSpendCurrSpend').text('Current Spend vs Cap Spend £'+max_spend +' / £'+current_spend);
}else if(localStorage.getItem('country') == 'us'){
$('.maxSpendCurrSpend').text('Current Spend vs Cap Spend $'+max_spend +' / $'+current_spend);
}else{
    current_spend = current_spend.toLocaleString('de-DE');
    max_spend = max_spend.toLocaleString('de-DE');

    if(localStorage.getItem('lang') == 'ge'){
$('.maxSpendCurrSpend').text('Aktuelle Ausgaben in % vom Servicebudget.');
    }else{
$('.maxSpendCurrSpend').text(''+max_spend +'€ / '+current_spend+'€');
    }
}




var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

}else{

console.log(data);
var parsed_data = JSON.parse(data);



function alertDismissed() {

}

navigator.notification.alert(
    parsed_data['msg'],  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);

}




    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});









 $(".responsive-calendar").responsiveCalendar({
          time: today,
          events: {

            }
        });



setTimeout(function(){



   const month = ["January","February","March","April","May","June","July","August","September","October","November","December"];
const d = new Date();
let m = month[d.getMonth()];


  var monthNumber = "January___February__March_____April_____May_______June______July______August____September_October___November__December__".indexOf(m) / 10 + 1;

var nextM = '';

if(monthNumber == 12){
nextM = 1;
}else{
nextM = Number(monthNumber) + 1;
}

  if(nextM < 10){
nextM = '0'+nextM;

  }




var lastD = $("a").last().text();
var firstD = $(".day a").first().text();

if(firstD < 10){
firstD = '0'+firstD;

  }

  if(lastD < 10){
lastD = '0'+lastD;

  }

var year = new Date().getFullYear();
 var to = year+'-'+nextM+'-'+lastD;
var old = localStorage.getItem('oldMonth');


  if(old < 10){
old = '0'+old;

  }



 var fro = year+'-'+old+'-'+firstD;




console.log(''+host+'getMaintenanceHistory.php?serial='+serial+'&email='+email+'&accesstoken='+accesstoken+'&to='+to+'&from='+fro+'');

$.ajax({
    url: ''+host+'getMaintenanceHistory.php?serial='+serial+'&email='+email+'&accesstoken='+accesstoken+'&to='+to+'&from='+fro+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

    var json = JSON.stringify(data);


  var parsed_data = JSON.parse(data);



  console.log(json);

 

if(parsed_data['status'] == 'OK'){
var result = {};
  calArray = [];

 for(i=0;i<parsed_data.tasks.length;i++){
var mydate = parsed_data.tasks[i].date;

  // Check if an object with the date already exists in the result object
  if (!result[mydate]) {

    // If it doesn't exist, create a new object with the date as the key and an empty object as the value
    result[mydate] = {};

  }

  // Set the number and url values for the corresponding object in the result object
  result[mydate]["number"] = "";
  result[mydate]["url"] = parsed_data.tasks[i].title;





var assetToAdd = {
  "date": parsed_data.tasks[i].date,
  "title": parsed_data.tasks[i].title,
}


calArray.push(assetToAdd);




 }




/*result = JSON.stringify(result);

result = result.replace(/({)([}\w]+)(})/,'$2');

console.log(JSON.stringify(result));*/

/*var j = JSON.stringify(result);

localStorage.setItem('calendar', j);*/


 $(".responsive-calendar").responsiveCalendar('clearAll');

$('.responsive-calendar').responsiveCalendar('edit',result);




}

    }

});




}, 2000);      



}


if(page.matches('#ppm')){


    //Check the scroll
    var lastScrollTop = 0;
$('.page__content').scroll(function() {
var scrolled_val = $('.page__content:last').scrollTop();
//console.log(scrolled_val);
if(scrolled_val > 10 ){
 bottomToolbar.style.transform = 'translateY(100%)';
}else{
  bottomToolbar.style.transform = 'translateY(0)';
}

});

    var pmodal = document.getElementById('preloaderModal');
pmodal.show();

    var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

$.ajax({
    url: `${host}get-ppm-tasks.php?email=${email}&accesstoken=${accesstoken}`,
    dataType: 'json', // Assuming the server responds with JSON
    type: 'GET',
    processData: false,
    success: function(data, textStatus, jQxhr){
        var pmodal = document.getElementById('preloaderModal');
        pmodal.hide();

        console.log(JSON.stringify(data)); // For logging purposes only, consider removing for production

        if(data.status == 'OK'){
            // Process today_completed tasks with specific structure
            let completedTasksHtml = '';
            data.tasks.today_completed.forEach((task) => {
                const { title, completed_at, description = 'Not Provided', product_types } = task;
                const localDate = new Date(completed_at);

                completedTasksHtml += `<ons-list-item expandable style="color:black !important;" class="taskListItem">${title}<div class="expandable-content">Completed at: ${localDate}<br><br>Description: ${description}<br><br>Product Types: ${product_types}</div></ons-list-item>`;
            });
            $('.completedTasks').append(completedTasksHtml);

            // Process other tasks types
            ['overdue', 'today_pending'].forEach((taskType) => {
                let tasksHtml = '';
                data.tasks[taskType].forEach((task) => {
                    const { title, reminder_time, product_types, id } = task;
const description = task.description ?? 'Not Provided';

                    const reminderTimeFormatted = reminder_time || 'Not Provided';



                    tasksHtml += `<ons-list-item expandable style="color:black !important;" class="taskListItem ${id}">${title}<div class="expandable-content">Reminder Time: ${reminderTimeFormatted}<br><br>Description: ${description}<br><br>Product Types: ${product_types}<br><br> <button modifier="large" class="button trn completeTask" data-id="${id}">COMPLETE</button></div></ons-list-item>`;
                });

                $(`.${taskType}Tasks`).append(tasksHtml);
            });

            var lang = localStorage.getItem('lang');
            var translator = $(document).translate({lang: "en", t: dict});
            translator.lang(lang);
        } else {
            console.log(data);

            function alertDismissed() {
                // Callback function
            }

            navigator.notification.alert(
                data.msg,  // message
                alertDismissed,         // callback
                '',            // title
                'OK'                  // buttonName
            );
        }
    },
    error: function(jqXhr, textStatus, errorThrown){
        console.log(errorThrown);
        var pmodal = document.getElementById('preloaderModal');
        pmodal.hide();
    }
});




}




if(page.matches('#raise-manually')){

// Get the current date and time
var currentDate = new Date();

// Get the current timestamp in milliseconds since the Unix Epoch (January 1, 1970)
var timestamp = currentDate.getTime();

fileName = timestamp;

var lang = localStorage.getItem('lang');

if (lang == 'ge') {
    var ldr = $('<div class="iosspinnerHolder"><div class="ios-spinner" id="iosSpinner"></div><div id="loadingText">Lade Geräteregister</div></div>');
} else if (lang == 'po') {
    var ldr = $('<div class="iosspinnerHolder"><div class="ios-spinner" id="iosSpinner"></div><div id="loadingText">Carregando Ativos</div></div>');
} else if (lang == 'sp') {
    var ldr = $('<div class="iosspinnerHolder"><div class="ios-spinner" id="iosSpinner"></div><div id="loadingText">Cargando Activos</div></div>');
} else if (lang == 'bul') {
    var ldr = $('<div class="iosspinnerHolder"><div class="ios-spinner" id="iosSpinner"></div><div id="loadingText">Зареждане на активи</div></div>');
} else if (lang == 'it') {
    var ldr = $('<div class="iosspinnerHolder"><div class="ios-spinner" id="iosSpinner"></div><div id="loadingText">Caricamento Risorse</div></div>');
} else if (lang == 'fr') {
    var ldr = $('<div class="iosspinnerHolder"><div class="ios-spinner" id="iosSpinner"></div><div id="loadingText">Chargement des Actifs</div></div>');
}else if (lang == 'ar') {
    var ldr = $('<div class="iosspinnerHolder"><div class="ios-spinner" id="iosSpinner"></div><div id="loadingText">تحميل الأصول</div></div>');
}else if (lang == 'ja') {
    var ldr = $('<div class="iosspinnerHolder"><div class="ios-spinner" id="iosSpinner"></div><div id="loadingText">資産のダウンロード</div></div>');
}else if (lang == 'tu') {
  var ldr = $('<div class="iosspinnerHolder"><div class="ios-spinner" id="iosSpinner"></div><div id="loadingText">Varlıkların İndirilmesi</div></div>');

} else {
    // Default to the original text if the language code is not recognized
    var ldr = $('<div class="iosspinnerHolder"><div class="ios-spinner" id="iosSpinner"></div><div id="loadingText">Loading Assets</div></div>');
}





      // Use the after() method to append it after the target element
      $(".appendAfter").after(ldr);

    

         const spinner = document.getElementById('iosSpinner');
    const loadingText = document.getElementById('loadingText');
    const colors = ['#da116d', '#a5c432', '#00aeef', '#ea1c28'];
    let colorIndex = 0;

    function changeSpinnerColor() {
      spinner.style.borderTopColor = colors[colorIndex];
      spinner.style.borderBottomColor = colors[colorIndex];
      colorIndex = (colorIndex + 1) % colors.length;
    }

    setInterval(changeSpinnerColor, 1000); // Change color every second

    setTimeout(() => {

        if (lang == 'ge') {
   var still = 'Noch am Laden...';
} else if (lang == 'po') {
    var still = 'Ainda a carregar...';
} else if (lang == 'sp') {
   var still = 'Todavía cargando...';
} else if (lang == 'bul') {
    var still = 'Все още се зарежда...';
} else if (lang == 'it') {
    var still = 'Ancora in caricamento...';
} else if (lang == 'fr') {
   var still = 'Chargement en cours...';
} else if (lang == 'ar') {
   var still = '...جاري التحميل';
} else if (lang == 'ja') {
   var still = 'まだ読み込み中...';
} else if (lang == 'tu') {
var still = 'Hala yükleniyor...';

}else {
    // Default to the original text if the language code is not recognized
    var still = 'Still loading...';
}

      loadingText.textContent = still;
      
    }, 5000); // Change text after 5 seconds

    


//check if they can rasie TA and Ad-hoc ticket    
var pr = localStorage.getItem('permissions_raise_internal_ticket');
var pr2 = localStorage.getItem('permissions_raise_adhoc_ticket');
var pr3 = localStorage.getItem('permissions_manage_engineers');
var pr4 = localStorage.getItem('permissions_manage_caretakers');
var pr5 = localStorage.getItem('permissions_assign_caretakers');

var pr6 = localStorage.getItem('permissions_assign_ticket_admins');
var pr7 = localStorage.getItem('permissions_manage_ticket_admins');

var pr8 = localStorage.getItem('permissions_raise_ticket');


if((pr == 'true' || pr == true) && (pr5 == true || pr5 == 'true')){
$('.intwhom').show();
}

if(pr6 == 'true' || pr6 == true){
$('.tawhom').show();
}


if(pr8 == 'true' || pr8 == true){
$('.spwhom').show();
}







var lang = localStorage.getItem('lang');
if(localStorage.getItem('permissions_raise_adhoc_ticket') == 'true'){
if (lang == 'ge') {
    var inp = '<ons-search-input placeholder="Gerät suchen" class="searchAssetsInput"></ons-search-input>';
    var o = '<ons-list-item class="m_listitem other" data-value="other" tappable>Anderes Gerät</ons-list-item>';
} else if (lang == 'po') {
    var inp = '<ons-search-input placeholder="Procurar" class="searchAssetsInput"></ons-search-input>';
    var o = '<ons-list-item class="m_listitem other" data-value="other" tappable>Outro</ons-list-item>';
} else if (lang == 'sp') {
    var inp = '<ons-search-input placeholder="Buscar" class="searchAssetsInput"></ons-search-input>';
    var o = '<ons-list-item class="m_listitem other" data-value="other" tappable>Otro</ons-list-item>';
} else if (lang == 'bul') {
    var inp = '<ons-search-input placeholder="Търсене" class="searchAssetsInput"></ons-search-input>';
   var o = '<ons-list-item class="m_listitem other" data-value="other" tappable>Друго</ons-list-item>';
} else if (lang == 'it') {
    var inp = '<ons-search-input placeholder="Ricerca" class="searchAssetsInput"></ons-search-input>';
    var o = '<ons-list-item class="m_listitem other" data-value="other" tappable>Altro</ons-list-item>';
} else if (lang == 'fr') {
    var inp = '<ons-search-input placeholder="بحث" class="searchAssetsInput"></ons-search-input>';
    var o = '<ons-list-item class="m_listitem other" data-value="other" tappable>Autre</ons-list-item>';
} else if (lang == 'ar') {
    var inp = '<ons-search-input placeholder="Rechercher" class="searchAssetsInput"></ons-search-input>';
    var o = '<ons-list-item class="m_listitem other" data-value="other" tappable>آخر</ons-list-item>';
}else if (lang == 'ja') {
var inp = '<ons-search-input placeholder="検索" class="searchAssetsInput"></ons-search-input>';
var o = '<ons-list-item class="m_listitem other" data-value="other" tappable>他</ons-list-item>';
}else if (lang == 'tu') {
var inp = '<ons-search-input placeholder="Arama" class="searchAssetsInput"></ons-search-input>';
var o = '<ons-list-item class="m_listitem other" data-value="other" tappable>Diğer</ons-list-item>';

} else {
    // Default to the original text if the language code is not recognized
    var inp = '<ons-search-input placeholder="Search" class="searchAssetsInput"></ons-search-input>';
    var o = '<ons-list-item class="m_listitem other" data-value="other" tappable>Other</ons-list-item>';
}

}else{

if (lang == 'ge') {
    var inp = '<ons-search-input placeholder="Gerät suchen" class="searchAssetsInput"></ons-search-input>';
    var o = '';
} else if (lang == 'po') {
    var inp = '<ons-search-input placeholder="Procurar" class="searchAssetsInput"></ons-search-input>';
    var o = '';
} else if (lang == 'sp') {
    var inp = '<ons-search-input placeholder="Buscar" class="searchAssetsInput"></ons-search-input>';
    var o = '';
} else if (lang == 'bul') {
    var inp = '<ons-search-input placeholder="Търсене" class="searchAssetsInput"></ons-search-input>';
   var o = '';
} else if (lang == 'it') {
    var inp = '<ons-search-input placeholder="Ricerca" class="searchAssetsInput"></ons-search-input>';
    var o = '';
} else if (lang == 'fr') {
    var inp = '<ons-search-input placeholder="Rechercher" class="searchAssetsInput"></ons-search-input>';
    var o = '';
} else if (lang == 'ar') {
    var inp = '<ons-search-input placeholder="بحث" class="searchAssetsInput"></ons-search-input>';
    var o = '';
}else if (lang == 'ja') {
   var inp = '<ons-search-input placeholder="検索" class="searchAssetsInput"></ons-search-input>';
    var o = '';
}else if (lang == 'tu') {
   var inp = '<ons-search-input placeholder="Arama" class="searchAssetsInput"></ons-search-input>';
    var o = '';
}else {
    // Default to the original text if the language code is not recognized
    var inp = '<ons-search-input placeholder="Search" class="searchAssetsInput"></ons-search-input>';
    var o = '';
}

}


$('.assetList_m').append(o);


var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

$.ajax({
    url: ''+host+'getAssets.php?email='+email+'&accesstoken='+accesstoken+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){
    
    var json = JSON.stringify(data);

    console.log(data);

     //var obj = parseJSON(data);
  var parsed_data = JSON.parse(data);


if(parsed_data['status'] == 'OK'){

    $('.iosspinnerHolder').remove();


  for(i=0;i<parsed_data.assets.length;i++){


      
var serial = parsed_data.assets[i].serial_number;
var full_name = parsed_data.assets[i].full_name;

$(".assetsSelect option").eq(-1).before('<option value="'+serial+'">'+full_name+'</option>');
$(".assetList_m").append('<ons-list-item class="m_listitem '+full_name+' '+serial+'" data-value="'+serial+'" tappable>'+full_name+' ('+serial+')</ons-list-item>');



$(".assetsSelect option").each(function() {
  $(this).siblings('[value="'+ this.value +'"]').remove();
});

var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

  }
}else{

console.log(data);
var parsed_data = JSON.parse(data);

    var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

function alertDismissed() {

}

navigator.notification.alert(
    parsed_data['msg'],  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);

}




    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});


     var textLength = $('button').text().length;;

        // Set the font size based on the text length
        // You can adjust the formula as needed
        var fontSize = Math.max(14, 16 - 0.1 * textLength) + 'px';
        $('.addImgManual').css('font-size', fontSize);

    newAddImgs = [];

//Check the scroll
var lastScrollTop = 0;
$('.page__content').scroll(function() {

var scrolled_val = $('.page__content:last').scrollTop();
//console.log(scrolled_val);
if(scrolled_val > 10 ){
 bottomToolbar.style.transform = 'translateY(100%)';
}else{
  bottomToolbar.style.transform = 'translateY(0)';
}

});

    var pr = localStorage.getItem('permissions_raise_internal_ticket');


    //var pmodal = document.getElementById('preloaderModal');
//pmodal.show();


var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

var values = { 
    'email': email,
    'accesstoken': accesstoken,
};


//get ticket admins here
    $.ajax({
    url: ''+host+'getTicketAdmins_new.php',
    //dataType: 'text',
     //dataType: 'text',
    data: values,
    type: 'POST',
    success: function( data, textStatus, jQxhr ){

    var json = JSON.stringify(data);

    console.log(data);

     //var obj = parseJSON(data);
  var parsed_data = JSON.parse(data);
if(parsed_data['status'] == 'OK'){
  for(i=0;i<parsed_data.ticket_admins.length;i++){
var full_name = parsed_data.ticket_admins[i].name;
var id = parsed_data.ticket_admins[i].id;
var email = parsed_data.ticket_admins[i].email;
var status = parsed_data.ticket_admins[i].status;
$('.ticketAdminSelect').append('<option value="'+id+'">'+full_name+' ('+email+')</option>');

  }
}else{

console.log(data);
var parsed_data = JSON.parse(data);

    var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

function alertDismissed() {

}

navigator.notification.alert(
    parsed_data['msg'],  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);

}
    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
    }
});


//get internal techs here...
 $.ajax({
    url: ''+host+'getCareTakers.php',
    //dataType: 'text',
     //dataType: 'text',
    data: values,
    type: 'POST',
    success: function( data, textStatus, jQxhr ){

    var json = JSON.stringify(data);

    console.log(data);

     //var obj = parseJSON(data);
  var parsed_data = JSON.parse(data);
if(parsed_data['status'] == 'OK'){
  for(i=0;i<parsed_data.caretakers.length;i++){
var full_name = parsed_data.caretakers[i].name;
var id = parsed_data.caretakers[i].id;
var email = parsed_data.caretakers[i].email;
$('.inetrnalTechSelect').append('<option value="'+id+'">'+full_name+'</option>');

  }
}else{

console.log(data);
var parsed_data = JSON.parse(data);

    var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

function alertDismissed() {

}

navigator.notification.alert(
    parsed_data['msg'],  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);

}
    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
    }
});


//get engineers for raising tickets manually here
//manualTicketType = 'ta';

}





if (page.matches('#open')) {




    // Get the toolbar element


    //Check the scroll
    var lastScrollTop = 0;
$('.page__content').scroll(function() {
var scrolled_val = $('.page__content:last').scrollTop();
//console.log(scrolled_val);
if(scrolled_val > 10 ){
      
         bottomToolbar.style.transform = 'translateY(100%)';
      
}else{
 // bottomToolbar.style.transform = 'translateY(0)';
 bottomToolbar.style.transform = 'translateY(0)';

}

});



localStorage.setItem('page_type', 'open');

 var uType = localStorage.getItem('usertype');


if(uType != 'Gym Operator'){

$('.addressList').show();
}else{
    //$('.descriptionList').show();

}



var pmodal = document.getElementById('preloaderModal');
pmodal.show();
  $('.tickets').remove();


var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

//$(this).prop('disabled', true);
//$('.loaderIcon').show();

$.ajax({
    url: ''+host+'getTickets.php?email='+email+'&accesstoken='+accesstoken+'&status=open',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

console.log(data);

      var json = JSON.stringify(data);

     var uType = localStorage.getItem('usertype');

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);


for(i=0;i<parsed_data.tickets.open_tickets.length;i++){

var output_string = "";


var is_service = parsed_data.tickets.open_tickets[i].is_service;
var type = parsed_data.tickets.open_tickets[i].type;





if(is_service == false){

    

var appendable = parsed_data.tickets.open_tickets[i].appendable;
var unactioned_notes = parsed_data.tickets.open_tickets[i].unactioned_notes;
unactioned_notes = objectLength(unactioned_notes);
var style = 'display: inline-table;';

if (unactioned_notes == '0'){

    style= 'display: none;';
}




var appendable_assets = parsed_data.tickets.open_tickets[i].appendable_assets;

var encodedObject = window.btoa(JSON.stringify(appendable_assets));
var ticket_number = parsed_data.tickets.open_tickets[i].ticket_number;

// Accessing the location if it's not null
let loc = parsed_data.tickets.open_tickets[i].location;
if (loc !== null) {
  // Do something with loc
  loc = parsed_data.tickets.open_tickets[i].location.name;
} else {
  loc = 'N/A';
}


//adding site names to the search dropdown
if(parsed_data.tickets.open_tickets[i].seller_package != null){

$('.descriptionList').append('<option value="'+parsed_data.tickets.open_tickets[i].seller_package?.description+'">'+parsed_data.tickets.open_tickets[i].seller_package?.description+'</option>');

}

var role = localStorage.getItem('role');
//changed here
if(uType == 'Gym Operator'){

    /*$('.addressList').append('<option value="'+parsed_data.tickets.open_tickets[i].seller_package?.buyer.buyer_profile.site_name+'">'+parsed_data.tickets.open_tickets[i].seller_package?.buyer.buyer_profile.site_name+'</option>');*/


}else if(uType == 'Service Provider' && role =='buyer'){

$('.addressList').append('<option value="'+parsed_data.tickets.open_tickets[i].seller_package?.seller.seller_profile.site_name+'">'+parsed_data.tickets.open_tickets[i].seller_package?.seller.seller_profile.site_name+'</option>');

}


var optionValues2 =[];
$('.addressList option').each(function(){
    //remove every undefined value here
    $(".addressList option[value='undefined']").remove();
   if($.inArray(this.value, optionValues2) >-1){
      $(this).remove()
   }else{
      optionValues2.push(this.value);
   }
});


var optionValues3 =[];
$('.descriptionList option').each(function(){
        //remove every undefined value here
    $(".descriptionList option[value='undefined']").remove();
   if($.inArray(this.value, optionValues3) >-1){
      $(this).remove()
   }else{
      optionValues3.push(this.value);
   }
});
    

  $('.noIcon').hide();

   var created_at = parsed_data.tickets.open_tickets[i].created_at;

  
  var date = new Date(created_at);
  
  var output = ((date.getMonth() > 8) ? (date.getMonth() + 1) : ('0' + (date.getMonth() + 1))) + '/' + ((date.getDate() > 9) ? date.getDate() : ('0' + date.getDate())) + '/' + date.getFullYear();

   var ticket_number = parsed_data.tickets.open_tickets[i].ticket_number;
   
   var uuid = parsed_data.tickets.open_tickets[i].uuid;

   if(uType == 'Gym Operator'){

if(type == 'standard'){

   var address = parsed_data.tickets.open_tickets[i].seller_package?.buyer.buyer_profile?.site_name ;
   var location = parsed_data.tickets.open_tickets[i].seller_package?.location;
   var des = parsed_data.tickets.open_tickets[i].seller_package?.description;


}else{
var address = 'N/A';
var location = 'N/A';
var des = 'N/A';

}
   }else if(uType == 'Service Provider' && role =='buyer'){
  var address = parsed_data.tickets.open_tickets[i].seller_package?.seller.seller_profile.site_name;
   }
   

var priority = parsed_data.tickets.open_tickets[i].priority;
if (priority != null){
priority = priority.replace('\u201d', '');

}else{
priority = 'N/A';
}

var notes = parsed_data.tickets.open_tickets[i].notes;
var nnotes = JSON.stringify(notes);

if(notes == null){

  notes = '';

}


var co = '<span class="trn">Club Name</span>';
if(uType == 'Gym Operator'){

   
if(type == 'standard'){
var company_name = parsed_data.tickets.open_tickets[i].seller_package?.buyer.buyer_profile?.company_name;
}else{
var company_name = 'N/A';
}
co = '<span class="trn">Service Provider</span>';


var assets = parsed_data.tickets.open_tickets[i].assets;



//adding ad-hoc tickets here...
if(type == 'ad-hoc'){

        var de = '--';
        de = trimString(de, 10); 
        var p = '--';

                var lang = localStorage.getItem('lang');
var tt = "Ticket No'";

if(lang == 'ge'){
    tt = "Ticket-Nr.";
} else if(lang == 'po'){
    tt = "Número do Bilhete";
} else if(lang == 'sp'){
    tt = "Número de Boletos";
} else if(lang == 'bul'){
    tt = "Билет номер";
} else if(lang == 'it'){
    tt = "Numero del biglietto";
} else if(lang == 'fr'){
    tt = "Numéro de billet";
}else if(lang == 'ar'){
    tt = "رقم التذكرة";
}else if(lang == 'ja'){
    tt = "チケット番";
}else if(lang == 'tu'){
   tt = "Bilet numarası";
} else {
    // Default to the original text if the language code is not recognized
    tt = "Ticket No'";
}

           
           $('<div class="tickets" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'"><div class="pn_in_circle animated flipInX" style="'+style+'"><span class="pn_in_circle__content">'+unactioned_notes+'</span></div><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="viewTicketBtn viewForLarge button trn" data-type="open" data-ticket="ad-hoc">View</button></div><div class="ticketSmallDetails" style="text-align:left;float:left;font-size:12px;padding-top:8px;"><b><span class="trn">Priority:</span> </b> '+priority +'<br><b><span class="trn">Location:</span> </b> '+loc +'<br><b><span class="trn">'+tt+':</span> </b> '+ticket_number +'<br><b><span class="trn">Date Raised:</span></b> '+created_at +'<br> <b>'+co+':</b> '+company_name+'<br> <b><span class="trn">Fault Description:</span></b> '+de+'<br> <b><span class="trn">Product:</span></b> Ad-hoc</div>').data('inner-notes', nnotes).appendTo('.o-tickets');

           var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
}


    for (var j = 0; j < assets.length; j++) {

  

        var lang = localStorage.getItem('lang');
var tt = "Ticket No'";

if(lang == 'ge'){
    tt = "Ticket-Nr.";
} else if(lang == 'po'){
    tt = "Número do Bilhete";
} else if(lang == 'sp'){
    tt = "Número de Boletos";
} else if(lang == 'bul'){
    tt = "Билет номер";
} else if(lang == 'it'){
    tt = "Numero del biglietto";
} else if(lang == 'fr'){
    tt = "Numéro de billet";
}else if(lang == 'ar'){
    tt = "رقم التذكرة";
} else if(lang == 'ja'){
    tt = "チケット番";
}else if(lang == 'tu'){
    tt = "Bilet numarası";
}else {
    // Default to the original text if the language code is not recognized
    tt = "Ticket No'";
}


        var de = assets[j].description;
        de = trimString(de, 10); 
        var p = assets[j].product_name;

if(p == null){

    p = 'N/A';
}
         
           
           $('<div class="tickets" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'"><div class="pn_in_circle animated flipInX" style="'+style+'"><span class="pn_in_circle__content">'+unactioned_notes+'</span></div><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="viewTicketBtn viewForLarge button trn" data-type="open">View</button></div><div class="ticketSmallDetails" style="text-align:left;float:left;font-size:12px;padding-top:8px;"><b><span class="trn">Priority:</span> </b> '+priority +'<br><b><span class="trn">Location:</span> </b> '+loc +'<br><b><span class="trn">'+tt+':</span> </b> '+ticket_number +'<br><b><span class="trn">Date Raised:</span></b> '+created_at +'<br> <b>'+co+':</b> '+company_name+'<br> <b><span class="trn">Fault Description:</span></b> '+de+'<br> <b><span class="trn">Product:</span></b> '+p+'</div>').data('inner-notes', nnotes).appendTo('.o-tickets');

var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
    }


}else if(uType == 'Service Provider' && role =='buyer'){


if(type == 'standard'){
var buyer_company_name = parsed_data.tickets.open_tickets[i].seller_package?.buyer.buyer_profile?.company_name;

var company_name = parsed_data.tickets.open_tickets[i].seller_package?.seller.seller_profile.site_name;
}else{
var company_name = 'N/A';
}



var cl = parsed_data.tickets.open_tickets[i].seller_package?.seller.seller_profile.company_name;


var assets = parsed_data.tickets.open_tickets[i].assets;


//adding ad-hoc tickets here...
if(type == 'ad-hoc'){

        var de = '--';
        de = trimString(de, 10); 
        var p = '--';

                var lang = localStorage.getItem('lang');
var tt = "Ticket No'";

if(lang == 'ge'){
    tt = "Ticket-Nr.";
} else if(lang == 'po'){
    tt = "Número do Bilhete";
} else if(lang == 'sp'){
    tt = "Número de Boletos";
} else if(lang == 'bul'){
    tt = "Билет номер";
} else if(lang == 'it'){
    tt = "Numero del biglietto";
} else if(lang == 'fr'){
    tt = "Numéro de billet";
} else if(lang == 'ar'){
    tt = "رقم التذكرة";
} else if(lang == 'ja'){
    tt = "チケット番";
} else if(lang == 'tu'){
    tt = "Bilet numarası";
}else {
    // Default to the original text if the language code is not recognized
    tt = "Ticket No'";
}
           
           $('<div class="tickets" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'"><div class="pn_in_circle animated flipInX" style="'+style+'"><span class="pn_in_circle__content">'+unactioned_notes+'</span></div><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="viewTicketBtn viewForLarge button trn" data-type="open" data-ticket="ad-hoc">View</button></div><div class="ticketSmallDetails" style="text-align:left;float:left;font-size:12px;padding-top:8px;"><b><span class="trn">Priority:</span> </b> '+priority +'<br><b><span class="trn">Location:</span> </b> '+loc +'<br><b><span class="trn">'+tt+':</span> </b> '+ticket_number +'<br><b><span class="trn">Date Raised:</span></b> '+created_at +'<br> <b>'+co+':</b> '+company_name+'<br> <b><span class="trn">Fault Description:</span></b> '+de+'<br> <b><span class="trn">Product:</span></b> Ad-hoc</div>').data('inner-notes', nnotes).appendTo('.o-tickets');

           var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
}



    for (var j = 0; j < assets.length; j++) {

        var lang = localStorage.getItem('lang');
var tt = "Ticket No'";

if(lang == 'ge'){
    tt = "Ticket-Nr.";
} else if(lang == 'po'){
    tt = "Número do Bilhete";
} else if(lang == 'sp'){
    tt = "Número de Boletos";
} else if(lang == 'bul'){
    tt = "Билет номер";
} else if(lang == 'it'){
    tt = "Numero del biglietto";
} else if(lang == 'fr'){
    tt = "Numéro de billet";
}  else if(lang == 'ar'){
    tt = "رقم التذكرة";
}else if(lang == 'ja'){
    tt = "チケット番";
}else if(lang == 'tu'){
    tt = "Bilet numarası";
}else {
    // Default to the original text if the language code is not recognized
    tt = "Ticket No'";
}

        
        var de = assets[j].description;
        de = trimString(de, 10);
        var p = assets[j].product_name;

           $('<div class="tickets" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'"><div class="pn_in_circle animated flipInX" style="'+style+'"><span class="pn_in_circle__content">'+unactioned_notes+'</span></div><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="button viewTicketBtn viewForLarge trn" data-type="open">View</button></div><div class="ticketSmallDetails" style="text-align:left;float:left;font-size:12px;padding-top:8px;"><b><span class="trn">Priority:</span> </b> '+priority +'<br><b><span class="trn">Location:</span> </b> '+loc +'<br><b><span class="trn">'+tt+':</span> </b> '+ticket_number +'<br><b><span class="trn">Company Name:</span> </b> '+cl+'<br><b>'+co+':</b> '+company_name+'<br> <b><span class="trn">Date Raised:</span> </b>'+created_at +'<br> <b><span class="trn">Fault Description:</span> </b> '+de+'<br> <b><span class="trn">Product:</span> </b> '+p+'</div>').data('inner-notes', nnotes).appendTo('.o-tickets');


var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
    }

}else{

if(type == 'standard'){
var company_name = parsed_data.tickets.open_tickets[i].seller_package?.buyer.buyer_profile?.company_name;
}else{
var company_name = 'N/A';
}
co = '<span class="trn">Service Provider</span>';


var assets = parsed_data.tickets.open_tickets[i].assets;
//adding ad-hoc tickets here...
if(type == 'ad-hoc'){

        var de = '--';
        de = trimString(de, 10); 
        var p = '--';

                var lang = localStorage.getItem('lang');
var tt = "Ticket No'";

if(lang == 'ge'){
    tt = "Ticket-Nr.";
} else if(lang == 'po'){
    tt = "Número do Bilhete";
} else if(lang == 'sp'){
    tt = "Número de Boletos";
} else if(lang == 'bul'){
    tt = "Билет номер";
} else if(lang == 'it'){
    tt = "Numero del biglietto";
} else if(lang == 'fr'){
    tt = "Numéro de billet";
} else if(lang == 'ar'){
    tt = "رقم التذكرة";
}else if(lang == 'ja'){
    tt = "チケット番";
}else if(lang == 'tu'){
   tt = "Bilet numarası";
}else {
    // Default to the original text if the language code is not recognized
    tt = "Ticket No'";
}

           
           $('<div class="tickets" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'"><div class="pn_in_circle animated flipInX" style="'+style+'"><span class="pn_in_circle__content">'+unactioned_notes+'</span></div><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="viewTicketBtn viewForLarge button trn" data-type="open" data-ticket="ad-hoc">View</button></div><div class="ticketSmallDetails" style="text-align:left;float:left;font-size:12px;padding-top:8px;"><b><span class="trn">Priority:</span> </b> '+priority +'<br><b><span class="trn">Location:</span> </b> '+loc +'<br><b><span class="trn">'+tt+':</span> </b> '+ticket_number +'<br><b><span class="trn">Date Raised:</span></b> '+created_at +'<br> <b>'+co+':</b> '+company_name+'<br> <b><span class="trn">Fault Description:</span></b> '+de+'<br> <b><span class="trn">Product:</span></b> Ad-hoc</div>').data('inner-notes', nnotes).appendTo('.o-tickets');

           var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
}


    for (var j = 0; j < assets.length; j++) {

        var lang = localStorage.getItem('lang');
var tt = "Ticket No'";

if(lang == 'ge'){
    tt = "Ticket-Nr.";
} else if(lang == 'po'){
    tt = "Número do Bilhete";
} else if(lang == 'sp'){
    tt = "Número de Boletos";
} else if(lang == 'bul'){
    tt = "Билет номер";
} else if(lang == 'it'){
    tt = "Numero del biglietto";
} else if(lang == 'fr'){
    tt = "Numéro de billet";
} else if(lang == 'ar'){
    tt = "رقم التذكرة";
}else if(lang == 'ja'){
    tt = "チケット番";
}else if(lang == 'tu'){
    tt = "Bilet numarası";

}else {
    // Default to the original text if the language code is not recognized
    tt = "Ticket No'";
}


        var de = assets[j].description;
        de = trimString(de, 10); 
        var p = assets[j].product_name;


           $('<div class="tickets" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'"><div class="pn_in_circle animated flipInX" style="'+style+'"><span class="pn_in_circle__content">'+unactioned_notes+'</span></div><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="viewTicketBtn viewForLarge button trn" data-type="open">View</button></div><div class="ticketSmallDetails" style="text-align:left;float:left;font-size:12px;padding-top:8px;"><b><span class="trn">Priority:</span> </b> '+priority +'<br><b><span class="trn">Location:</span> </b> '+loc +'<br><b><span class="trn">'+tt+':</span> </b> '+ticket_number +'<br><b><span class="trn">Date Raised:</span></b> '+created_at +'<br> <b>'+co+':</b> '+company_name+'<br> <b><span class="trn">Fault Description:</span></b> '+de+'<br> <b><span class="trn">Product:</span></b> '+p+'</div>').data('inner-notes', nnotes).appendTo('.o-tickets');

var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
    }

}




//created_at = created_at.split(" ")[0];



var pmodal = document.getElementById('preloaderModal');
pmodal.hide();


}

}

    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

$('.noIcon').show();
    }
});



}


if (page.matches('#close')) {


    //Check the scroll
    var lastScrollTop = 0;
$('.page__content').scroll(function() {
   /* var st = $('.page__content:last').scrollTop();
   if (st > lastScrollTop){

       bottomToolbar.style.transform = 'translateY(100%)';
   } else {
  
        bottomToolbar.style.transform = 'translateY(0)';
   }
   lastScrollTop = st;*/
var scrolled_val = $('.page__content:last').scrollTop();
//console.log(scrolled_val);
if(scrolled_val > 10 ){
 bottomToolbar.style.transform = 'translateY(100%)';
}else{
  bottomToolbar.style.transform = 'translateY(0)';
}

});


  $('.tickets').remove();

  if(uType != 'Gym Operator'){

$('.addressList').show();
}

var pmodal = document.getElementById('preloaderModal');
pmodal.show();

var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

//$(this).prop('disabled', true);
//$('.loaderIcon').show();

$.ajax({
    url: ''+host+'getTickets.php?email='+email+'&accesstoken='+accesstoken+'&status=closed',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

console.log(data);

      var json = JSON.stringify(data);

     var uType = localStorage.getItem('usertype');

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);


for(i=0;i<parsed_data.tickets.closed_tickets.length;i++){

var output_string = "";


var is_service = parsed_data.tickets.closed_tickets[i].is_service;
var type = parsed_data.tickets.closed_tickets[i].type;







if(is_service == false){


var appendable = parsed_data.tickets.closed_tickets[i].appendable;
var unactioned_notes = parsed_data.tickets.closed_tickets[i].unactioned_notes;


unactioned_notes = objectLength(unactioned_notes);
var style = 'display: inline-table;';

if (unactioned_notes == '0'){

    style= 'display: none;';
}




var appendable_assets = parsed_data.tickets.closed_tickets[i].appendable_assets;

var encodedObject = window.btoa(JSON.stringify(appendable_assets));
var ticket_number = parsed_data.tickets.closed_tickets[i].ticket_number;


if(parsed_data.tickets.closed_tickets[i].seller_package != null){

$('.descriptionList').append('<option value="'+parsed_data.tickets.closed_tickets[i].seller_package?.description+'">'+parsed_data.tickets.closed_tickets[i].seller_package?.description+'</option>');

}

var role = localStorage.getItem('role');
//changed here
if(uType == 'Gym Operator'){

    /*$('.addressList').append('<option value="'+parsed_data.tickets.closed_tickets[i].seller_package?.buyer.buyer_profile.site_name+'">'+parsed_data.tickets.closed_tickets[i].seller_package?.buyer.buyer_profile.site_name+'</option>');*/


}else if(uType == 'Service Provider' && role =='buyer'){

$('.addressList').append('<option value="'+parsed_data.tickets.closed_tickets[i].seller_package?.seller.seller_profile.site_name+'">'+parsed_data.tickets.closed_tickets[i].seller_package?.seller.seller_profile.site_name+'</option>');

}


var optionValues2 =[];
$('.addressList option').each(function(){
    //remove every undefined value here
    $(".addressList option[value='undefined']").remove();
   if($.inArray(this.value, optionValues2) >-1){
      $(this).remove()
   }else{
      optionValues2.push(this.value);
   }
});


var optionValues3 =[];
$('.descriptionList option').each(function(){
        //remove every undefined value here
    $(".descriptionList option[value='undefined']").remove();
   if($.inArray(this.value, optionValues3) >-1){
      $(this).remove()
   }else{
      optionValues3.push(this.value);
   }
});
    

  $('.noIcon').hide();

   var created_at = parsed_data.tickets.closed_tickets[i].created_at;

  
  var date = new Date(created_at);
  
  var output = ((date.getMonth() > 8) ? (date.getMonth() + 1) : ('0' + (date.getMonth() + 1))) + '/' + ((date.getDate() > 9) ? date.getDate() : ('0' + date.getDate())) + '/' + date.getFullYear();

   var ticket_number = parsed_data.tickets.closed_tickets[i].ticket_number;
   
   var uuid = parsed_data.tickets.closed_tickets[i].uuid;
   if(uType == 'Gym Operator'){

if(type == 'standard'){

   var address = parsed_data.tickets.closed_tickets[i].seller_package?.buyer.buyer_profile.site_name;
   var location = parsed_data.tickets.closed_tickets[i].seller_package?.location;
   var des = parsed_data.tickets.closed_tickets[i].seller_package?.description;
}else{
var address = 'N/A';
var location = 'N/A';
var des = 'N/A';

}
   }else if(uType == 'Service Provider' && role =='buyer'){
  var address = parsed_data.tickets.closed_tickets[i].seller_package?.seller.seller_profile.site_name;
   }
   

var priority = parsed_data.tickets.closed_tickets[i].priority;
if (priority != null){
priority = priority.replace('\u201d', '');

}else{
priority = 'N/A';
}

var notes = parsed_data.tickets.closed_tickets[i].notes;


if(notes == null){

  notes = '';

}


//adding ad-hoc tickets here...
if(type == 'ad-hoc'){


    if(type == 'standard'){
var company_name = parsed_data.tickets.closed_tickets[i].seller_package?.buyer.buyer_profile?.company_name;
}else{
var company_name = 'N/A';
}
co = '<span class="trn">Service Provider</span>';

var nnotes = JSON.stringify(notes);

        var de = '--';
        de = trimString(de, 10); 
        var p = '--';

                var lang = localStorage.getItem('lang');
var tt = "Ticket No'";

if(lang == 'ge'){
    tt = "Ticket-Nr.";
} else if(lang == 'po'){
    tt = "Número do Bilhete";
} else if(lang == 'sp'){
    tt = "Número de Boletos";
} else if(lang == 'bul'){
    tt = "Билет номер";
} else if(lang == 'it'){
    tt = "Numero del biglietto";
} else if(lang == 'fr'){
    tt = "Numéro de billet";
} else if(lang == 'ar'){
    tt = "رقم التذكرة";
}else if(lang == 'ja'){
    tt = "チケット番";
}else if(lang == 'tu'){
    tt = "Bilet numarası";

}else {
    // Default to the original text if the language code is not recognized
    tt = "Ticket No'";
}
           
           $('<div class="tickets" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'"><div class="pn_in_circle" style="'+style+'"><span class="pn_in_circle__content">'+unactioned_notes+'</span></div><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="viewTicketBtn viewForLarge button trn" data-type="open" data-ticket="ad-hoc">View</button></div><div class="ticketSmallDetails" style="text-align:left;float:left;font-size:12px;padding-top:8px;"><b><span class="trn">Priority:</span> </b> '+priority +'<br><b><span class="trn">'+tt+':</span> </b> '+ticket_number +'<br><b><span class="trn">Date Raised:</span></b> '+created_at +'<br> <b>'+co+':</b> '+company_name+'<br> <b><span class="trn">Fault Description:</span></b> '+de+'<br> <b><span class="trn">Product:</span></b> Ad-hoc</div>').data('inner-notes', nnotes).appendTo('.c-tickets');

           var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
}


var co = '<span class="trn">Club Name</span>';
if(uType == 'Gym Operator'){
if(type == 'standard'){
var company_name = parsed_data.tickets.closed_tickets[i].seller_package?.buyer.buyer_profile?.company_name;
}else{
var company_name = 'N/A';
}
co = '<span class="trn">Service Provider</span>';


var assets = parsed_data.tickets.closed_tickets[i].assets;

//ariana did my head 



for (var j = 0; j < assets.length; j++) {

        var lang = localStorage.getItem('lang');
var tt = "Ticket No'";

if(lang == 'ge'){
    tt = "Ticket-Nr.";
} else if(lang == 'po'){
    tt = "Número do Bilhete";
} else if(lang == 'sp'){
    tt = "Número de Boletos";
} else if(lang == 'bul'){
    tt = "Билет номер";
} else if(lang == 'it'){
    tt = "Numero del biglietto";
} else if(lang == 'fr'){
    tt = "Numéro de billet";
} else if(lang == 'ar'){
    tt = "رقم التذكرة";
}else if(lang == 'ja'){
    tt = "チケット番";
}else if(lang == 'tu'){
    tt = "Bilet numarası";

}else {
    // Default to the original text if the language code is not recognized
    tt = "Ticket No'";
}

        var de = assets[j].description;
        de = trimString(de, 10); 
        var p = assets[j].product_name;
           $('.c-tickets').append('<div class="tickets" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'"><div class="pn_in_circle" style="'+style+'"><span class="pn_in_circle__content">'+unactioned_notes+'</span></div><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="viewTicketBtn viewForLarge button trn" data-type="open">View</button></div><div class="ticketSmallDetails" style="text-align:left;float:left;font-size:12px;padding-top:8px;"><b><span class="trn">Priority:</span> </b> '+priority +'<br><b><span class="trn">'+tt+':</span> </b> '+ticket_number +'<br><b><span class="trn">Date Raised:</span></b> '+created_at +'<br> <b>'+co+':</b> '+company_name+'<br> <b><span class="trn">Fault Description:</span></b> '+de+'<br> <b><span class="trn">Product:</span></b> '+p+'</div>');

var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
    }


}else if(uType == 'Service Provider' && role =='buyer'){


if(type == 'standard'){
var buyer_company_name = parsed_data.tickets.closed_tickets[i].seller_package?.buyer.buyer_profile?.company_name;

var company_name = parsed_data.tickets.closed_tickets[i].seller_package?.seller.seller_profile.site_name;
}else{
var company_name = 'N/A';
}



var cl = parsed_data.tickets.closed_tickets[i].seller_package?.seller.seller_profile.company_name;


var assets = parsed_data.tickets.closed_tickets[i].assets;



    for (var j = 0; j < assets.length; j++) {

        var lang = localStorage.getItem('lang');
var tt = "Ticket No'";

if(lang == 'ge'){
    tt = "Ticket-Nr.";
} else if(lang == 'po'){
    tt = "Número do Bilhete";
} else if(lang == 'sp'){
    tt = "Número de Boletos";
} else if(lang == 'bul'){
    tt = "Билет номер";
} else if(lang == 'it'){
    tt = "Numero del biglietto";
} else if(lang == 'fr'){
    tt = "Numéro de billet";
}else if(lang == 'ar'){
    tt = "رقم التذكرة";
}else if(lang == 'ja'){
    tt = "チケット番";
}else if(lang == 'tu'){
    tt = "Bilet numarası";

}else {
    // Default to the original text if the language code is not recognized
    tt = "Ticket No'";
}
        
        var de = assets[j].description;
        de = trimString(de, 10);
        var p = assets[j].product_name;
           $('.c-tickets').append('<div class="tickets" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'"><div class="pn_in_circle" style="'+style+'"><span class="pn_in_circle__content">'+unactioned_notes+'</span></div><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="button viewTicketBtn viewForLarge trn" data-type="open">View</button></div><div class="ticketSmallDetails" style="text-align:left;float:left;font-size:12px;padding-top:8px;"><b><span class="trn">Priority:</span> </b> '+priority +'<br><b><span class="trn">'+tt+':</span> </b> '+ticket_number +'<br><b><span class="trn">Company Name:</span> </b> '+cl+'<br><b>'+co+':</b> '+company_name+'<br> <b><span class="trn">Date Raised:</span> </b>'+created_at +'<br> <b><span class="trn">Fault Description:</span> </b> '+de+'<br> <b><span class="trn">Product:</span> </b> '+p+'</div>');


var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
    }

}else{

if(type == 'standard'){
var company_name = parsed_data.tickets.closed_tickets[i].seller_package?.buyer.buyer_profile?.company_name;
}else{
var company_name = 'N/A';
}
co = '<span class="trn">Service Provider</span>';


var assets = parsed_data.tickets.closed_tickets[i].assets;



    for (var j = 0; j < assets.length; j++) {

        var lang = localStorage.getItem('lang');
var tt = "Ticket No'";

if(lang == 'ge'){
    tt = "Ticket-Nr.";
} else if(lang == 'po'){
    tt = "Número do Bilhete";
} else if(lang == 'sp'){
    tt = "Número de Boletos";
} else if(lang == 'bul'){
    tt = "Билет номер";
} else if(lang == 'it'){
    tt = "Numero del biglietto";
} else if(lang == 'fr'){
    tt = "Numéro de billet";
} else if(lang == 'ar'){
    tt = "رقم التذكرة";
}else if(lang == 'ja'){
    tt = "チケット番";
}else if(lang == 'tu'){
    tt = "Bilet numarası";

}else {
    // Default to the original text if the language code is not recognized
    tt = "Ticket No'";
}


        var de = assets[j].description;
        de = trimString(de, 10); 
        var p = assets[j].product_name;
           $('.c-tickets').append('<div class="tickets" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'"><div class="pn_in_circle" style="'+style+'"><span class="pn_in_circle__content">'+unactioned_notes+'</span></div><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="viewTicketBtn viewForLarge button trn" data-type="open">View</button></div><div class="ticketSmallDetails" style="text-align:left;float:left;font-size:12px;padding-top:8px;"><b><span class="trn">Priority:</span> </b> '+priority +'<br><b><span class="trn">'+tt+':</span> </b> '+ticket_number +'<br><b><span class="trn">Date Raised:</span></b> '+created_at +'<br> <b>'+co+':</b> '+company_name+'<br> <b><span class="trn">Fault Description:</span></b> '+de+'<br> <b><span class="trn">Product:</span></b> '+p+'</div>');

var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
    }

}




//created_at = created_at.split(" ")[0];



var pmodal = document.getElementById('preloaderModal');
pmodal.hide();


}

}

    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

$('.noIcon').show();
    }
});



}




if (page.matches('#sub')) {



    //Check the scroll
    var lastScrollTop = 0;
$('.page__content').scroll(function() {
var scrolled_val = $('.page__content:last').scrollTop();
//console.log(scrolled_val);
if(scrolled_val > 10 ){
 bottomToolbar.style.transform = 'translateY(100%)';
}else{
  bottomToolbar.style.transform = 'translateY(0)';
}

});
localStorage.setItem('page_type', 'parts required');

var uType = localStorage.getItem('usertype');


if(uType != 'Gym Operator'){

$('.addressList').show();
}else{
    //$('.descriptionList').show();

}



var pmodal = document.getElementById('preloaderModal');
pmodal.show();
  $('.tickets').remove();


var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

//$(this).prop('disabled', true);
//$('.loaderIcon').show();

$.ajax({
    url: ''+host+'getTickets.php?email='+email+'&accesstoken='+accesstoken+'&status=sub',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){



var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

console.log(data);

      var json = JSON.stringify(data);

     var uType = localStorage.getItem('usertype');

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);


for(i=0;i<parsed_data.tickets.open_sub_tickets.length;i++){

var output_string = "";

var is_service = parsed_data.tickets.open_sub_tickets[i].is_service;
var type = parsed_data.tickets.open_sub_tickets[i].type;


if(is_service == false){


    

var appendable = parsed_data.tickets.open_sub_tickets[i].appendable;
var unactioned_notes = parsed_data.tickets.open_sub_tickets[i].unactioned_notes;


unactioned_notes = objectLength(unactioned_notes);
var style = 'display: inline-table;';

if (unactioned_notes == '0'){

    style= 'display: none;';
}




var appendable_assets = parsed_data.tickets.open_sub_tickets[i].appendable_assets;

var encodedObject = window.btoa(JSON.stringify(appendable_assets));
var ticket_number = parsed_data.tickets.open_sub_tickets[i].ticket_number;



// Accessing the location if it's not null
let loc = parsed_data.tickets.open_sub_tickets[i].location;
if (loc !== null) {
  // Do something with loc
  loc = parsed_data.tickets.open_sub_tickets[i].location.name;
} else {
  loc = 'N/A';
}


if(parsed_data.tickets.open_sub_tickets[i].seller_package != null){

$('.descriptionList').append('<option value="'+parsed_data.tickets.open_sub_tickets[i].seller_package?.description+'">'+parsed_data.tickets.open_sub_tickets[i].seller_package?.description+'</option>');

}

var role = localStorage.getItem('role');
//changed here
if(uType == 'Gym Operator'){

    /*$('.addressList').append('<option value="'+parsed_data.tickets.open_sub_tickets[i].seller_package?.buyer.buyer_profile.site_name+'">'+parsed_data.tickets.open_sub_tickets[i].seller_package?.buyer.buyer_profile.site_name+'</option>');*/


}else if(uType == 'Service Provider' && role =='buyer'){

$('.addressList').append('<option value="'+parsed_data.tickets.open_sub_tickets[i].seller_package?.seller.seller_profile.site_name+'">'+parsed_data.tickets.open_sub_tickets[i].seller_package?.seller.seller_profile.site_name+'</option>');

}


var optionValues2 =[];
$('.addressList option').each(function(){
    //remove every undefined value here
    $(".addressList option[value='undefined']").remove();
   if($.inArray(this.value, optionValues2) >-1){
      $(this).remove()
   }else{
      optionValues2.push(this.value);
   }
});


var optionValues3 =[];
$('.descriptionList option').each(function(){
        //remove every undefined value here
    $(".descriptionList option[value='undefined']").remove();
   if($.inArray(this.value, optionValues3) >-1){
      $(this).remove()
   }else{
      optionValues3.push(this.value);
   }
});
    

  $('.noIcon').hide();

   var created_at = parsed_data.tickets.open_sub_tickets[i].created_at;

  
  var date = new Date(created_at);
  
  var output = ((date.getMonth() > 8) ? (date.getMonth() + 1) : ('0' + (date.getMonth() + 1))) + '/' + ((date.getDate() > 9) ? date.getDate() : ('0' + date.getDate())) + '/' + date.getFullYear();

   var ticket_number = parsed_data.tickets.open_sub_tickets[i].ticket_number;
   
   var uuid = parsed_data.tickets.open_sub_tickets[i].uuid;
   if(uType == 'Gym Operator'){

if(type == 'standard'){

   var address = parsed_data.tickets.open_sub_tickets[i].seller_package?.buyer.buyer_profile.site_name;
   var location = parsed_data.tickets.open_sub_tickets[i].seller_package?.location;
   var des = parsed_data.tickets.open_sub_tickets[i].seller_package?.description;
}else{
var address = 'N/A';
var location = 'N/A';
var des = 'N/A';

}
   }else if(uType == 'Service Provider' && role =='buyer'){
  var address = parsed_data.tickets.open_sub_tickets[i].seller_package?.seller.seller_profile.site_name;
   }
   

var priority = parsed_data.tickets.open_sub_tickets[i].priority;
if (priority != null){
priority = priority.replace('\u201d', '');

}else{
priority = 'N/A';
}

var notes = parsed_data.tickets.open_sub_tickets[i].notes;
var nnotes = JSON.stringify(notes);

if(notes == null){

  notes = '';

}


var co = '<span class="trn">Club Name</span>';
if(uType == 'Gym Operator'){
if(type == 'standard'){
var company_name = parsed_data.tickets.open_sub_tickets[i].seller_package?.buyer.buyer_profile?.company_name;
}else{
var company_name = 'N/A';
}
co = '<span class="trn">Service Provider</span>';


var assets = parsed_data.tickets.open_sub_tickets[i].assets;




//adding ad-hoc tickets here...
if(type == 'ad-hoc'){

        var de = '--';
        de = trimString(de, 10); 
        var p = '--';

                var lang = localStorage.getItem('lang');
var tt = "Ticket No'";

if(lang == 'ge'){
    tt = "Ticket-Nr.";
} else if(lang == 'po'){
    tt = "Número do Bilhete";
} else if(lang == 'sp'){
    tt = "Número de Boletos";
} else if(lang == 'bul'){
    tt = "Билет номер";
} else if(lang == 'it'){
    tt = "Numero del biglietto";
} else if(lang == 'fr'){
    tt = "Numéro de billet";
} else if(lang == 'ar'){
    tt = "رقم التذكرة";
}else if(lang == 'ja'){
    tt = "チケット番";
}else if(lang == 'tu'){
    tt = "Bilet numarası";

}else {
    // Default to the original text if the language code is not recognized
    tt = "Ticket No'";
}
           
           $('<div class="tickets" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'"><div class="pn_in_circle" style="'+style+'"><span class="pn_in_circle__content">'+unactioned_notes+'</span></div><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="viewTicketBtn viewForLarge button trn" data-type="open" data-ticket="ad-hoc">View</button></div><div class="ticketSmallDetails" style="text-align:left;float:left;font-size:12px;padding-top:8px;"><b><span class="trn">Priority:</span> </b> '+priority +'<br><b><span class="trn">Location:</span> </b> '+loc +'<br><b><span class="trn">'+tt+':</span> </b> '+ticket_number +'<br><b><span class="trn">Date Raised:</span></b> '+created_at +'<br> <b>'+co+':</b> '+company_name+'<br> <b><span class="trn">Fault Description:</span></b> '+de+'<br> <b><span class="trn">Product:</span></b> Ad-hoc</div>').data('inner-notes', nnotes).appendTo('.s-tickets');

           var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
}


    for (var j = 0; j < assets.length; j++) {

        var lang = localStorage.getItem('lang');
var tt = "Ticket No'";

if(lang == 'ge'){
    tt = "Ticket-Nr.";
} else if(lang == 'po'){
    tt = "Número do Bilhete";
} else if(lang == 'sp'){
    tt = "Número de Boletos";
} else if(lang == 'bul'){
    tt = "Билет номер";
} else if(lang == 'it'){
    tt = "Numero del biglietto";
} else if(lang == 'fr'){
    tt = "Numéro de billet";
}  else if(lang == 'ar'){
    tt = "رقم التذكرة";
}else if(lang == 'ja'){
    tt = "チケット番";
}else if(lang == 'tu'){
    tt = "Bilet numarası";

}else {
    // Default to the original text if the language code is not recognized
    tt = "Ticket No'";
}


        var de = assets[j].description;
        de = trimString(de, 10); 
        var p = assets[j].product_name;

           $('.s-tickets').append('<div class="tickets" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'"><div class="pn_in_circle" style="'+style+'"><span class="pn_in_circle__content">'+unactioned_notes+'</span></div><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="viewTicketBtn viewForLarge button trn" data-type="open">View</button></div><div class="ticketSmallDetails" style="text-align:left;float:left;font-size:12px;padding-top:8px;"><b><span class="trn">Priority:</span> </b> '+priority +'<br><b><span class="trn">Location:</span> </b> '+loc +'<br><b><span class="trn">'+tt+':</span> </b> '+ticket_number +'<br><b><span class="trn">Date Raised:</span></b> '+created_at +'<br> <b>'+co+':</b> '+company_name+'<br> <b><span class="trn">Fault Description:</span></b> '+de+'<br> <b><span class="trn">Product:</span></b> '+p+'</div>');

var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
    }


}else if(uType == 'Service Provider' && role =='buyer'){


if(type == 'standard'){
var buyer_company_name = parsed_data.tickets.open_sub_tickets[i].seller_package?.buyer.buyer_profile?.company_name;

var company_name = parsed_data.tickets.open_sub_tickets[i].seller_package?.seller.seller_profile.site_name;
}else{
var company_name = 'N/A';
}



var cl = parsed_data.tickets.open_sub_tickets[i].seller_package?.seller.seller_profile.company_name;


var assets = parsed_data.tickets.open_sub_tickets[i].assets;



//adding ad-hoc tickets here...
if(type == 'ad-hoc'){

        var de = '--';
        de = trimString(de, 10); 
        var p = '--';

                var lang = localStorage.getItem('lang');
var tt = "Ticket No'";

if(lang == 'ge'){
    tt = "Ticket-Nr.";
} else if(lang == 'po'){
    tt = "Número do Bilhete";
} else if(lang == 'sp'){
    tt = "Número de Boletos";
} else if(lang == 'bul'){
    tt = "Билет номер";
} else if(lang == 'it'){
    tt = "Numero del biglietto";
} else if(lang == 'fr'){
    tt = "Numéro de billet";
} else if(lang == 'ar'){
    tt = "رقم التذكرة";
}else if(lang == 'ja'){
    tt = "チケット番";
}else if(lang == 'tu'){
    tt = "Bilet numarası";

}else {
    // Default to the original text if the language code is not recognized
    tt = "Ticket No'";
}

           
           $('<div class="tickets" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'"><div class="pn_in_circle" style="'+style+'"><span class="pn_in_circle__content">'+unactioned_notes+'</span></div><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="viewTicketBtn viewForLarge button trn" data-type="open" data-ticket="ad-hoc">View</button></div><div class="ticketSmallDetails" style="text-align:left;float:left;font-size:12px;padding-top:8px;"><b><span class="trn">Priority:</span> </b> '+priority +'<br><b><span class="trn">Location:</span> </b> '+loc +'<br><b><span class="trn">'+tt+':</span> </b> '+ticket_number +'<br><b><span class="trn">Date Raised:</span></b> '+created_at +'<br> <b>'+co+':</b> '+company_name+'<br> <b><span class="trn">Fault Description:</span></b> '+de+'<br> <b><span class="trn">Product:</span></b> Ad-hoc</div>').data('inner-notes', nnotes).appendTo('.s-tickets');

           var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
}


    for (var j = 0; j < assets.length; j++) {

        var lang = localStorage.getItem('lang');
var tt = "Ticket No'";

if(lang == 'ge'){
    tt = "Ticket-Nr.";
} else if(lang == 'po'){
    tt = "Número do Bilhete";
} else if(lang == 'sp'){
    tt = "Número de Boletos";
} else if(lang == 'bul'){
    tt = "Билет номер";
} else if(lang == 'it'){
    tt = "Numero del biglietto";
} else if(lang == 'fr'){
    tt = "Numéro de billet";
} else if(lang == 'ar'){
    tt = "رقم التذكرة";
}else if(lang == 'ja'){
    tt = "チケット番";
}else if(lang == 'tu'){
    tt = "Bilet numarası";

}else {
    // Default to the original text if the language code is not recognized
    tt = "Ticket No'";
}

        
        var de = assets[j].description;
        de = trimString(de, 10);
        var p = assets[j].product_name;
           $('.s-tickets').append('<div class="tickets" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'"><div class="pn_in_circle" style="'+style+'"><span class="pn_in_circle__content">'+unactioned_notes+'</span></div><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="button viewTicketBtn viewForLarge trn" data-type="open">View</button></div><div class="ticketSmallDetails" style="text-align:left;float:left;font-size:12px;padding-top:8px;"><b><span class="trn">Priority:</span> </b> '+priority +'<br><b><span class="trn">Location:</span> </b> '+loc +'<br><b><span class="trn">'+tt+':</span> </b> '+ticket_number +'<br><b><span class="trn">Company Name:</span> </b> '+cl+'<br><b>'+co+':</b> '+company_name+'<br> <b><span class="trn">Date Raised:</span> </b>'+created_at +'<br> <b><span class="trn">Fault Description:</span> </b> '+de+'<br> <b><span class="trn">Product:</span> </b> '+p+'</div>');


var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
    }

}else{

if(type == 'standard'){
var company_name = parsed_data.tickets.open_sub_tickets[i].seller_package?.buyer.buyer_profile?.company_name;
}else{
var company_name = 'N/A';
}
co = '<span class="trn">Service Provider</span>';


var assets = parsed_data.tickets.open_sub_tickets[i].assets;

//adding ad-hoc tickets here...
if(type == 'ad-hoc'){

        var de = '--';
        de = trimString(de, 10); 
        var p = '--';

                var lang = localStorage.getItem('lang');
var tt = "Ticket No'";

if(lang == 'ge'){
    tt = "Ticket-Nr.";
} else if(lang == 'po'){
    tt = "Número do Bilhete";
} else if(lang == 'sp'){
    tt = "Número de Boletos";
} else if(lang == 'bul'){
    tt = "Билет номер";
} else if(lang == 'it'){
    tt = "Numero del biglietto";
} else if(lang == 'fr'){
    tt = "Numéro de billet";
} else if(lang == 'ar'){
    tt = "رقم التذكرة";
}else if(lang == 'ja'){
    tt = "チケット番";
}else if(lang == 'tu'){
    tt = "Bilet numarası";

}else {
    // Default to the original text if the language code is not recognized
    tt = "Ticket No'";
}

           
           $('<div class="tickets" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'"><div class="pn_in_circle" style="'+style+'"><span class="pn_in_circle__content">'+unactioned_notes+'</span></div><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="viewTicketBtn viewForLarge button trn" data-type="open" data-ticket="ad-hoc">View</button></div><div class="ticketSmallDetails" style="text-align:left;float:left;font-size:12px;padding-top:8px;"><b><span class="trn">Priority:</span> </b> '+priority +'<br><b><span class="trn">Location:</span> </b> '+loc +'<br><b><span class="trn">'+tt+':</span> </b> '+ticket_number +'<br><b><span class="trn">Date Raised:</span></b> '+created_at +'<br> <b>'+co+':</b> '+company_name+'<br> <b><span class="trn">Fault Description:</span></b> '+de+'<br> <b><span class="trn">Product:</span></b> Ad-hoc</div>').data('inner-notes', nnotes).appendTo('.s-tickets');

           var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
}

    for (var j = 0; j < assets.length; j++) {

        var lang = localStorage.getItem('lang');
var tt = "Ticket No'";

if(lang == 'ge'){
    tt = "Ticket-Nr.";
} else if(lang == 'po'){
    tt = "Número do Bilhete";
} else if(lang == 'sp'){
    tt = "Número de Boletos";
} else if(lang == 'bul'){
    tt = "Билет номер";
} else if(lang == 'it'){
    tt = "Numero del biglietto";
} else if(lang == 'fr'){
    tt = "Numéro de billet";
} else if(lang == 'ar'){
    tt = "رقم التذكرة";
}else if(lang == 'ja'){
    tt = "チケット番";
}else if(lang == 'tu'){
    tt = "Bilet numarası";

}else {
    // Default to the original text if the language code is not recognized
    tt = "Ticket No'";
}


        var de = assets[j].description;
        de = trimString(de, 10); 
        var p = assets[j].product_name;
           $('.s-tickets').append('<div class="tickets" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'"><div class="pn_in_circle" style="'+style+'"><span class="pn_in_circle__content">'+unactioned_notes+'</span></div><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="viewTicketBtn viewForLarge button trn" data-type="open">View</button></div><div class="ticketSmallDetails" style="text-align:left;float:left;font-size:12px;padding-top:8px;"><b><span class="trn">Priority:</span> </b> '+priority +'<br><b><span class="trn">Location:</span> </b> '+loc +'<br><b><span class="trn">'+tt+':</span> </b> '+ticket_number +'<br><b><span class="trn">Date Raised:</span></b> '+created_at +'<br> <b>'+co+':</b> '+company_name+'<br> <b><span class="trn">Fault Description:</span></b> '+de+'<br> <b><span class="trn">Product:</span></b> '+p+'</div>');

var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
    }

}




//created_at = created_at.split(" ")[0];



var pmodal = document.getElementById('preloaderModal');
pmodal.hide();


}

}

    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

$('.noIcon').show();
    }
});



}





});

document.addEventListener('prepop', function(event) {



var page = document.querySelector('#myNavigator').topPage.id;



if (page == 'edit') {




var appendable = localStorage.getItem('appendable');
 var uType = localStorage.getItem('usertype');

if(uType != 'Gym Operator'){
    $('.dpb').removeClass('deployed');
}
var ticket_status = localStorage.getItem('ticket_status');




if(ticket_status != 'open' && ticket_status != 'su-open'){
$('.dpb').addClass('deployed');
}


if(ticket_status != 'open' && ticket_status != 'dep' && ticket_status != 'su-open'){
 //$('.closeTicketBtn').addClass('hider');

}


if(ticket_status == 'open' ||  ticket_status == 'su-open' ||  ticket_status == 'dep'){
   $('.addAssetToTicket').removeClass('scannerTwo');

}

if(appendable == '1'){
$('.addAssetToTicket').removeClass('scannerTwo');
}else{
$('.addAssetToTicket').addClass('scannerTwo');
}




$('.assBtns').remove();

comps = 0;

innerNotes = [];

var uuid = localStorage.getItem('uuid');
var ticketNo = localStorage.getItem('ticketNumber');
var notes = localStorage.getItem('notes');

var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

//$(this).prop('disabled', true);
//$('.loaderIcon').show();

howMany = 0;

//you better look here

$.ajax({
    url: ''+host+'getTicket.php?email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

      var json = JSON.stringify(data);

      console.log(json);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);

localStorage.setItem('current-viewing-assets', json);

console.log(parsed_data.ticket.service_level_agreements);

localStorage.setItem('service_level_agreements', JSON.stringify(parsed_data.ticket.service_level_agreements));

for(i=0;i<parsed_data.ticket.assets.length;i++){


   var full_name = parsed_data.ticket.assets[i].full_name;

   var description = parsed_data.ticket.assets[i].description

    var serial_number = parsed_data.ticket.assets[i].serial_number;

var manF = parsed_data.ticket.assets[i].manufacturer_serial_number;
var manf2 = '';
if (manF == null){
manf2 = 'Not Provided';
}else{
manf2 = manF;
}



    var complete = parsed_data.ticket.assets[i].complete;
    var trashed = parsed_data.ticket.assets[i].trashed;

    var ticketNumber = parsed_data.ticket.assets[i].serial_number;
    var ticketassetimages = JSON.stringify(parsed_data.ticket.assets[i].ticket_asset_images);


var has_odometer = parsed_data.ticket.assets[i].has_odometer;


    var comp = '';

    

if(complete == 1){

comps++;

comp = "<div class='removed' data-serial='"+serial_number+"' data-hasodometer='"+has_odometer+"' data-id='"+uuid+"'>Marked As Complete <br><ons-icon icon='fa-check-circle' size='20px'></ons-icon></div>";

    }else{

if(trashed == true){

comp = "<div class='deleted' data-serial='"+serial_number+"' data-hasodometer='"+has_odometer+"' data-id='"+uuid+"'>This Asset Is Being Deleted <br><ons-icon icon='fa-trash' size='20px'></ons-icon></div>";

}else{

howMany++;

comp = "<div class='remover' data-serial='"+serial_number+"' data-hasodometer='"+has_odometer+"' data-id='"+uuid+"'> Mark As Complete <br><ons-icon icon='fa-check-circle' size='20px'></ons-icon></div>";

}
    }
   
var img = parsed_data.ticket.assets[i].image['thumb'];

var innernotes = []


if(uType == 'Gym Operator'){


$('.ticketList').append("<ons-list-item data-manF='"+manf2+"' data-imgs='"+ticketassetimages+"' data-ticketNumber='"+ticketNumber+"' data-dis='"+description+"' data-notes='"+innernotes+"' data-seria='"+serial_number+"' tappable><div class='left'><img class='list-item__thumbnail' src='https://"+apiType+".weservicegymequipment.com/"+img+"'></div><div class='center'><span class='list-item__title' style='color:black;'>"+full_name+"</span></div></ons-list-item>");




}else{

if(trashed == true){

$('.ticketList').append("<ons-list-item class='trashed' data-imgs='"+ticketassetimages+"' data-dis='"+description+"' data-ticketNumber='"+ticketNumber+"' data-notes='"+innernotes+"' data-seria='"+serial_number+"' class='list-item' ng-repeat='item in items'><ons-carousel swipeable style='height: 72px; width: 100%;' initial-index='1' auto-scroll><ons-carousel-item class='list-action-menu'>"+comp+"</ons-carousel-item><ons-carousel-item class='list-action-item'><ons-row><ons-col width='52px' style='padding: 10px 0 0 0;'><div class='left'><img class='list-item__thumbnail' src='https://"+apiType+".weservicegymequipment.com/"+img+"'></div></ons-col><ons-col><div class='name'>"+full_name+"</div><div class='desc'>This Asset is being deleted.</div></ons-col></ons-row></ons-carousel-item></ons-carousel></ons-list-item>");
}else{
  $('.ticketList').append("<ons-list-item data-manF='"+manf2+"' data-imgs='"+ticketassetimages+"' data-dis='"+description+"' data-ticketNumber='"+ticketNumber+"' data-notes='"+innernotes+"' data-seria='"+serial_number+"' class='list-item' ng-repeat='item in items'><ons-carousel swipeable style='height: 72px; width: 100%;' initial-index='1' auto-scroll><ons-carousel-item class='list-action-menu'>"+comp+"</ons-carousel-item><ons-carousel-item class='list-action-item'><ons-row><ons-col width='52px' style='padding: 10px 0 0 0;'><div class='left'><img class='list-item__thumbnail' src='https://"+apiType+".weservicegymequipment.com/"+img+"'></div></ons-col><ons-col><div class='name'>"+full_name+"</div><div class='desc'>Swipe right for actions.</div></ons-col></ons-row></ons-carousel-item></ons-carousel></ons-list-item>");

}
}




}



    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
    }
});



}

if (page == 'ticket-details') {
       $('.tickets').remove();

    }
    
 });

 document.addEventListener('init', function(event) {
var page = event.target;

if(page.matches('#assets')){

    //Check the scroll
    var lastScrollTop = 0;
$('.page__content').scroll(function() {
 
var scrolled_val = $('.page__content:last').scrollTop();
//console.log(scrolled_val);
if(scrolled_val > 10 ){
 bottomToolbar.style.transform = 'translateY(100%)';
}else{
  bottomToolbar.style.transform = 'translateY(0)';
}

});

    var pmodal = document.getElementById('preloaderModal');
pmodal.show();

var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

$.ajax({
    url: `${host}getAssets.php?email=${email}&accesstoken=${accesstoken}`,
    dataType: 'json', // This expects the server to respond with JSON content
    type: 'GET',
    processData: false,
    success: function(data, textStatus, jQxhr) {
        var pmodal = document.getElementById('preloaderModal');
        pmodal.hide();

        console.log(JSON.stringify(data)); // Log the data as a string for debugging

        if (data.status == 'OK') {
            $('.assetManagmentBtn').remove();
            $('.noIcon').hide();

            let htmlContent = ''; // Initialize an empty string to hold all your HTML

            data.assets.forEach((asset) => {
                const serial = asset.serial_number;
                const full_name = asset.full_name;
                const image = asset.image ? `https://${apiType}.weservicegymequipment.com/${asset.image.thumb}` : 'images/no_img.jpg';

                // Append each item's HTML to the htmlContent string
                htmlContent += `
                    <ons-list-item modifier="chevron" class="assetManagmentBtn" data-serial="${serial}">
                        <div class="left">
                            <img class="list-item__thumbnail" src="${image}">
                        </div>
                        <div class="center" style="color:black !important;">
                            <span class="list-item__title">${serial}</span><span class="list-item__subtitle">${full_name}</span>
                        </div>
                    </ons-list-item>`;
            });

            // Append the complete HTML string to the DOM at once
            $('.assetsList').append(htmlContent);
        } else {
            console.log(data); // Log raw data if status is not OK

            function alertDismissed() {
                // Placeholder for callback; could be used for cleanup actions
            }

            navigator.notification.alert(
                data.msg, // message
                alertDismissed, // callback
                '', // title
                'OK' // buttonName
            );
        }
    },
    error: function(jqXhr, textStatus, errorThrown) {
        console.log(errorThrown);
        var pmodal = document.getElementById('preloaderModal');
        pmodal.hide();
    }
});


}

if (page.matches('#form')) {

        var lastScrollTop = 0;
$('.page__content').scroll(function() {
    checkViewportAndAnimate();
var scrolled_val = $('.page__content:last').scrollTop();
//console.log(scrolled_val);
if(scrolled_val > 10 ){
    
 bottomToolbar.style.transform = 'translateY(100%)';
}else{
  bottomToolbar.style.transform = 'translateY(0)';
}

});

var id = page.data.id;
localStorage.setItem('currentFormId', id);


var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

var values = { 
    'email': email,
    'accesstoken': accesstoken,
    'id': id,
};


function convertDateFormat(dateString) {
    if (!dateString || typeof dateString !== 'string') {
        //console.error('Invalid date format:', dateString);
        return '';
    }

    // Check if the date is already in yyyy-mm-dd format
    if (/^\d{4}-\d{2}-\d{2}$/.test(dateString)) {
        return dateString;
    }

    // Replace escaped slashes with normal slashes
    var correctedDateString = dateString.replace(/\\\//g, '/');
    var parts = correctedDateString.split('/');

    // Ensure the parts array has exactly three elements
    if (parts.length !== 3) {
        console.error('Invalid date format:', correctedDateString);
        return '';
    }

    return parts[2] + '-' + parts[1] + '-' + parts[0];
}



$.ajax({
    url: host + 'getForm.php',
    data: values,
    type: 'POST',
    success: function(data, textStatus, jQxhr) {
        var parsed_data = typeof data === "string" ? JSON.parse(data) : data;

        if (parsed_data.status === 'OK') {
            var dataItems = parsed_data.form.data;
            originalFormData = parsed_data.form.data;


            console.log(data);

            var groupedItems = {};

            // Grouping items by category
            dataItems.forEach(function(item) {
                if (!groupedItems[item.category]) {
                    groupedItems[item.category] = [];
                }
                groupedItems[item.category].push(item);
            });

            var formHtml = '';

            // Creating form HTML for each category
            for (var category in groupedItems) {
                if (groupedItems.hasOwnProperty(category)) {
                    formHtml += '<fieldset class="q_fields"><legend>' + category + '</legend>';

                    groupedItems[category].forEach(function(item) {
                        var ticketCheck = '<input style="display:inline-block !important" type="checkbox" name="' + item.key + '_ticketCheck">';
                        if (item.ticket != false) {
                            ticketCheck = '<input style="display:inline-block !important" type="checkbox" name="' + item.key + '_ticketCheck" disabled="true" checked>';
                        }
                        var reasonForNot = item.reason ? item.reason : '';

                        var element = "";
                        var reasonInputId = item.key + '_reason';
                        switch (item.type) {
                            case "checkbox":
                                var checked = item.checked === '1' ? 'checked' : '';
                                var lab = '';
                                if(item.label == null){
                                    
                                }else{

                                    lab = item.label;

                                }
                                element = '<div class="gatherFormData"><input class="formCheck" style="display:inline-block !important" type="checkbox" id="' + item.key + '" name="' + item.key + '" ' + checked + '>';
                                element += '<span for="' + item.key + '">' + lab + '<ons-icon class="fff" icon="fa-chevron-circle-down"></ons-icon></span><div class="fff_div"><span class="trn">Comment</span><input placeholder="e.g Not able to access area" value="' + reasonForNot + '" class="formInps" style="display:inline-block !important" type="text" id="' + reasonInputId + '" name="reason"><div class="customLabel"><span class="trn">Create Ticket</span>?' + ticketCheck + '</div></div></div><br><hr><br>';
                                break;
                            case "date":
                                var formattedDate = convertDateFormat(item.value);
                                element = '<div class="gatherFormData"><ons-icon icon="fa-calendar"></ons-icon>';
                                element += '<span for="' + item.key + '">' + item.label + '<ons-icon class="fff" icon="fa-chevron-circle-down"></ons-icon></span><div class="fff_div"><span class="trn">Comment</span><input placeholder="e.g Not able to access area" value="' + reasonForNot + '" name="reason" class="formInps" style="display:inline-block !important" type="text" id="' + reasonInputId + '"><div class="customLabel"><span class="trn">Create Ticket</span>?' + ticketCheck + '</div></div>';
                                element += '<input class="formInps" type="date" id="' + item.key + '" name="' + item.key + '" value="' + formattedDate + '"></div><br><hr><br>';
                                break;
                            case "number":
                                element = '<div class="gatherFormData"><ons-icon icon="fa-sort-numeric-asc"></ons-icon>';
                                element += '<span for="' + item.key + '">' + item.label + '<ons-icon class="fff" icon="fa-chevron-circle-down"></ons-icon></span><div class="fff_div"><span class="trn">Comment</span><input placeholder="e.g Not able to access area" value="' + reasonForNot + '" class="formInps" style="display:inline-block !important" type="text" id="' + reasonInputId + '" name="reason"><div class="customLabel"><span class="trn">Create Ticket</span>?' + ticketCheck + '</div></div>';
                                element += '<input class="formInps" style="display:inline-block !important" type="number" id="' + item.key + '" name="' + item.key + '" value="' + item.value + '"></div><br><hr><br>';
                                break;
                            case "radios":
                                element = '<div class="gatherFormData"><span>' + item.label + '<ons-icon class="fff" icon="fa-chevron-circle-down"></ons-icon></span><div class="fff_div"><span class="trn">Comment</span><input placeholder="e.g Not able to access area" value="' + reasonForNot + '" class="formInps" style="display:inline-block !important" type="text" id="' + reasonInputId + '" name="reason"><div class="customLabel"><span class="trn">Create Ticket</span>?' + ticketCheck + '</div></div><br>';
                                item.radios.forEach(function(radio) {
                                    var checked = (radio.value === item.value) ? 'checked' : '';
                                    element += '<input style="display:inline-block !important" type="radio" id="' + radio.id + '" name="' + item.key + '" value="' + radio.value + '" ' + checked + '>';
                                    element += '<label for="' + radio.id + '">' + radio.text + '</label><br>';
                                });
                                element += '</div><br>'; // Close the gatherFormData div
                                break;
                            case "select":
                                element = '<div class="gatherFormData"><ons-icon icon="fa-list-alt"></ons-icon>';
                                element += '<span for="' + item.key + '">' + item.label + '<ons-icon class="fff" icon="fa-chevron-circle-down"></ons-icon></span><div class="fff_div"><span class="trn">Comment</span><input placeholder="e.g Not able to access area" value="' + reasonForNot + '" class="formInps" style="display:inline-block !important" type="text" id="' + reasonInputId + '" name="reason"><div class="customLabel"><span class="trn">Create Ticket</span>?' + ticketCheck + '</div></div>';
                                element += '<select class="formInps" style="display:inline-block !important" id="' + item.key + '" name="' + item.key + '">';
                                item.options.forEach(function(option) {
                                    var selected = (option.value === item.value) ? 'selected' : '';
                                    element += '<option value="' + option.value + '" ' + selected + '>' + option.text + '</option>';
                                });
                                element += '</select></div><br><hr><br>';
                                break;
                            case "text":
                                element = '<div class="gatherFormData"><ons-icon icon="fa-text-width"></ons-icon>';
                                element += '<span for="' + item.key + '">' + item.label + '<ons-icon class="fff" icon="fa-chevron-circle-down"></ons-icon></span><div class="fff_div"><span class="trn">Comment</span><input placeholder="e.g Not able to access area" value="' + reasonForNot + '" class="formInps" style="display:inline-block !important" type="text" id="' + reasonInputId + '" name="reason"><div class="customLabel"><span class="trn">Create Ticket</span>?' + ticketCheck + '</div></div>';
                                element += '<input class="formInps" style="display:inline-block !important" type="text" id="' + item.key + '" name="' + item.key + '" value="' + item.value + '"></div><br><hr><br>';
                                break;
                            case "time":
                                element = '<div class="gatherFormData"><ons-icon icon="fa-clock"></ons-icon>';
                                element += '<span for="' + item.key + '">' + item.label + '<ons-icon class="fff" icon="fa-chevron-circle-down"></ons-icon></span><div class="fff_div"><span class="trn">Comment</span><input class="formInps" style="display:inline-block !important" type="text" id="' + reasonInputId + '" name="reason" placeholder="e.g Not able to access area"><div class="customLabel"><span class="trn">Create Ticket</span>?' + ticketCheck + '</div></div>';
                                element += '<input class="formInps" style="display:inline-block !important" type="time" id="' + item.key + '" name="' + item.key + '" value="' + item.value + '"></div><br><hr><br>';
                                break;
                            default:
                                break;
                        }
                        formHtml += element;
                    });

                    formHtml += '</fieldset>';
                }
            }

            $('.form-container').append(formHtml);

                var lang = localStorage.getItem('lang');


var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
        }
    },
    error: function(jqXhr, textStatus, errorThrown) {
        console.error(errorThrown);
    }
});








}



if (page.matches('#asset')) {
    var lang = localStorage.getItem('lang');


var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
}

if (page.matches('#open')) {
    var lang = localStorage.getItem('lang');


var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
}

if (page.matches('#raise-manually')) {


    getPermissions();
    var lang = localStorage.getItem('lang');


var translator = $('body').translate({lang: "en", t: dict});
translator.lang(lang);
}



if (page.matches('#close')) {
    var lang = localStorage.getItem('lang');

var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
}

if (page.matches('#deployed')) {
    var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);

}

if (page.matches('#sub')) {
    var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);

}

if (page.matches('#home2')) {


if(localStorage.getItem('email') != null){

    getMyContracts();

}




// function for murph animation
    (function(){
	var app_transform = '';
	var $body = document.body,
			$appContainer = document.querySelector('.c-app-container'),
			$appContainer_title = $appContainer.querySelector('.c-app-container__title'),
			$appContainer_body = $appContainer.querySelector('.c-app-container__body'),
			$apps = document.querySelectorAll('.c-app');
			
	
	var getApp = function( e ){
		var index = getIndex( e.target ),
				$app = $apps[index],
				app_title = $app.querySelector('.c-app__title').textContent,
				app_body = $app.querySelector('.c-app__body').innerHTML;
		
		$appContainer_title.innerHTML = app_title
		$appContainer_body.innerHTML = app_body
		//$appContainer.setAttribute("data-bg-color", e.target.getAttribute("data-bg-color"))
		openApp( e )
	}

	
	var openApp = function( e ){
		var app_bounding_rect = $appContainer.getBoundingClientRect(),
				tile_bounding_rect = e.target.getBoundingClientRect()
				translateX =  tile_bounding_rect.left + 'px',
				translateY =  tile_bounding_rect.top + 'px',
				scaleX = tile_bounding_rect.width / app_bounding_rect.width,
				scaleY = tile_bounding_rect.height / app_bounding_rect.height;
	
		app_transform = "translate3d("+ translateX +","+ translateY+",0) scale("+ scaleX +", "+ scaleY +")";
		$appContainer.style.transform = app_transform
		document.body.offsetWidth; // force reflow
       
      $('.c-app-container').css('background-color', '#a5c432');
		$body.classList.add("-app-open");
		$appContainer.style.transform = "translate3d(0,0,0) scale(1)";
	}
	
	var closeApp = function( e ){
		$appContainer.addEventListener('transitionend',resetApp, false);
		$appContainer.style.transform = app_transform;
		$body.classList.add("-app-close");
		$body.classList.remove("-app-open");
	}
															
	var resetApp = function(e){
		if( e.target === $appContainer){
			$body.classList.remove("-app-close");
			$appContainer.removeAttribute('style')
			$appContainer.removeEventListener('transitionend',resetApp);
		}
	}
	
	//document.addEventListener('click', function(e) {
    $(document).on('click', '.c-app__tile', function(e){


		var matches = e.target.matches('.c-app__tile');

matches = true;
        
        if( matches) {
					getApp(e)
				}
	});
	
	document.addEventListener('click', function(e) {
		var matches = e.target.matches('.c-app-container__dismiss');
		if( matches ){
			closeApp( e );
            setTimeout(doSomething, 800);

function doSomething() {
  callQRscannerUpholstery(); 
            newTicketasset = [];
}
            
		}
	}, false);
	
	var getIndex = function( node ){
    var children = node.parentNode.childNodes;
    var num = 0;
    for (var i=0; i<children.length; i++) {
         if (children[i]==node) return num;
         if (children[i].nodeType==1) num++;
    }
   return -1;
	}
	
	
})();


//recordVideo();

function doSomething() {
   //do whatever you want here



      const localVideo = document.getElementById('localVideo');
    const remoteVideo = document.getElementById('remoteVideo');
    const callButton = document.getElementById('callButton');
    let localStream;

	  
    // Create a unique peer ID
	  const customPeerId = 'dee';
    const peer = new Peer(customPeerId,{
      debug: 3,
    });

    // Get user media and display local video
navigator.mediaDevices.getUserMedia({ video: true, audio: true })
  .then((stream) => {
    localVideo.srcObject = stream;
    localStream = stream;

    // Event handling for incoming call
    peer.on('call', (call) => {
      // Answer the call and send our stream to the remote peer
      call.answer(localStream);

      // Event handling for receiving remote stream
      call.on('stream', (remoteStream) => {
        remoteVideo.srcObject = remoteStream;
      });
    });
  })
  .catch((error) => {
    console.error('Error accessing media devices:', JSON.stringify(error));
    alert('Error accessing media devices. Please check permissions and try again.');
  });


    // Event handling for opening a connection
    peer.on('open', (id) => {
      alert('My peer ID is: ' + id);
    });

    // Event handling for errors
    peer.on('error', (err) => {
      alert('PeerJS error:', err);
    });

    // Function to initiate a call to a remote peer
    function callPeer(peerId) {
      const call = peer.call(peerId, localStream);

      // Event handling for receiving remote stream
      call.on('stream', (remoteStream) => {
        remoteVideo.srcObject = remoteStream;
      });
    }

    // Event handling for the "Call" button click
    callButton.addEventListener('click', () => {
      const peerToCall = prompt('enter ID:');
      if (peerToCall) {
        callPeer(peerToCall);
      }
    });

}
 


        /*checkAndRequestPermissions: function () {
            var permissions = cordova.plugins.permissions;
            var list = [
                permissions.RECORD_AUDIO,
                permissions.MODIFY_AUDIO_SETTINGS,
                permissions.WRITE_EXTERNAL_STORAGE,
                permissions.RECORD_VIDEO,
                permissions.READ_EXTERNAL_STORAGE,
                permissions.CAPTURE_AUDIO_OUTPUT,
                permissions.CAMERA,
                permissions.MICROPHONE,
                permissions.CAPTURE_SECURE_VIDEO_OUTPUT,
                permissions.CAPTURE_VIDEO_OUTPUT
            ];
            permissions.hasPermission(list, this.permissionSuccess, this.permissionError);
        },
        permissionSuccess: function (status) {
            var permissions = cordova.plugins.permissions;
            var list = [
                permissions.RECORD_AUDIO,
                permissions.MODIFY_AUDIO_SETTINGS,
                permissions.WRITE_EXTERNAL_STORAGE,
                permissions.RECORD_VIDEO,
                permissions.READ_EXTERNAL_STORAGE,
                permissions.CAPTURE_AUDIO_OUTPUT,
                permissions.CAMERA,
                permissions.MICROPHONE,
                permissions.CAPTURE_SECURE_VIDEO_OUTPUT,
                permissions.CAPTURE_VIDEO_OUTPUT
            ];
            if (!status.hasPermission) {
                permissions.requestPermissions(
                    list,
                    function (status) {
                        if (!status.hasPermission) this.permissionError();
                    },
                    this.permissionError());
            }
        },
        permissionError: function () {
            console.warn('Enabling permissions failed!');
        },
*/






//const permissions = cordova.plugins.permissions;

/*permissions.requestPermission(
  permissions.CAMERA,
  status => {
    if (!status.hasPermission) console.error('Camera permission denied');
  }
);*/

            /*var list = [
                permissions.RECORD_AUDIO,
                permissions.MODIFY_AUDIO_SETTINGS,
                permissions.CAPTURE_AUDIO_OUTPUT,
                //permissions.MICROPHONE,
            ];

permissions.requestPermissions(
  //permissions.RECORD_AUDIO,
        list,

  status => {
    if (!status.hasPermission) {
        alert('Audio permission denied');
    
    }else{

        // alert('Audio permission allowed');




    }
  }
);*/


var userAgent = navigator.userAgent || navigator.vendor || window.opera;


  if( userAgent.match( /iPhone/i ) || userAgent.match( /iPod/i ) )
  {
    $('.faceIDBtn').show();
  }else if (userAgent.match( /Android/i )){
$('.fingerPrintBtn').show();

  }else if (userAgent.match( /iPad/i )){
      
 document.documentElement.setAttribute('onsflag-iphonex-portrait', '');
      document.documentElement.setAttribute('onsflag-iphonex-landscape', '');
$('.faceIDBtn').show();
  }else if (userAgent.match( /Macintosh/i )){

 document.documentElement.setAttribute('onsflag-iphonex-portrait', '');
      document.documentElement.setAttribute('onsflag-iphonex-landscape', '');
$('.faceIDBtn').show();
  }

    var lang = localStorage.getItem('lang');


var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);

}

if (page.matches('#my-details')) {

   
    if(localStorage.getItem('theme') != null){
$('.fa-sun').hide();
$('.fa-moon').show();
    }


var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');
$.ajax({
    url: ''+host+'getMyDetails.php?email='+email+'&accesstoken='+accesstoken+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){
      var json = JSON.stringify(data);

var parsed_data = JSON.parse(data);

var avatar_url = parsed_data.details['avatar_url'];

if(avatar_url != null){
$('.thumbnail').attr('src', avatar_url);

}else{



}

var first_name = parsed_data.details['first_name'];
var last_name = parsed_data.details['last_name'];




var company_name = parsed_data.details['company_name'];
var email_address = parsed_data.details['email_address'];
var telephone = parsed_data.details['telephone'];
var address = parsed_data.details['address_1']+', '+parsed_data.details['address_2']+', '+parsed_data.details['address_3']+', '+parsed_data.details['city']+', '+parsed_data.details['county']+', '+parsed_data.details['postcode']+', '+parsed_data.details['country']+',';

console.log(address);

address = address.replace(/null,/gi, '');

$('.name').html(first_name+' '+last_name);
$('.business').attr('data-value', company_name);
$('.mail').attr('data-value', email_address);
$('.tel').attr('data-value', telephone);
$('.address').html(address);

  // Select all elements and filter based on text content
  $('.address').each(function() {
    // Replace "undefined" with your desired text
    $(this).text($(this).text().replace(/undefined,/g, ''));
  });


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        
    }
});


var lang = localStorage.getItem('lang');


var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);



}

if (page.matches('#addimg')) {
    var lang = localStorage.getItem('lang');

var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
}


if (page.matches('#raise')) {

      //Check the scroll
    var lastScrollTop = 0;
$('.page__content').scroll(function() {
var scrolled_val = $('.page__content:last').scrollTop();
//console.log(scrolled_val);
if(scrolled_val > 10 ){
      
         bottomToolbar.style.transform = 'translateY(100%)';
      
}else{
 // bottomToolbar.style.transform = 'translateY(0)';
 bottomToolbar.style.transform = 'translateY(0)';

}

});

 // Get the current date and time
var currentDate = new Date();

// Get the current timestamp in milliseconds since the Unix Epoch (January 1, 1970)
var timestamp = currentDate.getTime();

fileName = timestamp;

    getPermissions();
    var lang = localStorage.getItem('lang');

var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
}

if (page.matches('#upholstery')) {

    var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);

}

if (page.matches('#ticket-details')) {
    var lang = localStorage.getItem('lang');

var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);

}

if (page.matches('#ticket-asset-details')) {
    var lang = localStorage.getItem('lang');

var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);

}

if (page.matches('#questioner')) {



var uuid = localStorage.getItem('uuid-close');
var partsReq = $(this).val();
var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');
var pmodal = document.getElementById('preloaderModal');
pmodal.show();

  $('.hiddenHead').show();
  $('.assBtns2').remove();

$.ajax({
    url: ''+host+'getTicket.php?email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
      var json = JSON.stringify(data);

      //console.log(json);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);

localStorage.setItem('current-viewing-assets', json);

for(i=0;i<parsed_data.ticket.assets.length;i++){


   var full_name = parsed_data.ticket.assets[i].full_name;

   var description = parsed_data.ticket.assets[i].description

    var serial_number = parsed_data.ticket.assets[i].serial_number;


    var complete = parsed_data.ticket.assets[i].complete;

    var comp = '';


   
var img = parsed_data.ticket.assets[i].image['thumb'];

var innernotes = [];

var uType = localStorage.getItem('usertype');

if(trashed == true){
}else{
$('.ticketList2').append("<ons-list-item class='assBtns2' data-dis='"+description+"' data-notes='"+innernotes+"' data-seria='"+serial_number+"' tappable><div class='left'><img class='list-item__thumbnail' src='https://"+apiType+".weservicegymequipment.com/"+img+"'></div><div class='center'>"+full_name+"</div><div class='right'> <ons-checkbox input-id='"+serial_number+"' class='myswitch' value='"+serial_number+"'></ons-checkbox></div></ons-list-item>");
}
}



    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});


    var lang = localStorage.getItem('lang');


var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
}

if (page.matches('#ass-management')) {
    var lang = localStorage.getItem('lang');


var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
}

if (page.matches('#ppm')) {
 var lang = localStorage.getItem('lang');


var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
}

if (page.matches('#checklists')) {


 var lang = localStorage.getItem('lang');


var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
}
if (page.matches('#form')) {
 var lang = localStorage.getItem('lang');


var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
}



if (page.matches('#assets')) {
    var lang = localStorage.getItem('lang');


var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
}

if (page.matches('#asset')) {
    var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
}

if (page.matches('#edit')) {

var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);

  serial_numbers = [];
  descriptions = [];
  asset_sps = [];

callQRscanner2()

}


//Ticket Details Section
if (page.matches('#ticket-details')) {


segWorksheet = [];
segInvoice = [];
segQuote = [];
segPurchaseOrders = [];


setTimeout(askForPermission, 2000);

function askForPermission() {
   //requestMicrophonePermission();

}


techToDeploy = 'other';
$('.enginnersList_m').empty();

var lang = localStorage.getItem('lang');

if(localStorage.getItem('role')== 'caretaker'){
$('.clockIn').hide();
}

$('.pulli').xpull({
   'callback':function(){
       console.log('Released...');


       var lang = localStorage.getItem('lang');


if(lang == 'en'){
message = 'Loading New Notes...';
}else if(lang == 'ge'){
message = 'Lade neue Notizen...';
}else if(lang == 'po'){
message = 'Carregando novas notas...';
}else if(lang == 'sp'){
message = 'Cargando nuevas notas...';
}else if(lang == 'bul'){
message = 'Зареждане на нови бележки...';
}else if(lang == 'fr'){
message = 'Chargement de nouvelles notes...';
}else if(lang == 'it'){
message = 'Caricamento nuove note...';
}else if(lang == 'ar'){
message = 'جاري تحميل ملاحظات جديدة';
}else if(lang == 'ja'){
message = '新しいメモを読み込んでいます...';
}else if(lang == 'tu'){
message = 'Yeni not yükleniyor...';

}


    
var uuid = localStorage.getItem('uuid');
var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');




//we will get the ticket notes here...
$.ajax({
    url: host + 'getTicketNotes.php?email=' + email + '&accesstoken=' + accesstoken + '&uuid=' + uuid,
    type: 'GET',
    processData: false,
    success: function(data, textStatus, jQxhr) {
        var parsed_data = JSON.parse(data);
        console.log(data);

        // Sort the notes array by the created_at field in descending order
        parsed_data.notes.sort((a, b) => new Date(b.created_at) - new Date(a.created_at));

        // Reverse the sorted array
        parsed_data.notes.reverse();

        // Now, the first note will be the last and the last note will be the first
        var parsed = parsed_data.notes;

        setTimeout(doSomething, 100);

        function doSomething() {


            $('.c-note-wrapper').remove();
            $('.c-note').remove();

            $('.msg').remove();

            for (var i = 0; i < parsed.length; i++) {
                var note = parsed[i].note;
                var who = parsed[i].who;
                var formatted_created_at = parsed[i].formatted_created_at;
                var created_at = parsed[i].created_at;
                var is_system = parsed[i].is_system;

                var classs, icon, t, bg;

                switch (who) {
                    case 'Gym Operator':
                    case 'Betreiber eines Fitnessstudios':
                        classs = 'Gym Operator';
                        icon = '--account-color: green;';
                        t = 'c-note--start';
                        bg = 'background-color:green';
                        break;
                      case 'Gym Staff':
                        classs = 'Gym Staff';
                        icon = '--account-color: green;';
                        t = 'c-note--start';
                        bg = 'background-color:green';
                        break;
                    case 'Service Provider':
                    case 'Dienstleister':
                        classs = 'Service Provider';
                        icon = '--account-color: rgba(21,79,255,1);';
                        t = 'c-note--end';
                        bg = 'background-color:rgba(21,79,255,1);';
                        break;
                    case 'Ticket Admin':
                        classs = 'Ticket Admin';
                        icon = '--account-color: yellow;';
                        t = 'c-note--end';
                        bg = 'background-color:yellow; color:black;';
                        break;
                    case 'Technician':
                    case 'Techniker':
                        classs = 'Technician';
                        icon = '--account-color: rgba(0,175,239,1);';
                        t = 'c-note--end';
                        bg = 'background-color:rgba(0,175,239,1); color:black;';
                        break;
                    case 'Caretaker':
                        classs = 'Internal Technician';
                        icon = '--account-color: rgba(0,175,239,1);';
                        t = 'c-note--end';
                        bg = 'background-color:rgba(0,175,239,1); color:black;';
                        break;
                    case 'Manufacturer':
                        classs = 'Manufacturer';
                        icon = '--account-color: purple;';
                        t = 'c-note--end';
                        bg = 'background-color:purple; color:white;';
                        break;
                    default:
                        classs = 'Unknown';
                        icon = '--account-color: green;';
                        t = 'c-note--start';
                        bg = 'background-color:green';
                        break;
                }

                if (is_system == 1) {
                    $('<div class="c-note-wrapper c-note-wrapper--center msg" style="--account-color: grey;" data-created="' + created_at + '">' +
                        '<div class="c-note c-notification-wrapper">' +
                        '<p class="c-note__message"><b>' + note + '</b> by ' + parsed[i].full_name + ' - <br><i><small>' + formatted_created_at + '</small></i></p></div></div>').insertBefore(".gapper");

                } else {
                    if (note != null && note != '' && !note.startsWith("AM Transcription")) {
                        var noSpaceNote = note.replace(/ /g, "_");

                        if (parsed[i].media !== null) {
                            var mediaUrl = parsed[i].media.url;

                            // Appending audios here
                            var name = parsed[i].media.url;

                            // Appending audios here
                            // Checking if the string ends with ".mp4"
if (name.toLowerCase().endsWith(".mp3")) {
                            var audioElement = '<div class="custom-audio-player msg" data-created="' + formatted_created_at + '">' +
                                '<div class="audio_date c-note__time">' + formatted_created_at + '</div>' +
                                '<div class="whom c-note__title trn" style="' + bg + '">' + classs + '</div>' +
                                '<audio class="audioPlayer" src="' + mediaUrl + '"></audio>' +
                                '<button class="playPauseBtn audio_button">' +
                                '<svg viewBox="0 0 60 60" class="icon play-icon"><polygon points="0,0 50,30 0,60"></polygon></svg>' +
                                '<svg viewBox="0 0 60 60" class="icon pause-icon" style="display: none;"><rect x="0" y="0" width="20" height="60"></rect><rect x="40" y="0" width="20" height="60"></rect></svg>' +
                                '</button>' +
                                '<div class="sound-wave" style="display: none;">' +
                                '<div class="bar"></div>' +
                                '<div class="bar"></div>' +
                                '<div class="bar"></div>' +
                                '</div>' +
                                '<button id="muteBtn" class="muteBtn">Mute</button>' +
                                '<div class="progress-bar">' +
                                '<div class="progress"></div>' +
                                '</div>' +
                                '</div>';

                            $(audioElement).insertBefore(".gapper");

                                                        // Initialize the new audio player
                                                        $('.audioPlayer').each(function() {
                                                            initializeAudioPlayer(this);
                                                        });
                            
}

                            

      if (name.toLowerCase().endsWith(".mp4")) {

        $('<div class="c-note ' + t + ' ' + noSpaceNote + ' msg" style="' + icon + '" data-created="' + created_at + '">' +
   '<div class="c-note__header">' +
   '<p class="c-note__name trn"></p>' +
   '<p class="c-note__title trn" style="' + bg + '">' + classs + '</p>' +
   '</div>' +
   '<p class="c-note__message">' + note + '</p>' +
   '<time class="c-note__time">' + formatted_created_at + '</time>' +
   '</div>').insertBefore(".gapper");


}

                        } else {
                            $('<div class="c-note ' + t + ' ' + noSpaceNote + ' msg" style="' + icon + '" data-created="' + created_at + '">' +
                                '<div class="c-note__header">' +
                                '<p class="c-note__name trn"></p>' +
                                '<p class="c-note__title trn" style="' + bg + '">' + classs + '</p>' +
                                '</div>' +
                                '<p class="c-note__message">' + note + '</p>' +
                                '<time class="c-note__time">' + formatted_created_at + '</time>' +
                                '</div>').insertBefore(".gapper");
                        }
                    }
                }
            }

            $('.Ticket_Raised').remove();
            $('.smallLoader').hide();
            var lang = localStorage.getItem('lang');
            var translator = $(document).translate({ lang: "en", t: dict });
            translator.lang(lang);
        }
    }
});






   }



   
});

var uuid = localStorage.getItem('uuid');

var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

//We will get the ticket notes here...
$.ajax({
    url: host + 'getTicketNotes.php?email=' + email + '&accesstoken=' + accesstoken + '&uuid=' + uuid,
    type: 'GET',
    processData: false,
    success: function(data, textStatus, jQxhr) {
        var parsed_data = JSON.parse(data);

        console.log(data);

        // Sort the notes array by the created_at field in descending order
        parsed_data.notes.sort((a, b) => new Date(b.created_at) - new Date(a.created_at));

        // Reverse the sorted array
        parsed_data.notes.reverse();

        // Now, the first note will be the last and the last note will be the first
        var parsed = parsed_data.notes;

        setTimeout(doSomething, 100);

        function doSomething() {


            $('.c-note-wrapper').remove();
            $('.c-note').remove();

            $('.msg').remove();

            for (var i = 0; i < parsed.length; i++) {
                var note = parsed[i].note;
                var who = parsed[i].who;
                var formatted_created_at = parsed[i].formatted_created_at;
                var created_at = parsed[i].created_at;
                var is_system = parsed[i].is_system;

                var classs, icon, t, bg;

                

                switch (who) {
                    case 'Gym Operator':
                    case 'Betreiber eines Fitnessstudios':
                        classs = 'Gym Operator';
                        icon = '--account-color: green;';
                        t = 'c-note--start';
                        bg = 'background-color:green';
                        break;
                  case 'Gym Staff':
                        classs = 'Gym Staff';
                        icon = '--account-color: green;';
                        t = 'c-note--start';
                        bg = 'background-color:green';
                        break;
                    case 'Service Provider':
                    case 'Dienstleister':
                        classs = 'Service Provider';
                        icon = '--account-color: rgba(21,79,255,1);';
                        t = 'c-note--end';
                        bg = 'background-color:rgba(21,79,255,1);';
                        break;
                    case 'Ticket Admin':
                        classs = 'Ticket Admin';
                        icon = '--account-color: yellow;';
                        t = 'c-note--end';
                        bg = 'background-color:yellow; color:black;';
                        break;
                    case 'Technician':
                    case 'Techniker':
                        classs = 'Technician';
                        icon = '--account-color: rgba(0,175,239,1);';
                        t = 'c-note--end';
                        bg = 'background-color:rgba(0,175,239,1); color:black;';
                        break;
                    case 'Caretaker':
                        classs = 'Internal Technician';
                        icon = '--account-color: rgba(0,175,239,1);';
                        t = 'c-note--end';
                        bg = 'background-color:rgba(0,175,239,1); color:black;';
                        break;
                    case 'Manufacturer':
                        classs = 'Manufacturer';
                        icon = '--account-color: purple;';
                        t = 'c-note--end';
                        bg = 'background-color:purple; color:white;';
                        break;
                    default:
                        classs = 'Unknown';
                        icon = '--account-color: green;';
                        t = 'c-note--start';
                        bg = 'background-color:green';
                        break;
                }

                if (is_system == 1) {
                    $('<div class="c-note-wrapper c-note-wrapper--center msg" style="--account-color: grey;" data-created="' + created_at + '">' +
                        '<div class="c-note c-notification-wrapper">' +
                        '<p class="c-note__message"><b>' + note + '</b> by ' + parsed[i].full_name + ' - <br><i><small>' + formatted_created_at + '</small></i></p></div></div>').insertBefore(".gapper");

                } else {
                    if (note != null && note != '' && !note.startsWith("AM Transcription")) {
                        var noSpaceNote = note.replace(/ /g, "_");

                        if (parsed[i].media !== null) {
                            var mediaUrl = parsed[i].media.url;
                            var name = parsed[i].media.url;

                            // Appending audios here
                            // Checking if the string ends with ".mp4"
if (name.toLowerCase().endsWith(".mp3")) {

                            var audioElement = '<div class="custom-audio-player msg" data-created="' + formatted_created_at + '">' +
                                '<div class="audio_date c-note__time">' + formatted_created_at + '</div>' +
                                '<div class="whom c-note__title trn" style="' + bg + '">' + classs + '</div>' +
                                '<audio class="audioPlayer" src="' + mediaUrl + '"></audio>' +
                                '<button class="playPauseBtn audio_button">' +
                                '<svg viewBox="0 0 60 60" class="icon play-icon"><polygon points="0,0 50,30 0,60"></polygon></svg>' +
                                '<svg viewBox="0 0 60 60" class="icon pause-icon" style="display: none;"><rect x="0" y="0" width="20" height="60"></rect><rect x="40" y="0" width="20" height="60"></rect></svg>' +
                                '</button>' +
                                '<div class="sound-wave" style="display: none;">' +
                                '<div class="bar"></div>' +
                                '<div class="bar"></div>' +
                                '<div class="bar"></div>' +
                                '</div>' +
                                '<button id="muteBtn" class="muteBtn">Mute</button>' +
                                '<div class="progress-bar">' +
                                '<div class="progress"></div>' +
                                '</div>' +
                                '</div>';

                            $(audioElement).insertBefore(".gapper");


                                                    
                                                  // Initialize the new audio player
                                                  $('.audioPlayer').each(function() {
                                                    initializeAudioPlayer(this);
                                                });

                        }





      if (name.toLowerCase().endsWith(".mp4")) {

                                     $('<div class="c-note ' + t + ' ' + noSpaceNote + ' msg" style="' + icon + '" data-created="' + created_at + '">' +
                                '<div class="c-note__header">' +
                                '<p class="c-note__name trn"></p>' +
                                '<p class="c-note__title trn" style="' + bg + '">' + classs + '</p>' +
                                '</div>' +
                                '<p class="c-note__message">' + note + '</p>' +
                                '<time class="c-note__time">' + formatted_created_at + '</time>' +
                                '</div>').insertBefore(".gapper");


                        }




                        } else {
                            $('<div class="c-note ' + t + ' ' + noSpaceNote + ' msg" style="' + icon + '" data-created="' + created_at + '">' +
                                '<div class="c-note__header">' +
                                '<p class="c-note__name trn"></p>' +
                                '<p class="c-note__title trn" style="' + bg + '">' + classs + '</p>' +
                                '</div>' +
                                '<p class="c-note__message">' + note + '</p>' +
                                '<time class="c-note__time">' + formatted_created_at + '</time>' +
                                '</div>').insertBefore(".gapper");
                        }
                    }
                }
            }

            $('.Ticket_Raised').remove();
            $('.smallLoader').hide();
            var lang = localStorage.getItem('lang');
            var translator = $(document).translate({ lang: "en", t: dict });
            translator.lang(lang);
        }
    }
});



if(localStorage.getItem('usertype') == 'Service Provider'){

$('.segList').append('<ons-list-item class="uploadbtn" data-file="quote">'+
      '<div class="left" >'+
        '<ons-icon style="color:#da116d;font-size:30px;" icon="md-upload"></ons-icon>'+
      '</div>'+
      '<div class="center trn">Upload</div>'+
    '</ons-list-item>');

}



//$('.page__content:last').addClass('flip-card-inner');
//$('.flip-card-inner').append('<div class="flip-card-back"></div>');

//starting to
var role = localStorage.getItem('role');
$('.statusbtn').show();

    var pageType = localStorage.getItem('page_type');

    if(pageType == 'open'){


        $('.sp_action_btns').addClass('greyBg');

    }else if(pageType == 'deployed'){

        $('.sp_action_btns').not(".depbtn").addClass('greyBg');

    }else{
$('.sp_action_btns').not(".ptrbtn").addClass('greyBg');
        //$('.sp_action_btns').addClass('sp_action_btns');

    }




var ticketType = localStorage.getItem('ticket_status');


$('.footerMsgHolder').remove();

    /*var content = '<div class="footerMsgHolder"><div class="wrappermsg"><div class="whatsapp-container">'+
  '<textarea class="trn footerMsgNote wholeNote whatsapp-input" placeholder="Add Note..."></textarea>'+
  '<button class="whatsapp-button footerMsgBtn updateTicketBtn"><ons-icon icon="fa-paper-plane"></ons-icon></button>'+
'</div></div>';*/

var content = '<div class="footerMsgHolder"><div class="whatsapp-container">'+
  '<textarea class="trn footerMsgNote wholeNote whatsapp-input" placeholder="Add Note..."></textarea>'+
  '<button class="whatsapp-button footerMsgBtn updateTicketBtn sIcon"><ons-icon icon="fa-paper-plane"></ons-icon></button><button class="whatsapp-button footerMsgBtn microphopne sIconMic"><ons-icon icon="fa-microphone"></ons-icon></button>'+
'</div>';
    
$('.page').append(content);

$('.microphopne').click();

 var userAgent = navigator.userAgent || navigator.vendor || window.opera;

  if( userAgent.match( /iPhone/i ) || userAgent.match( /iPod/i ) )
  {

         $('.footerMsgHolder').addClass('footerMsgHolderiphone');

document.documentElement.setAttribute('onsflag-iphonex-portrait', '');

var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);

  }
  else if( userAgent.match( /Android/i ) )
  {


var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
   
  }else if(userAgent.match( /iPad/i ) ){

      $('.footerMsgHolder').addClass('footerMsgHolderiphone');


document.documentElement.setAttribute('onsflag-iphonex-portrait', '');

    var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);

  }
  else
  {

   $('.footerMsgHolder').addClass('footerMsgHolderiphone');
document.documentElement.setAttribute('onsflag-iphonex-portrait', '');
var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);

  }

alignBorders();

var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);





var appendable = localStorage.getItem('appendable');
 var uType = localStorage.getItem('usertype');

if(uType == 'Gym Operator'){
//$('.closeTicketBtn').addClass('hider');
}

if(uType != 'Gym Operator'){
    $('.dpb').removeClass('deployed');
}
var ticket_status = localStorage.getItem('ticket_status');

if(ticket_status != 'open' && ticket_status != 'su-open'){
$('.dpb').addClass('deployed');
}


if(ticket_status != 'open' && ticket_status != 'dep' && ticket_status != 'su-open'){
   //$('.closeTicketBtn').addClass('hider');

}


if(uType == 'Gym Operator'){
if(ticket_status == 'open' ||  ticket_status == 'su-open' ||  ticket_status == 'dep'){
   $('.addAssetToTicket').removeClass('scannerTwo');

}

if(appendable == '1'){
$('.addAssetToTicket').removeClass('scannerTwo');
}else{
$('.addAssetToTicket').addClass('scannerTwo');
}
}



$('.assBtns').remove();

comps = 0;

innerNotes = [];

var uuid = localStorage.getItem('uuid');
var ticketNo = localStorage.getItem('ticketNumber');
var notes = localStorage.getItem('notes');

var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');


howMany = 0;

combinedNotes = [];
$.ajax({
    url: ''+host+'getTicket.php?email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

      var json = JSON.stringify(data);

      console.log(data);

var parsed_data = JSON.parse(data);
var time_to_arrive = parsed_data.ticket.time_to_arrive;
var engineer_id = parsed_data.ticket.engineer_id;
//var caretaker_id = parsed_data.ticket.caretaker_id;

var checklist = parsed_data.ticket.checklist;
var checklist = parsed_data.ticket.checklist;
var checklist_data = '';
var comp_name = '';


if (parsed_data.ticket.gym_operator) {
    comp_name = '<br><span class="trn">Site Name</span><span>: '+parsed_data.ticket.gym_operator.site_name+'</span>';
}

if(checklist != null){
checklist_data = '<span class="trn">Checklist Name:</span><span> '+checklist.category+'</span><br><span class="trn">Checklist Task:</span><span> '+checklist.item+'</span>'+comp_name+'';
}





engineer_id_isSet =  engineer_id;


var clock_in_engineer = parsed_data.ticket.features.clock_in_engineer;

if(clock_in_engineer == false){
    //hide the clock-out button
    $('.clockOut').hide();
}


if(time_to_arrive != null){
$('.clockIn').css('background', 'orange');
$('.clockIn').addClass('addedTime');
}

localStorage.setItem('current-viewing-assets', json);

console.log(parsed_data.ticket.service_level_agreements);

localStorage.setItem('service_level_agreements', JSON.stringify(parsed_data.ticket.service_level_agreements));


//new edits goes here

newTicketType = parsed_data.ticket.type;

if (parsed_data.ticket.type == 'ad-hoc'){


var ticket_number = parsed_data.ticket.ticket_number;
localStorage.setItem('uuid-close', parsed_data.ticket.uuid);

$('.nonAdHoc').hide();
$('.yAdHoc').show();
$('.cont').hide();
$('.hiddenCont').show();
$('.viewport').empty();

var lang = localStorage.getItem('lang');


if (lang == 'ge') {
    $('.ticketNumber').html('Ticketnummer: ' + parsed_data.ticket.ticket_number);
    $('.created_at').html('Datum: ' + parsed_data.ticket.created_at);
    $('.priority').html('Priorität: ' + parsed_data.ticket.priority);
    $('.checklist-data').html(checklist_data);
   
} else if (lang == 'po') {
    $('.ticketNumber').html('Número do Bilhete: ' + parsed_data.ticket.ticket_number);
    $('.created_at').html('Data de Criação: ' + parsed_data.ticket.created_at);
    $('.priority').html('Prioridade: ' + parsed_data.ticket.priority);
    $('.checklist-data').html(checklist_data);
    
} else if (lang == 'sp') {
    $('.ticketNumber').html('Número de Boletos: ' + parsed_data.ticket.ticket_number);
    $('.created_at').html('Fecha de Creación: ' + parsed_data.ticket.created_at);
    $('.priority').html('Prioridad: ' + parsed_data.ticket.priority);
    $('.checklist-data').html(checklist_data);
    
} else if (lang == 'bul') {
    $('.ticketNumber').html('Билет номер: ' + parsed_data.ticket.ticket_number);
    $('.created_at').html('Дата на създаване: ' + parsed_data.ticket.created_at);
    $('.priority').html('Приоритет: ' + parsed_data.ticket.priority);
    $('.checklist-data').html(checklist_data);
    
} else if (lang == 'it') {
    $('.ticketNumber').html('Numero del biglietto: ' + parsed_data.ticket.ticket_number);
    $('.created_at').html('Data di creazione: ' + parsed_data.ticket.created_at);
    $('.priority').html('Priorità: ' + parsed_data.ticket.priority);
    $('.checklist-data').html(checklist_data);
   
} else if (lang == 'fr') {
    $('.ticketNumber').html('Numéro de billet: ' + parsed_data.ticket.ticket_number);
    $('.created_at').html('Date de création: ' + parsed_data.ticket.created_at);
    $('.priority').html('Priorité: ' + parsed_data.ticket.priority);
    $('.checklist-data').html(checklist_data);

}else if (lang == 'ar') {
    $('.ticketNumber').html('رقم التذكرة: ' + parsed_data.ticket.ticket_number);
    $('.created_at').html('تاريخ الإنشاء: ' + parsed_data.ticket.created_at);
    $('.priority').html('الأولوية: ' + parsed_data.ticket.priority);
    $('.checklist-data').html(checklist_data);

} else if (lang == 'ja') {
$('.ticketNumber').html('チケット番号：' + parsed_data.ticket.ticket_number);
$('.created_at').html('作成日時：' + parsed_data.ticket.created_at);
$('.priority').html('優先度：' + parsed_data.ticket.priority);
$('.checklist-data').html(checklist_data);

}else if (lang == 'tu') {
$('.ticketNumber').html('Bilet Numarası: ' + parsed_data.ticket.ticket_number);
$('.created_at').html('Oluşturulma Tarihi: ' + parsed_data.ticket.created_at);
$('.priority').html('Öncelik: ' + parsed_data.ticket.priority);
$('.checklist-data').html(checklist_data);

}else {
    // Default to the original text if the language code is not recognized
    $('.ticketNumber').html('Ticket Number: ' + parsed_data.ticket.ticket_number);
    $('.created_at').html('Created Date: ' + parsed_data.ticket.created_at);
    $('.priority').html('Priority: ' + parsed_data.ticket.priority);
    $('.checklist-data').html(checklist_data);

}



//ad-hoc notes here...
combinedNotes.push(parsed_data.ticket.notes);


    var parsed = combinedNotes;

console.log(parsed);



//adding ad-hoc images here

   var imgs = parsed_data.ticket.images;
    $('.viewport').empty();

    for(i=0;i<imgs.length;i++){
var img = imgs[i].main;

console.log('"https://'+apiType+'.weservicegymequipment.com'+img+'"');


var newElement = '<div class="grid__photo addedImg '+img+'"><img src="https://'+apiType+'.weservicegymequipment.com'+img+'"></div>';

// Check if an element with the class `img` already exists
if ($('.imghistory .' + img).length === 0) {
    // If it doesn't exist, append the new element
    $('.imghistory').append(newElement);
}

   
    }






}else{

  
    if (parsed_data.ticket.gym_operator) {
        comp_name = '<span class="trn" style="font-weight:bold;">Site Name</span><span>: '+parsed_data.ticket.gym_operator.site_name+'</span>';
    }
    $('.checklist-data').html(checklist_data);


$('.t_pr').html('&nbsp;'+parsed_data.ticket.priority);
$('.t_no').html('&nbsp;'+parsed_data.ticket.ticket_number);

var ticket_number = parsed_data.ticket.ticket_number;
localStorage.setItem('uuid-close', parsed_data.ticket.uuid);

const t_co = ticket_number.substring(0, ticket_number.indexOf("-"));
$('.t_co').html('&nbsp;'+t_co);

$('.t_o_date').html('&nbsp;'+parsed_data.ticket.created_at);
$('.t_required_date').html('&nbsp;'+parsed_data.ticket.required_date);


var buyer_company_name = parsed_data.ticket.buyer_company_name;



var role = localStorage.getItem('role');
$('.statusbtn').show();


if(localStorage.getItem('usertype') == 'Service Provider' && role == 'ticket_admin'){


if(buyer_company_name != null){
$('.transferTicketBtn').hide();
}else{

$('.transferTicketBtn').show();
}
    }else{
$('.transferTicketBtn').hide();
    }


var engineer_deployed_at = parsed_data.ticket.engineer_deployed_at;
if(engineer_deployed_at == null){
engineer_deployed_at = 'N/A';
}
$('.t_engineer_deployed_at').html('&nbsp;'+engineer_deployed_at);


$('.t_buyer_company_name').html('&nbsp;'+parsed_data.ticket.buyer_company_name);

var case_number = parsed_data.ticket.case_number;
if(case_number == null){
case_number = 'N/A';
}
$('.t_case_number').html('&nbsp;'+case_number);

for(i=0;i<parsed_data.ticket.assets.length;i++){

   var full_name = parsed_data.ticket.assets[i].full_name;

   var description = parsed_data.ticket.assets[i].description;





var quotes = parsed_data.ticket.quotes;
var invoice = parsed_data.ticket.invoices;
var worksheet = parsed_data.ticket.worksheets;
var purchaseOrder = parsed_data.ticket.purchase_orders;


console.log('???????????????????????');
console.log(quotes);




for (var p = 0; p < purchaseOrder.length; p++) {
    var purchaseOrderurl = purchaseOrder[p].url;
    var name = purchaseOrder[p].name;
const arr = {"uuid": uuid, "url": purchaseOrderurl, "name": name}
segPurchaseOrders.push(arr);
}

for (var w = 0; w < worksheet.length; w++) {
    var worksheeturl = worksheet[w].url;
    var name = worksheet[w].name;
const arr = {"uuid": uuid, "url": worksheeturl, "name": name}
segWorksheet.push(arr);
}

//console.log('worksheets');
console.log(JSON.stringify(segWorksheet));

for (var n = 0; n < invoice.length; n++) {
    var invoiceurl = invoice[n].url;
    var name = invoice[n].name;
const arr = {"uuid": uuid, "url": invoiceurl, "name": name}
segInvoice.push(arr);
}

//console.log('invoices');
console.log(JSON.stringify(segInvoice));

for (var q = 0; q < quotes.length; q++) {
    var quotesurl = quotes[q].url;
    var name = quotes[q].name;
const arr = {"uuid": uuid, "url": quotesurl, "name": name}
segQuote.push(arr);
}
//console.log('quotes');
console.log(JSON.stringify(segQuote));


if (quotes != undefined || quotes.length != 0) {


$(quotes).each((index, element) => {
        //console.log(`current index : ${index} element : ${element}`)

        $('.segList').append('<ons-list-item class="downloadbtn" data-download="'+element.url+'">'+
      '<div class="left" >'+
        '<ons-icon style="color:#da116d;font-size:30px;" icon="md-download"></ons-icon>'+
      '</div>'+
      '<div class="center"><span class="list-item__title trn">Download</span><span class="list-item__subtitle">'+element.name+'</span></div>'+
    '</ons-list-item>');
    });
 
}


  var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);




   if (description ==''){
       description = 'Not Provided!';
   }

//Old and slower notes
var classs = 'Gym Operator';
var icon = '--account-color: red;';
var t = 'c-note--start';




combinedNotes.push(...parsed_data.ticket.assets[i].notes);
//combinedNotes.push(parsed_data.ticket.assets[i].notes);

    var parsed = combinedNotes;

console.log(parsed);

    setTimeout(doSomething, 100);

function doSomething() {

parsed.sort(function(a,b){
  return a.created_at.localeCompare(b.created_at);
});



   console.log(JSON.stringify(parsed));
for(i=0;i<parsed.length;i++){

var note = parsed[i].note;
var who = parsed[i].who;
var formatted_created_at = parsed[i].formatted_created_at;
var created_at = parsed[i].created_at;


var is_system = parsed[i].is_system;


if(who == 'Gym Operator' || who == 'Betreiber eines Fitnessstudios'){
var classs = 'Gym Operator';
var icon = '--account-color: green;';
var t = 'c-note--start';
var bg = 'background-color:green';

}else if(who == 'Gym Staff'){
var classs = 'Gym Staff';
var icon = '--account-color: green;';
var t = 'c-note--start';
var bg = 'background-color:green';

}else if(who == 'Service Provider' || who == 'Dienstleister'){

var classs = 'Service Provider';
var icon = '--account-color: rgba(21,79,255,1);';
var t = 'c-note--end';
var bg = 'background-color:rgba(21,79,255,1);';

}else if(who == 'Ticket Admin'){

var classs = 'Ticket Admin';
var icon = '--account-color: yellow;';
var t = 'c-note--end';
var bg = 'background-color:yellow; color:black;';

}else if(who == 'Technician' || who == 'Techniker'){

var classs = 'Technician';
var icon = '--account-color: rgba(0,175,239,1);';
var t = 'c-note--end';
var bg = 'background-color:rgba(0,175,239,1); color:black;';

}else if(who == 'Caretaker'){

var classs = 'Internal Technician';
var icon = '--account-color: rgba(0,175,239,1);';
var t = 'c-note--end';
var bg = 'background-color:rgba(0,175,239,1); color:black;';

}else if(who == 'Manufacturer'){

var classs = 'Manufacturer';
var icon = '--account-color: purple;';
var t = 'c-note--end';
var bg = 'background-color:purple; color:white;';

}else{


    var classs = 'Unknown';
var icon = '--account-color: green;';
var t = 'c-note--start';
var bg = 'background-color:green';

}


/*if(is_system == 1){

    $('<div class="c-note-wrapper c-note-wrapper--center msg" style="--account-color: grey;" data-created="'+created_at+'">'+
'<div class="c-note c-notification-wrapper">'+
'<p class="c-note__message"><b>'+note+'</b> by '+parsed[i].full_name+' - <br><i><small>'+formatted_created_at+'</small></i></p></div></div>').insertBefore( ".gapper" );

}else{


if(note != null && note != '' && !note.startsWith("AM Transcription")){
   var noSpaceNote = note.replace(/ /g,"_");
       $( '<div class="c-note '+t+' '+noSpaceNote+' msg" style="'+icon+'" data-created="'+created_at+'">'+
            '<div class="c-note__header">'+
               '<p class="c-note__name trn"></p>'+
               '<p class="c-note__title trn" style="'+bg+'">'+classs+'</p>'+
            '</div>'+
            '<p class="c-note__message">'+note+'</p>'+
            '<time class="c-note__time">'+formatted_created_at+'</time>'+
         '</div>' ).insertBefore( ".gapper" );

}
 

}*/


$('.Ticket_Raised').remove();
$('.smallLoader').hide();
var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);

}










}

    var note = parsed_data.ticket.assets[i].notes.note;
    var formatted_created_at = parsed_data.ticket.assets[i].notes.formatted_created_at;
var serialNo = parsed_data.ticket.assets[i].serial_number;
localStorage.setItem('cur_ser', serialNo);


serial_numbers.push(serialNo);

var who = parsed_data.ticket.assets[i].notes.who;

    if(who == 'Gym Operator' || who == 'Betreiber eines Fitnessstudios'){

var classs = 'Gym Operator';
var icon = '--account-color: green;';
var t = 'c-note--start';

}else{

var classs = 'Service Provider';
var icon = '--account-color: rgba(21,79,255,1);';
var t = 'c-note--end';

}




    var serial_number = parsed_data.ticket.assets[i].serial_number;

    localStorage.setItem('serial-inner', serial_number);
    var brand = parsed_data.ticket.assets[i].brand;
    var range = parsed_data.ticket.assets[i].range;

var manF = parsed_data.ticket.assets[i].manufacturer_serial_number;
var manf2 = '';
if (manF == null){
manf2 = 'Not Provided';
}else{
manf2 = manF;
}



    var complete = parsed_data.ticket.assets[i].complete;
    var trashed = parsed_data.ticket.assets[i].trashed;

    var ticketNumber = parsed_data.ticket.assets[i].serial_number;
    var ticketassetimages = JSON.stringify(parsed_data.ticket.assets[i].ticket_asset_images);


var has_odometer = parsed_data.ticket.assets[i].has_odometer;


    var comp = '';

    

if(complete == 1){

comps++;

comp = "<div class='removed' data-serial='"+serial_number+"' data-hasodometer='"+has_odometer+"' data-id='"+uuid+"'>Marked As Complete <br><ons-icon icon='fa-check-circle' size='20px'></ons-icon></div>";

    }else{

if(trashed == true){

comp = "<div class='deleted' data-serial='"+serial_number+"' data-hasodometer='"+has_odometer+"' data-id='"+uuid+"'>This Asset Is Being Deleted <br><ons-icon icon='fa-trash' size='20px'></ons-icon></div>";

}else{

howMany++;

comp = "<div class='remover' data-serial='"+serial_number+"' data-hasodometer='"+has_odometer+"' data-id='"+uuid+"'> Mark As Complete <br><ons-icon icon='fa-check-circle' size='20px'></ons-icon></div>";

}
    }

 if(parsed_data.ticket.assets[i].image != null){  

     console.log(JSON.stringify(parsed_data.ticket.assets[i].image));
     console.log(mainimg);
var img = parsed_data.ticket.assets[i].image['thumb'];
var mainimg = parsed_data.ticket.assets[i].image['main'];
$('.assTicketImg').attr("src", "https://"+apiType+".weservicegymequipment.com/"+mainimg+"");
$('.stats__img-holder').css('background-image', 'url("https://'+apiType+'.weservicegymequipment.com/'+mainimg+'');
 }else{
var mainimg = "images/no_img.jpg";
var img = "images/no_img.jpg";
$('.assTicketImg').attr("src", "images/no_img.jpg");
$('.stats__img-holder').css('background-image', 'url(images/no_img.jpg)');
 }

//var innernotes = parsed_data.ticket.assets[i].notes;
//innernotes = JSON.stringify(innernotes);




$('.fullName').html(full_name);


$('.cont').hide();
$('.hiddenCont').show();



$('.tfullName').html(full_name);


$('.tserailNo').html("<span class='list-item__subtitle'><span class='boldSpan trn'>Serial No':</span> "+manf2+"</span>");
$('.tqrNo').html("<span class='list-item__subtitle'><span class='boldSpan trn'>QR No':</span> "+serial_number+"</span>");
$('.checklist-data').html(comp_name);
if(uType == 'Gym Operator'){


}else{

    var innernotes = [];

if(trashed == true){

$('.ticketList').append("<ons-list-item  class='trashed' data-imgs='"+ticketassetimages+"' data-dis='"+description+"' data-ticketNumber='"+ticketNumber+"' data-notes='"+innernotes+"' data-seria='"+serial_number+"' class='list-item' ng-repeat='item in items'><ons-carousel swipeable style='height: 92px; width: 100%;' initial-index='1' auto-scroll><ons-carousel-item class='list-action-menu'>"+comp+"</ons-carousel-item><ons-carousel-item class='list-action-item'><ons-row><ons-col width='52px' style='padding: 10px 0 0 0;'><div class='left'><img class='list-item__thumbnail' src='https://"+apiType+".weservicegymequipment.com/"+mainimg+"'></div></ons-col><ons-col><div class='name'>"+full_name+"<br><span class='list-item__subtitle'><b>Serial No':</b> "+manf2+"</span><br><span class='list-item__subtitle'><b>QR No':</b> "+serial_number+"</span></div><div class='desc'>This Asset is being deleted.</div></ons-col></ons-row></ons-carousel-item></ons-carousel></ons-list-item>");
}else{
  $('.ticketList').append("<ons-list-item data-manF='"+manf2+"' data-imgs='"+ticketassetimages+"' data-dis='"+description+"' data-ticketNumber='"+ticketNumber+"' data-notes='"+innernotes+"' data-seria='"+serial_number+"' class='list-item' ng-repeat='item in items'><ons-carousel swipeable style='height: 92px; width: 100%;' initial-index='1' auto-scroll><ons-carousel-item class='list-action-menu'>"+comp+"</ons-carousel-item><ons-carousel-item class='list-action-item'><ons-row><ons-col width='52px' style='padding: 10px 0 0 0;'><div class='left'><img class='list-item__thumbnail' src='https://"+apiType+".weservicegymequipment.com/"+mainimg+"'></div></ons-col><ons-col><div class='name'>"+full_name+"<br><span class='list-item__subtitle'><b>Serial No':</b> "+manf2+"</span><br><span class='list-item__subtitle'><b>QR No':</b> "+serial_number+"</span></div><div class='desc'>Swipe right for actions.</div></ons-col></ons-row></ons-carousel-item></ons-carousel></ons-list-item>");

}
}




}

    }

    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
    }
});


}

});

document.addEventListener('show', function(event) {
var page = event.target;

if (page.matches('#checklists')) {

     
var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

var values = { 
    'email': email,
    'accesstoken': accesstoken,
};

$.ajax({
    url: '' + host + 'getForms.php',
    data: values,
    type: 'POST',
    success: function (data, textStatus, jQxhr) {
      var parsed_data = JSON.parse(data);
  
      console.log(data);
  
      if (parsed_data['status'] == 'OK') {
        $('.checklists').empty();
        for (i = 0; i < parsed_data.forms.length; i++) {
          var id = parsed_data.forms[i].id;
          var name = parsed_data.forms[i].name;
          var description = parsed_data.forms[i].description;
          var priority = parsed_data.forms[i].priority;
          var scheduled_date = parsed_data.forms[i].scheduled_date;
          var published_at = parsed_data.forms[i].published_at;
          var frequency = parsed_data.forms[i].frequency;
          var expires_today = parsed_data.forms[i].expires_today;
          var expires_at = parsed_data.forms[i].expires_at;
          var assignees = parsed_data.forms[i].assignees; // Extract assignees array
          var exp = '';
          var ex = '';
          if(expires_today === true){
            exp = '<ons-list-item><span class="trn" style="border:solid 2px #6024ff; padding:5px;border-radius:4px;">Expires Today</span></ons-list-item>';
            ex = '<span class="unique-expires today trn" style="border:solid 2px #6024ff; padding:5px;border-radius:4px;">Expires Today</span>'
          }
  
          const readableDate = convertToReadableDate(scheduled_date);
          var progress_percentage = parsed_data.forms[i].progress_percentage; 
  
          // Dynamically build assignees list
          var assigneesList = '';
          for (var j = 0; j < assignees.length; j++) {
            assigneesList += `<ons-list-item>${assignees[j].name}</ons-list-item>`;
          }
  
          $('.checklists').append(`<div class="expandable-container">
            <div class="unique-container">
              <div class="unique-header" onclick="toggleUniqueContent('content${id}', 'arrow${id}')">
                <div>
                  <h5>${name}</h5><br>
                  <p>${description}</p>
                </div>
                <div class="unique-right-section">
                  ${ex}
                  <div class="unique-arrow" id="arrow${id}"><ons-icon icon="md-arrow-right"></ons-icon></div>
                </div>
              </div>
              <div style="width:100%;">
                <div class="progress-container_c">
                  <div class="progress-percentage_c">${progress_percentage}%</div> 
                  <div class="progress-bar_c">
                    <div class="progress_c" style="width: 0%;" data-progress="${progress_percentage}"></div>
                  </div>
                </div>          
              </div>
              <div class="unique-content" id="content${id}">
                <ons-card class="customCard"> 
                  <div class="customeContainer">
                    <div class="left"><span style="font-weight:bold;" class="trn">Title:</span> ${name}</div>
                    <div class="right"><span style="font-weight:bold;" class="trn">Description:</span> ${description}</div>
                  </div>
                  <div class="content">
                    <ons-list class="customCardList">
                      <ons-list-header class="trn" style="text-transform: capitalize;">${name}</ons-list-header>
                      <ons-list-item style="text-transform: capitalize;"><span class="trn">Priority</span>: ${priority}</ons-list-item>
                      <ons-list-item style="text-transform: capitalize;"><span class="trn">Frequency</span>: ${frequency}</ons-list-item>
                      <ons-list-item><span class="trn">Published Date</span>: ${published_at}</ons-list-item>
                      <ons-list-item><span class="trn">Expires at</span>: ${expires_at}</ons-list-item>
                      ${exp}
                      <ons-list-header class="trn">Assignees</ons-list-header>
                      ${assigneesList} <!-- Insert assignees here -->
                    </ons-list>
                    <ons-list class="customCardList">  
                      <ons-list-header class="trn">Overall Progress</ons-list-header>
                    </ons-list>
                    <div style="padding:10px;">
                      <svg class="radial-progress" data-countervalue="${progress_percentage}" viewBox="0 0 80 80">
                        <circle class="bar-static" cx="40" cy="40" r="35"></circle>
                        <circle class="bar--animated" cx="40" cy="40" r="35" style="stroke-dashoffset: 217.8;"></circle>
                        <text class="countervalue" x="50%" y="57%" transform="matrix(0, 1, -1, 0, 80, 0)">${progress_percentage}</text>
                      </svg>
                    </div>
                    <div style="display: flex;justify-content: space-between;padding:10px;">
                      <button class="button viewChecklistBtn trn" data-id="${id}">View</button>
                    </div>
                  </div>
                </ons-card>
              </div>
            </div>
          </div>`);
  
          checkViewportAndAnimate();
  
          var lang = localStorage.getItem('lang');
          var translator = $(document).translate({lang: "en", t: dict});
          translator.lang(lang);
  
          $('.percenatgeHolder').text(Number(progress_percentage) + '%');
        }
  
        // Animate the progress bars after appending them
        setTimeout(function() {
          $('.progress_c').each(function() {
            var progress = $(this).data('progress');
            $(this).css('width', progress + '%');
          });
        }, 100); // Delay to ensure the elements are in the DOM
      }
    },
    error: function (jqXhr, textStatus, errorThrown) {
      console.log(errorThrown);
    }
  });
  




    


    //Check the scroll
    var lastScrollTop = 0;
$('.page__content').scroll(function() {
    checkViewportAndAnimate();
var scrolled_val = $('.page__content:last').scrollTop();
//console.log(scrolled_val);
if(scrolled_val > 10 ){
    
 bottomToolbar.style.transform = 'translateY(100%)';
}else{
  bottomToolbar.style.transform = 'translateY(0)';
}

});






}

if(page.matches('#ticket-details')){

    var lang = localStorage.getItem('lang');



var currency = localStorage.getItem('currency');

if (lang == 'ge') {
    $('.costTitle').text('Dieses Ticket wird geschlossen. Die gesamte Ausrüstung auf diesem Ticket sollte repariert werden. Bitte fügen Sie unten die Kosten hinzu.');
    $('.currencySymbol').text(currency);
} else if (lang == 'po') {
    $('.costTitle').text('Para fechar este ticket, é necessário inserir um custo para o reparo. Por favor, adicione um valor e envie. O ticket será então fechado.');
    $('.currencySymbol').text(currency);
} else if (lang == 'sp') {
    $('.costTitle').text('Para cerrar este ticket, debe insertar un costo para la reparación. Por favor, agregue un valor y envíe. El ticket se cerrará.');
    $('.currencySymbol').text(currency);
} else if (lang == 'bul') {
    $('.costTitle').text('Този билет ще бъде затворен. Цялата оборудване в този билет трябва да бъде поправена. Моля, добавете разходите по-долу.');
    $('.currencySymbol').text(currency);
} else if (lang == 'it') {
    $('.costTitle').text('Questo ticket verrà chiuso. Tutta l\'attrezzatura su questo ticket dovrebbe essere riparata. Si prega di aggiungere i costi di seguito.');
    $('.currencySymbol').text(currency);
} else if (lang == 'fr') {
    $('.costTitle').text('Ce ticket sera fermé. Tout l\'équipement sur ce ticket devrait être réparé. Veuillez ajouter les coûts ci-dessous.');
    $('.currencySymbol').text(currency);
} else if (lang == 'ar') {
    $('.costTitle').text('سيتم إغلاق هذه التذكرة. يجب إصلاح جميع المعدات المدرجة في هذه التذكرة. يرجى إضافة التكاليف أدناه');
    $('.currencySymbol').text(currency);
}else if (lang == 'ja') {
    $('.costTitle').text('このチケットがクローズされます。このチケットにリストされているすべての機器を修理する必要があります。下に費用を追加してください。');
    $('.currencySymbol').text(currency);
}else if (lang == 'tu') {
$('.costTitle').text('Bu bilet kapatılacak. Listelenen tüm cihazların onarılması gerekmektedir. Lütfen aşağıya maliyet ekleyin.');
$('.currencySymbol').text(currency);

}else {
    // Default to the original text if the language code is not recognized
    $('.costTitle').text('To close this ticket you must insert a cost to repair. Please add a value and submit. The ticket will then be closed.');
    $('.currencySymbol').text(currency);
}
    
}


if (page.matches('#home2')) {

    var dType = localStorage.getItem('deviceType');

    if(dType == 'iOS'){

    }


    var userAgent = navigator.userAgent || navigator.vendor || window.opera;


  if( userAgent.match( /iPhone/i ) || userAgent.match( /iPod/i ) )
  {
    
    $('.homeAvi').addClass('homeAvi_ios');
$('.homeLogo').addClass('homeLogo_ios');


  }else if (userAgent.match( /iPad/i )){
      
      $('.homeAvi').addClass('homeAvi_ios');
$('.homeLogo').addClass('homeLogo_ipad');

  }else if (userAgent.match( /Macintosh/i )){
      $('.homeAvi').addClass('homeAvi_ios');
$('.homeLogo').addClass('homeLogo_ipad');

  }

    
if(localStorage.getItem('email') != null){
    getTotalUnred();
    getMyDetails();
getMyContracts();
}

var now = new Date();
var loggedinTime = localStorage.getItem('loggedinTime');


console.log(loggedinTime);

var date2 = new Date(loggedinTime);
if(now-date2 > 1*60*1000){
  logout();

}else{

 var minutes = date2.getMinutes();
var hours = date2.getHours();   

}


var username = localStorage.getItem('email');
var refresh_token = localStorage.getItem('refreshtoken');

console.log(username);
console.log(refresh_token);


getPermissions();

}

});

document.addEventListener('init', function(event) {
var page = event.target;
if (page.matches('#questioner')) {
serial_numbers = [];
descriptions = [];
asset_sps = [];
}
if (page.matches('#ticket-details')) {

var showBtn = localStorage.getItem('show-tick');
var uType = localStorage.getItem('usertype');



if (uType == 'Gym Operator'){
//$('.closeTicketBtn').addClass('hider');
}

}


if (page.matches('#home2')) {



if(localStorage.getItem('usertype') == 'Gym Operator' ){

$('.go-el').show();
$('.sp-el').hide();
$('.ta-el').hide();

}else{

$('.go-el').hide();
$('.sp-el').show();
$('.ta-el').hide();

  }

var role = localStorage.getItem('role');

if(role == 'ticket_admin'){

$('.ta-el').show();

}
}

  //show/hide checklist

  
if(localStorage.getItem('manage_checklists') == "true"){

$('.gotochecklists').removeClass('opchecks');

}else{
    $('.gotochecklists').addClass('opchecks');
}

if (page.matches('#questioner')) {

var qs = JSON.parse(localStorage.getItem('service_level_agreements'));

names = [];
results = {};

 $.each(qs, ( key, value ) => {

   names.push(value.id);

   

   var listItem = '<ons-list-header>'+value.name+'</ons-list-header>'+
    '<ons-list-item tappable>'+
      '<label class="left">'+
        '<ons-radio name="'+value.id+'" value="0"></ons-radio>'+
      '</label>'+
      '<label for="" class="center">Yes</label>'+
    '</ons-list-item>'+
    '<ons-list-item tappable>'+
      '<label class="left">'+
  '<ons-radio name="'+value.id+'" value="1"></ons-radio>'+
      '</label>'+
      '<label for="" class="center">No</label>'+
    '</ons-list-item>';
   
$('.slaList').append(listItem);

 });



}


if (page.matches('#ticket-details')) {



    var ticketType = localStorage.getItem('ticketType');

    if(ticketType == 'ad-hoc'){
        
//$('.transferTicketBtn').hide();
$('.depbtn').hide();

    }
 
innerNotes = [];

var uuid = localStorage.getItem('uuid');
var ticketNo = localStorage.getItem('ticketNumber');
var notes = localStorage.getItem('notes');

var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

//$(this).prop('disabled', true);
//$('.loaderIcon').show();


$('.closeTicketBtn').attr('data-id', uuid);

$.ajax({
    url: host + 'getTicketMedia.php?email=' + email + '&accesstoken=' + accesstoken + '&uuid=' + uuid,
    type: 'GET',
    processData: false,
    success: function(data, textStatus, jQxhr) {
        var parsed_data = JSON.parse(data);



        parsed_data.media.forEach(function(media) {

         
            if (media.type === 'image') {
                // Do something for images

    $('.viewport').empty();
    var img = media.url;


$('.imghistory').append('<div class="grid__photo addedImg"><img src="'+img+'"></div>');
   
 
    
            } else if (media.type === 'video') {
                // Do something for videos

      

                var video = media.url;
               //add video to page here...
 $('.imghistory').append("<div class='grid__photo' style='overflow:hidden;position: relative;'><video class='custom-video' style='width: 100%;height: 100%;top: 0;left: 0;padding:0;margin:0;' src='" + video + "#t=0.2' poster'"+media.poster_url+"'></video><button class='play-pause-button'></button></div>");



            } else if (media.type === 'audio') {
                // Do something for audio files
                //console.log('Audio:', media);
            } else {
                // Handle other types if needed
            }
        });
    }
});

$.ajax({
    url: ''+host+'getTicket.php?email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){


      var json = JSON.stringify(data);

      console.log(data);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);


console.log(JSON.stringify(parsed_data.ticket.notes));
//michelle is a faggot
combinedNotes.push(...parsed_data.ticket.notes);

//lets get the audios here







for(i=0;i<parsed_data.ticket.notes.length;i++){



var note = parsed_data.ticket.notes[i].note;
var who = parsed_data.ticket.notes[i].who;
var created_at = parsed_data.ticket.notes[i].created_at;
var formatted_created_at = parsed_data.ticket.notes[i].formatted_created_at;
var classs = '';
var icon = '';
var t = '';


if(who == 'Gym Operator' || who == 'Betreiber eines Fitnessstudios'){

classs = 'Gym Operator';
icon = '--account-color: green;';
t = 'c-note--start';

}else{

classs = 'Service Provider';
icon = '--account-color: rgba(21,79,255,1);';
t = 'c-note--end';

}

var uType = localStorage.getItem('usertype');


var today = new Date(created_at);
var dd = String(today.getDate()).padStart(2, '0');
var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
var yyyy = today.getFullYear();

today = mm + '/' + dd + '/' + yyyy;

}

var wHeight = $(window).height() - 55;
	$('.notesD').css({
		'height' : wHeight + 'px'	
	});	


for(i=0;i<parsed_data.ticket.assets.length;i++){

var ticketType = parsed_data.ticket.type;

if(ticketType != 'standard'){
//$('.clockIn').hide();
}

   var full_name = parsed_data.ticket.assets[i].full_name;

   var description = parsed_data.ticket.assets[i].description

    var serial_number = parsed_data.ticket.assets[i].serial_number;


  if(parsed_data.ticket.assets[i].image != null){  
var img = parsed_data.ticket.assets[i].image['thumb'];
 }


var innernotes = parsed_data.ticket.assets[i].notes;

innernotes = JSON.stringify(innernotes);

}



    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
    }
});


}

if (page.matches('#videos')) {

    var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

    $.ajax({
url: ''+host+'get-videos.php?email='+email+'&accesstoken='+accesstoken+'',
type: 'GET',
beforeSend: function (xhr) {
   
},
data: {},
success: function (data) { 

console.log(data);
var parsed_data = JSON.parse(data);


for(i=0;i<parsed_data.resources.length;i++){

    


   var title = parsed_data.resources[i].title;
   var created_at = parsed_data.resources[i].created_at;
var path = parsed_data.resources[i].src;

console.log(path);


  var video = '<div class="player-overlay" data-src="'+path+'">'+
   '<div class="vidtitle">'+title+'</div>'+
   '<div class="vidLogo animated bounceInTop"><img src="images/video_logo.png"></div>'+
   '<div class="vidPlay" ><ons-icon icon="fa-play"></ons-icon></div>'+
    '<video preload="none" poster="https://rooz-dev.co.uk/.weservice/vide_bg.png">'+
        '<source src="'+path+'#t=0.10" />'+
    '</video>'+    
'</div>';

   $('.videoList').append(video);
}



},
error: function () { },
});


}


if (page.matches('#home2')) {





var userAgent = navigator.userAgent || navigator.vendor || window.opera;

  if( userAgent.match( /iPad/i ) || userAgent.match( /iPhone/i ) || userAgent.match( /iPod/i ) )
  {


    

  }
  else if( userAgent.match( /Android/i ) )
  {

   
  }
  else
  {
    //alert('unknown'); 
  }






if (localStorage.getItem('loggedin') !== null) { 


    var company = localStorage.getItem('company');



}else{


 var modal = document.getElementById('loginmodal');
 modal.show();

}



}
 if(page.matches('#addimg')){


callQRscanner3();

 }


if (page.matches('#raise')) {


  serial_numbers = [];
  descriptions = [];
  asset_sps = [];
  newAddImgs = [];

var today = new Date();
var dd = String(today.getDate()).padStart(2, '0');
var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
var yyyy = today.getFullYear();

today = dd + '/' + mm + '/' + yyyy;
$('.todayDate').text(today);


var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');


$('.faultBtn').click();
$('.large_repBtn').remove();
$('.priHolder').show();





callQRscanner();

}





});

//login
$(document).on('click', '.loginBtn', function(){ 

$('.pncircle').remove();
var username = $('.username').val();
var password = $('.password').val().trim();



  var notificationOpenedCallback = function(jsonData) {

    ///notification opens here...
    //alert('notificationOpenedCallback: ' + JSON.stringify(jsonData));



  var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};

var notify = function() {


function alertDismissed() {

}

navigator.notification.alert(
    JSON.stringify(jsonData),  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);


};

notify();



  };



var lang = localStorage.getItem('lang');

if(lang == 'ge'){
lang = 'de'
}

if(username != '' || password != ''){
$(this).prop('disabled', true);
var pmodal = document.getElementById('preloaderModal');
pmodal.show();

var data = { 
    language : lang,
    device_id: localStorage.getItem('device_id'),
    email: username,
    password: password,
};
$.ajax({
    url: ''+host+'login-new.php?language='+lang+'&device_id='+externalUserId+'&email='+username+'&password='+password+'',
    //dataType: 'text',
    crossDomain: true,
    crossOrigin: true,
    async: true,
    data: data,
    type: 'POST',
    //processData: false,
    success: function( data, textStatus, jQxhr ){
              console.log(data);
var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
      var json = JSON.stringify(data);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);


var company = parsed_data['company'];

var role = parsed_data['role'];


localStorage.setItem('role', role);
//var company = 'GymBox Test';
localStorage.setItem('company', company);


if(parsed_data['status'] == 'OK'){

    

        var refreshtoken = parsed_data['refreshtoken'];
        var accesstoken = parsed_data['accesstoken'];
        var expiry = parsed_data['expiry'];
        var usertype = parsed_data['type'];
        var permissions = parsed_data['permissions'];



        console.log(JSON.stringify(permissions));

if(usertype =='Gym Operator'){
var pr = JSON.stringify(permissions.raise_internal_ticket);
var pr2 = JSON.stringify(permissions.raise_adhoc_ticket);
var force_ticket_media = JSON.stringify(permissions.force_ticket_media);


localStorage.setItem('permissions_raise_internal_ticket', pr);
localStorage.setItem('permissions_raise_adhoc_ticket', pr2);
localStorage.setItem('permissions_force_ticket_media', force_ticket_media);

}

if(usertype =='Service Provider' && role != 'engineer'){
var manage_engineers = JSON.stringify(permissions.manage_engineers);
localStorage.setItem('permissions_manage_engineers', manage_engineers);
}


      localStorage.setItem('email', username);
      localStorage.setItem('password', password);
      localStorage.setItem('refreshtoken', refreshtoken);
      localStorage.setItem('accesstoken', accesstoken);
      localStorage.setItem('expiry', expiry);


      getMyContracts();

console.log("my access token" +accesstoken);

localStorage.setItem('usertype', usertype);

getMyDetails();

getTotalUnred();
getMyContracts();

if(usertype == 'Gym Operator' ){

$('.go-el').show();
$('.sp-el').hide();
$('.ta-el').hide();

}else{

$('.go-el').hide();
$('.sp-el').show();
$('.ta-el').hide();

  }


if(role == 'ticket_admin'){

$('.ta-el').show();

}

localStorage.setItem('manage_checklists', permissions.manage_checklists)


  //show/hide checklist
if(permissions.manage_checklists == true){

$('.gotochecklists').removeClass('opchecks');

}else{
    $('.gotochecklists').addClass('opchecks');

}




var now = new Date();
now.setMinutes(now.getMinutes() + 20); // timestamp
now = new Date(now);

localStorage.setItem('loggedinTime', now);


var now = new Date();
var loggedinTime = localStorage.getItem('loggedinTime');


console.log(loggedinTime);

var date2 = new Date(loggedinTime);
if(now-date2 > 1*60*1000){
  logout();

}else{

 var minutes = date2.getMinutes();
var hours = date2.getHours();   
}

      localStorage.setItem('loggedin', 'yes');

      $('.button').prop('disabled', false);
      $('.loaderIcon').hide();

var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};




var modal = document.querySelector('ons-modal'); 
modal.hide({animation: 'lift'});

$('.loginHolder').addClass('animated zoomOut');

setTimeout(function() {

var modal = document.getElementById('loginmodal');
modal.hide();

$('.loginHolder').removeClass('animated zoomOut');

function OneSignalInit() {


  setTimeout(function(){ 

    //window.plugins.OneSignal.initialize(""+oneSignalId+"");
//window.plugins.OneSignal.User.pushSubscription.optIn();
 //window.plugins.OneSignal.login(''+externalUserId+''); 

    ///window.plugins.OneSignal.getIds(function(ids) {
               // alert("player id: " + ids.userId);
            //});

             window.plugins.OneSignal.setAppId(oneSignalId);
    window.plugins.OneSignal.setNotificationOpenedHandler(function(jsonData) {
        //alert('notificationOpenedCallback: ' + JSON.stringify(jsonData));

    });


  window.plugins.OneSignal.setExternalUserId(''+externalUserId+''); 



  window.plugins.OneSignal.promptForPushNotificationsWithUserResponse(function(accepted) {
        //alert("User accepted notifications: " + accepted);

        if( accepted == true){

        }else{



        }

    });

 }, 2000);

}

OneSignalInit();

  }, 1000);







}else{


      $('.button').prop('disabled', false);
      $('.loaderIcon').hide();

var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};




function alertDismissed() {
    // do something
}

navigator.notification.alert(
    JSON.stringify(parsed_data['msg']),  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);




}





    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});


}
});






//forgotter
$(document).on('click', '.signupBtn', function(){ 
  
var username = $('.emailS').val();


if(username != ''){
var pmodal = document.getElementById('preloaderModal');
pmodal.show();
$(this).prop('disabled', true);
$('.loaderIcon').show();

$.ajax({
    url: ''+host+'forgotten-pass.php?email='+username+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){
              //alert(JSON.stringify(data));
var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
      var json = JSON.stringify(data);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);

     console.log(data);


  

if(parsed_data['status'] == 'OK'){

     $('.button').prop('disabled', false);
      $('.loaderIcon').hide();

var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};


var lang = localStorage.getItem('lang');



function alertDismissed() {
    // do something
}

if (lang == 'ge') {
    navigator.notification.alert(
        'Eine E-Mail wurde an Ihre E-Mail-Adresse gesendet.',  // message
        alertDismissed,         // callback
        'Bestätigung',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'po') {
    navigator.notification.alert(
        'Um e-mail foi enviado para o seu endereço de e-mail.',  // message
        alertDismissed,         // callback
        'Sucesso',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'sp') {
    navigator.notification.alert(
        'Se ha enviado un correo electrónico a su dirección de correo electrónico.',  // message
        alertDismissed,         // callback
        'Éxito',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'bul') {
    navigator.notification.alert(
        'Изпратено е писмо на вашия имейл адрес.',  // message
        alertDismissed,         // callback
        'Успех',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'it') {
    navigator.notification.alert(
        'Una email è stata inviata al tuo indirizzo email.',  // message
        alertDismissed,         // callback
        'Successo',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'fr') {
    navigator.notification.alert(
        'Un email a été envoyé à votre adresse email.',  // message
        alertDismissed,         // callback
        'Succès',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'ar') {
    navigator.notification.alert(
        'تم إرسال بريد إلكتروني إلى عنوان بريدك الإلكتروني',  // message
        alertDismissed,         // callback
        'نجاح',            // title
        'حسنا'                  // buttonName
    );
} else if (lang == 'ja') {
navigator.notification.alert(
    'メールがあなたのメールアドレスに送信されました。',  // message
    alertDismissed,         // callback
    '成功',            // title
    'わかりました'                  // buttonName
);
}else if (lang == 'tu') {
navigator.notification.alert(
    'E-posta adresinize bir e-posta gönderildi.',  // mesaj
    alertDismissed,         // geri çağrı
    'Başarılı',            // başlık
    'Anladım'                  // düğme adı
);

}else {
    // Default to the original text if the language code is not recognized
    navigator.notification.alert(
        'An email has been sent to your email.',  // message
        alertDismissed,         // callback
        'Success',            // title
        'OK'                  // buttonName
    );
}


}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});

}

});



//add asset to the ticket (QR version)
$(document).on('click', '.addAassetBtn', function(){ 


function countVisibleElementsByClassName(className) {
  // Get all elements with the specified class name
  var elements = document.getElementsByClassName(className);
  var visibleElements = [];

  // Loop through the elements and count only those that are visible
  for (var i = 0; i < elements.length; i++) {
    var element = elements[i];
    if (isVisible(element)) {
      visibleElements.push(element);
    }
  }

  // Click on the element if there's only one visible element
  if (visibleElements.length === 1) {
    visibleElements[0].click();
  }

  return visibleElements.length;
}

// Helper function to check if an element is visible
function isVisible(element) {
  return element.offsetParent !== null;
}

// Example usage:
var className = 'whoSendm';
var visibleCount = countVisibleElementsByClassName(className);
//alert('Number of visible elements with class "' + className + '": ' + visibleCount);


var serial = $(this).attr('data-serial');
var image = $(this).attr('data-image');
var note = $('.asset_note').val();
var prev = $('.asset_note').attr('data-prev');
var fullname = $('.assetFullname').text();
$('.m_dis').val(note);
$('.asset_note').val('');

function blink() {
$(".asset_note").addClass("blinking");
    // Remove blinking class after 3 seconds
    setTimeout(function(){
        $(".asset_note").removeClass("blinking");
    }, 3000);
}
 if(note == ''){

     blink();
     return;

 }else if(note == 'Write full description of the fault'){
blink();
return;
 }else if(note =='Fehlerbeschreibung einfügen'){
blink();
return;
 }else if(note =='Escreva uma descrição completa do erro'){
blink();
return;
 }else if(note =='Escriba una descripción completa de la falla'){
blink();
return;
 }else if(note =='Écrire une description complète de la panne'){
blink();
return;
 }else if(note =='Scrivi una descrizione completa del difetto'){
blink();
return;
 }else if(note =='Напишете пълно описание на грешката'){
blink();
return;
 }else if(note == 'Please describe the pads you need replacing'){
blink();
return;
 }else if(note =='Bitte beschreiben Sie die Pads, die Sie ersetzen müssen'){
blink();
return;
 }else if(note =='Please describe the pads you need replacing'){
blink();
return;
 }else if(note =='Por favor, descreva as almofadas que precisa substituir'){
blink();
return;
 }else if(note =='Por favor, describa las almohadillas que necesita reemplazar'){
blink();
return;
 }else if(note =='Veuillez décrire les tampons que vous devez remplacer'){
blink();
return;
 }else if(note =='Si prega di descrivere i tamponi che è necessario sostituire'){
blink();
return;
 }else if(note =='Моля, опишете тампоните, които трябва да бъдат заменени'){
blink();
return;
 }else if(note =='يرجى وصف الوسائد التي تحتاج إلى استبداله'){
blink();
return;
 }else if(note =='交換が必要なパッドを説明してください'){
blink();
return;
 }


$('.toAddAsset').hide();
$('.newqrCaller').hide();
$('.proceedbtns').hide();
$('.scanUph').hide();

var ass = '';
if (newTicketasset.length < 0) {

    
 var item = newTicketasset.filter(function(a){ return a.serial == serial })[0];
var img = item.image;


var assetToAdd = {
  "serial": serial,
  "note": note,
  "image": img
}

}else{


    var assetToAdd = {
  "serial": serial,
  "note": note,
  "image": null
}

console.log(JSON.stringify(assetToAdd));





}






 newTicketasset = newTicketasset.filter(function( obj ) {
  return obj.serial !== serial;
});




const index = serial_numbers.indexOf(serial);
if (index > -1) {
  serial_numbers.splice(index, 1);
}

const index2 = descriptions.indexOf(prev);
if (index2 > -1) {
  descriptions.splice(index2, 1);
}


serial_numbers.push(serial);
descriptions.push(note);

if(count.true > 1){

}else{
asset_sps.push(ass);
}


newTicketasset.push(assetToAdd);

$('.assetsQR').append('<ons-button id="'+serial+'" data-note="'+note+'" data-serial="'+serial+'" data-name="'+fullname+'" data-image="'+image+'" class="addedAsset '+serial+'" modifier="large">'+fullname+'</ons-button>');

if($("."+serial+"" ).length > 0){
//document.getElementById(serial).outerHTML="";
}

 var modal = document.getElementById('assetmodal');
  modal.hide({animation: 'lift'});


//$('.asset_note').val('');

setTimeout(doSomething, 800);

function doSomething() {


   var lang = localStorage.getItem('lang');

var txt = '';
if (lang == 'ge') {
    // German
    txt = 'Bitte fügen Sie diesem Ticket ein Video oder ein Foto hinzu.';
    $('.vidImgTxt').text(txt);
} else if (lang == 'po') {
    // Portuguese
    txt = 'Por favor, adicione um vídeo ou uma foto a este ticket.';
    $('.vidImgTxt').text(txt);
} else if (lang == 'sp') {
    // Spanish
    txt = 'Por favor, agregue un video o una foto a este ticket.';
    $('.vidImgTxt').text(txt);
} else if (lang == 'bul') {
    // Bulgarian
    txt = 'Моля, добавете видео или снимка към този билет.';
    $('.vidImgTxt').text(txt);
} else if (lang == 'it') {
    // Italian
    txt = 'Si prega di aggiungere un video o una foto a questo biglietto.';
    $('.vidImgTxt').text(txt);
} else if (lang == 'fr') {
    // French
    txt = 'Veuillez ajouter une vidéo ou une photo à ce ticket.';
    $('.vidImgTxt').text(txt);
} else if (lang == 'ar') {
    // Arabic
    txt = 'يرجى إضافة فيديو أو صورة إلى هذه التذكرة.';
    $('.vidImgTxt').text(txt);
} else if (lang == 'ja') {
    // Japanese
    txt = 'このチケットにビデオまたは写真を追加してください。';
    $('.vidImgTxt').text(txt);
} else if (lang == 'tu') {
    // Turkish
    txt = 'Lütfen bu bilete bir video veya fotoğraf ekleyin.';
    $('.vidImgTxt').text(txt);
} else {
    // Default (English)
    txt = 'Please add a video or a photo to this ticket now.';
    $('.vidImgTxt').text(txt);
}






//$('.spgoholder').hide();
 $('.whoSend').eq(0).removeClass('animated slideOutLeft');
$('.whoSend').eq(1).removeClass('animated slideOutRight');
$('.whoSend').eq(0).addClass('animated slideInLeft');
$('.whoSend').eq(1).addClass('animated slideInRight');
 //$('.btnsHolder').show();
}


$('.vidImgBtnsHolder').show();

});





///Submit New Ticket
$(document).on('click', '.submitTicketBtn', function(){ 

var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

//$(this).prop('disabled', true);
//$('.loaderIcon').show();


// Function to check if an array contains null values or is empty
function hasNullOrEmpty(array) {
    var hasNullValue = false;

    // Check for null values and if the array is empty
    array.forEach(function(element) {
        if (element === null) {
            hasNullValue = true;
        }
    });

    return hasNullValue || array.length === 0;
}

var dis = '';
var sers = JSON.stringify(serial_numbers);
var newTicketass = JSON.stringify(newTicketasset);
var assSps = JSON.stringify(asset_sps);
var images = newAddImgs;
var singleSerial =serial_numbers[0];
//var ticketAdmin_QR = $('.ticketAdmin_QR').val();
var ticketAdmin_QR = tiAdmin;
//var newTicketAdmin = $('.newTicketAdmin_QR').val();
var newTicketAdmin = newTicketAdminQR;


var hasNote = hasNullOrEmpty(descriptions);

if(hasNote === true){

const lang = localStorage.getItem('lang');

function onConfirm(results) {
    alert(results.input1);
    descriptions = [];
    descriptions.push(results.input1);
    dis = JSON.stringify(descriptions);
}


if (lang == 'ge') {
navigator.notification.prompt(
    'Bitte geben Sie eine Beschreibung für dieses Ticket ein, bevor Sie es absenden.',  // Nachricht
    onConfirm,              // Rückruffunktion, die mit dem Index des gedrückten Buttons aufgerufen wird
    'Achtung',              // Titel
    ['OK']                  // Beschriftungen der Schaltflächen
);
} else if (lang == 'po') {
navigator.notification.prompt(
    'Por favor, insira uma descrição para este ticket antes de enviar.',  // mensagem
    onConfirm,              // função de callback para invocar com o índice do botão pressionado
    'Atenção',              // título
    ['OK']                  // etiquetas dos botões
);
} else if (lang == 'sp') {
navigator.notification.prompt(
    'Por favor, ingrese una descripción para este ticket antes de enviarlo.',  // mensaje
    onConfirm,              // función de retorno que se invocará con el índice del botón presionado
    'Atención',             // título
    ['Aceptar']             // etiquetas de los botones
);
} else if (lang == 'bul') {
navigator.notification.prompt(
    'Моля, въведете описание за този билет преди да го изпратите.',  // съобщение
    onConfirm,              // функция за обратно извикване, която да се извика с индекса на натиснатия бутон
    'Внимание',             // заглавие
    ['Добре']               // етикети на бутоните
);
} else if (lang == 'it') {
navigator.notification.prompt(
    'Si prega di inserire una descrizione per questo ticket prima di inviarlo.',  // messaggio
    onConfirm,              // callback da invocare con l'indice del pulsante premuto
    'Attenzione',           // titolo
    ['OK']                  // etichette dei pulsanti
);
} else if (lang == 'fr') {
navigator.notification.prompt(
    'Veuillez saisir une description pour ce ticket avant de le soumettre.',  // message
    onConfirm,              // fonction de rappel à invoquer avec l'indice du bouton pressé
    'Attention',            // titre
    ['OK']                  // libellés des boutons
);

} else if (lang == 'ar') {
    navigator.notification.prompt(
        'يرجى إدخال وصف لهذه التذكرة قبل التقديم.',  // message
        alertDismissed,         // callback
        'تنبيه',            // title
        'موافق'                  // buttonName
    );
}else if (lang == 'ja') {
navigator.notification.prompt(
    'チケットを送信する前に、このチケットの説明を入力してください。',  // メッセージ
    onConfirm,              // ボタンが押された時に呼び出されるコールバック
    '注意',                  // タイトル
    ['OK']                  // ボタンのラベル
);

}else if (lang == 'tu') {
navigator.notification.prompt(
    'Bilet göndermeden önce bu bilet için bir açıklama girin.',  // Mesaj
    onConfirm,              // Butona basıldığında çağrılacak geri çağrı
    'Dikkat',                  // Başlık
    ['Tamam']                  // Düğme etiketleri
);


}else {
    // Default to the original text if the language code is not recognized
    navigator.notification.prompt(
        'Please enter a description for this ticket before submitting.',  // message
        onConfirm,              // callback to invoke with index of button pressed
        'Attention',            // title
         ['OK'],             // buttonLabels
         'Enter Description Here...'                 // defaultText
    );
}


return;

}else{

var pmodal = document.getElementById('preloaderModal');
pmodal.show();
dis = JSON.stringify(descriptions);

}

var values = {
    'type': 'standard',
            'sps': assSps,
            'email': email,
            'accesstoken': accesstoken,
            'serial_number': sers,
            'description': dis,
            'images': images,
            'singleSerial': singleSerial,
            'priority': priority,
    };


var pr = localStorage.getItem('permissions_raise_internal_ticket');


//testing 101
if(whoToSend == 'ta'){

if(newTicketAdmin != ''){


var values = {

            'ticket_admin_new' : newTicketAdmin,
            'type': 'internal',
            'sps': assSps,
            'email': email,
            'accesstoken': accesstoken,
            'serial_number': sers,
            'description': dis,
            'images': images,
            'singleSerial': singleSerial,
            'priority': priority,
    };

}else{

var values = {
    'ticketAdmin': ticketAdmin_QR,
            'type': 'internal',
            'email': email,
            'accesstoken': accesstoken,
            'serial_number': sers,
            'description': dis,
            'images': images,
            'singleSerial': singleSerial,
            'priority': priority,
    };
}


}else{


var values = {
    'type': 'standard',
            'sps': assSps,
            'email': email,
            'accesstoken': accesstoken,
            'serial_number': sers,
            'description': dis,
            'images': images,
            'singleSerial': singleSerial,
            'priority': priority,
    };


    console.log(JSON.stringify(values));

}

    //console.log(images);

    

$.ajax({
    url: ''+host+'...submitTicketQR.php',
     //dataType: 'text',
    data: values,
    type: 'POST',
    success: function( data, textStatus, jQxhr ){

var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
      var json = JSON.stringify(data);

      console.log(data);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);


if(parsed_data['status'] == 'OK'){

$('.newTicketAdmin_QR').val('');
      $('.button').prop('disabled', false);
      $('.loaderIcon').hide();

var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};


var lang = localStorage.getItem('lang');



function alertDismissed() {
    document.querySelector('#myNavigator').popPage();
}

if (lang == 'ge') {
    navigator.notification.alert(
        'Ihr Ticket wurde erfolgreich versendet.',  // message
        alertDismissed,         // callback
        'Bestätigung',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'po') {
    navigator.notification.alert(
        'Seu novo ticket foi enviado com sucesso.',  // message
        alertDismissed,         // callback
        'Sucesso',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'sp') {
    navigator.notification.alert(
        'Su nuevo ticket ha sido enviado con éxito.',  // message
        alertDismissed,         // callback
        'Éxito',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'bul') {
    navigator.notification.alert(
        'Новият ви билет беше изпратен успешно.',  // message
        alertDismissed,         // callback
        'Успех',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'it') {
    navigator.notification.alert(
        'Il tuo nuovo ticket è stato inviato con successo.',  // message
        alertDismissed,         // callback
        'Successo',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'fr') {
    navigator.notification.alert(
        'Votre nouveau ticket a été envoyé avec succès.',  // message
        alertDismissed,         // callback
        'Succès',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'ar') {
    navigator.notification.alert(
        'تم إرسال تذكرتك الجديدة بنجاح',  // message
        alertDismissed,         // callback
        'نجاح',            // title
        'حسنا'                  // buttonName
    );
}else if (lang == 'ja') {
navigator.notification.alert(
    '新しいチケットが正常に送信されました',  // message
    alertDismissed,         // callback
    '成功',            // title
    'OK'                  // buttonName
);
}else if (lang == 'tu') {
navigator.notification.alert(
    'Yeni bilet başarıyla gönderildi',  // mesaj
    alertDismissed,         // geri çağrı
    'Başarılı',            // başlık
    'Tamam'                  // düğmeAdı
);

}else {
    // Default to the original text if the language code is not recognized
    navigator.notification.alert(
        'Your new ticket has been sent.',  // message
        alertDismissed,         // callback
        'Success',            // title
        'OK'                  // buttonName
    );
}


newAddImgs =[];


}else{




function alertDismissed() {

}

navigator.notification.alert(
    parsed_data['msg'],  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);

newAddImgs =[];

}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});




});



$(document).on('click', '.tickets', function(){ 
var innernotes = $(this).data('inner-notes');
//var finalNotes1 = innernotes.replace('[','');
//var finalNotes2 = finalNotes1.replace(']','');
innernotes = JSON.parse(innernotes);
ticketDeatilsNotes = innernotes;
});

///View New Ticket

$(document).on('click', '.serviceViewTicketBtn', function(e){ 
    e.preventDefault();

    bottomToolbar.style.transform = 'translateY(100%)';

var pmodal = document.getElementById('preloaderModal');
pmodal.show();
var uuid = $(this).attr('data-uuid');
var ticketNumber = $(this).attr('data-ticketNumber');


localStorage.setItem('uuid', uuid);
localStorage.setItem('ticketNumber', ticketNumber);

document.querySelector('#myNavigator').popPage();
setTimeout(function(){
    document.querySelector('#myNavigator').pushPage('ticket-details.html');
var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
},1000);
});
$(document).on('click', '.viewTicketBtn', function(){ 

    bottomToolbar.style.transform = 'translateY(100%)';

var pmodal = document.getElementById('preloaderModal');
pmodal.show();
var uuid = $(this).attr('data-uuid');
var ticketNumber = $(this).attr('data-ticketNumber');
var notes = $(this).attr('data-notes');
var ty = $(this).attr('data-type');
var appendable = $(this).attr('data-appendable');
var dataarray = $(this).attr('data-array');
localStorage.setItem('ticket_status', ty);
var ticketType = $(this).attr("data-ticket");

localStorage.setItem('ticketType', ticketType);


    if($(this).hasClass('closedTicket')){
      viewing = 'closedTicket';
    }else{
       viewing = '';


localStorage.setItem('appendable', appendable);
    }




localStorage.setItem('uuid', uuid);
localStorage.setItem('ticketNumber', ticketNumber);
localStorage.setItem('notes', notes);



if(ty == 'open'){
localStorage.setItem('show-tick', 'yes');
}else{
localStorage.setItem('show-tick', 'no');
}



setTimeout(function(){
    document.querySelector('#myNavigator').pushPage('ticket-details.html');
var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
},1000);





});




$(document).on('focusout', '.wholeNote', function(){ 

    setTimeout(doSomething, 300);

function doSomething() {
     $('.updateTicketBtn').addClass('microphopne');
$('.sIconMic').show();
$('.sIcon').hide();
$('.holder').removeClass('holderTapped');
}
});


$(document).on('focus', 'input[type="text"], input[type="number"]', function(){
$('.bottomToolbar').hide();
});

$(document).on('focusout', 'input[type="text"], input[type="number"]', function(){ 
$('.bottomToolbar').show();


});




$(document).on('click', '.microphopne', function(){ 


cordova.plugins.diagnostic.getMicrophoneAuthorizationStatus(function(status){
        if (status === cordova.plugins.diagnostic.permissionStatus.GRANTED) {
            // Permission granted, do nothing
            console.log("Microphone permission granted");
        } else {
            // Request permission
requestMicrophonePermission();

            
        }
    }, function(error){
        console.error("Error checking microphone permission: " + error);
        return;
    });




$('.holder').addClass('holderTapped');

var uuid = localStorage.getItem('uuid');
var userType = localStorage.getItem('usertype');


var button = this;
var holdTimer;
var holdThreshold = 500; // Adjust this value as needed (in milliseconds)
var mediaRecorder; // Define mediaRecorder variable in a broader scope
var stream; // Define stream variable in a broader scope

function onTouchStart(event) {
    event.preventDefault(); // Prevent default touch behavior
    navigator.vibrate(100);
    showOnsPopover(this);
    //button.classList.toggle("active");
    holdTimer = setTimeout(function() {
        // Long press detected
        console.log("Button held down");
        hideOnsPopover(button);
        // Add your action for long-press here


        $('.soundWaveCanvas').show();
        $('.microRecording').show();


// Create countdown container element
var countdownContainer = document.createElement('div');
countdownContainer.id = 'countdown-container';
document.body.appendChild(countdownContainer);

// Create countdown element inside the container
var countdownElement = document.createElement('div');
countdownElement.id = 'countdown';
countdownContainer.appendChild(countdownElement);

// Set initial countdown value
var countdownValue = 60;

// Function to update countdown
function updateCountdown() {
  countdownElement.textContent = countdownValue;
  countdownValue--;

  // Check if countdown has reached 0
  if (countdownValue < 0) {
    clearInterval(intervalId); // Stop the countdown
    countdownElement.textContent = 'Time\'s up!';
  }
}

// Update countdown every second
var intervalId = setInterval(updateCountdown, 1000);

// Initial call to update countdown immediately
updateCountdown();


        // Request permission to access the microphone
        navigator.mediaDevices.getUserMedia({ audio: true })
            .then(function(str) {
                stream = str; // Store the stream in the broader scope variable
                // Create an AudioContext
                var audioContext = new (window.AudioContext || window.webkitAudioContext)();

                // Create a MediaStreamAudioSourceNode
                var source = audioContext.createMediaStreamSource(stream);

                // Create an AnalyserNode
                var analyser = audioContext.createAnalyser();
                analyser.fftSize = 2048;

                // Connect the source to the analyser
                source.connect(analyser);

                // Get the canvas and its 2D rendering context
                var canvas = document.getElementById('soundWaveCanvas');
                var ctx = canvas.getContext('2d');

                // Draw the sound wave in real-time
                drawSoundWave(ctx, analyser);

                // Create a MediaRecorder object
                mediaRecorder = new MediaRecorder(stream);
                var recordedChunks = []; // To store recorded audio chunks

                // Define callbacks for success and error
                mediaRecorder.ondataavailable = function(event) {
                    recordedChunks.push(event.data);
                };

                mediaRecorder.onerror = function(error) {
                    console.error('Error while recording: ', error);
                };

                mediaRecorder.onstop = function() {
                    // Concatenate recorded chunks into a single Blob
                    var recordedBlob = new Blob(recordedChunks, { type: 'audio/webm' });    

                   

                    // Convert recorded audio to base64
                    var reader = new FileReader();
                    reader.onloadend = function() {
//this is what we send to the server
console.log(reader.result);




// Base64 string to be sent to PHP
var base64String = reader.result;


var uuid = localStorage.getItem('uuid');
// Retrieve user type and role from localStorage
const uType = localStorage.getItem('usertype');
var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');
var lang = localStorage.getItem('country');


// Create a FormData object
// Helper function to make AJAX calls and return a Promise
function makeAjaxCall(url, method, data = null) {
    return $.ajax({
        url: url,
        type: method,
        data: data,
        processData: false,
        contentType: false // Needed for FormData
    });
}

// Async function to handle the sequence of AJAX calls
async function handleTranscriptionAndUpdates() {
    try {
        // Prepare and send the initial FormData to the transcription API
        let formData = new FormData();
        formData.append('uuid', uuid);
        //formData.append('usertype', storeUserType);
        formData.append('email', email);
        formData.append('accesstoken', accesstoken);
        formData.append('base64String', base64String);
        formData.append('lang', lang);
        formData.append('type', 'audio');

        //post Audio files to tickets notes
        let transcriptionResponse = await makeAjaxCall(host+'postNewTicketMedia.php', 'POST', formData);

        let responseObj = JSON.parse(transcriptionResponse);
        var audioFile = responseObj.file;

        console.log(JSON.stringify(responseObj));

   
    } catch (error) {
        console.error('An error occurred:', error);
    }
}


// Execute the async function
handleTranscriptionAndUpdates();

                        var audioData = reader.result.split(',')[1]; // Extract base64 data
                        playAudio(audioData);
                        
                    };
                    reader.readAsDataURL(recordedBlob);
                };

                // Start recording
                mediaRecorder.start();

                // Stop recording after 10 seconds (for example)
                setTimeout(function() {
                    mediaRecorder.stop();
                    stream.getTracks().forEach(track => track.stop()); // Stop the stream

                }, 60000); // 50 seconds
            })
            .catch(function(error) {
                console.error('Error accessing microphone: ', error);
            });
    }, holdThreshold);
}

function onTouchEnd() {
    clearTimeout(holdTimer);
    //button.classList.toggle("active");
    $('.soundWaveCanvas').hide();
    $('.microRecording').hide();
    
    // If the touch is ended before the hold threshold is reached, clear the timeout
    if (mediaRecorder) { // Check if mediaRecorder is defined
        mediaRecorder.stop();
        if (stream) { // Check if stream is defined
            stream.getTracks().forEach(track => track.stop()); // Stop the stream
        }
    }
}

function onTouchCancel() {
    clearTimeout(holdTimer);
    // If the touch is canceled (e.g., due to a swipe gesture), clear the timeout
}


button.ontouchstart = onTouchStart;
button.ontouchend = onTouchEnd;
button.ontouchcancel = onTouchCancel;




        function drawSoundWave(ctx, analyser) {
            var bufferLength = analyser.frequencyBinCount;
            var dataArray = new Uint8Array(bufferLength);

            // Draw loop
// Draw loop
function draw() {
    // Request animation frame
    requestAnimationFrame(draw);

    // Get waveform data
    analyser.getByteTimeDomainData(dataArray);

    // Clear canvas
    ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);

    // Set stroke color
    ctx.strokeStyle = '#047857'; // Set stroke color to #da116d

    // Set stroke width
    ctx.lineWidth = 0.5; // Adjust this value to make the line thinner or thicker

    // Draw sound wave
    ctx.beginPath();
    var sliceWidth = ctx.canvas.width * 1.0 / bufferLength;
    var x = 0;
    for (var i = 0; i < bufferLength; i++) {
        var v = dataArray[i] / 128.0;
        var y = v * ctx.canvas.height / 2;
        if (i === 0) {
            ctx.moveTo(x, y);
        } else {
            ctx.lineTo(x, y);
        }
        x += sliceWidth;
    }
    ctx.lineTo(ctx.canvas.width, ctx.canvas.height / 2);
    ctx.stroke();
}
            // Start drawing
            draw();
        }

        function playAudio(audioData) {

           /*document.getElementById('recordedAudio').style.display = 'block';

            // Set the src attribute of the audio element to the data URI
            document.getElementById('recordedAudio').src = 'data:audio/mp3;base64,' + audioData;
            // Play the audio
            document.getElementById('recordedAudio').play();*/


var uType = localStorage.getItem('usertype');
var lang = localStorage.getItem('lang');



if(uType == 'Gym Operator'){

var classs = 'Gym Operator';
var icon = '--account-color: green;';
var t = 'c-note--start';
var bg = 'background-color:green';

}else if(uType == 'Service Provider'){

var role = localStorage.getItem('role');

if(role == 'ticket_admin'){

var classs = 'Ticket Admin';
var icon = '--account-color: yellow;';
var t = 'c-note--end';
var bg = 'background-color:yellow; color:black;';

    }else if (role == 'engineer'){
var classs = 'Technician';
var icon = '--account-color: rgba(0,175,239,1);';
var t = 'c-note--end';
var bg = 'background-color:rgba(0,175,239,1); color:black;';
    }else if(role == 'caretaker'){

var classs = 'Internal Technician';
var icon = '--account-color: rgba(0,175,239,1);';
var t = 'c-note--end';
var bg = 'background-color:rgba(0,175,239,1); color:black;';

}else if(role == 'manufacturer'){

var classs = 'Manufacturer';
var icon = '--account-color: purple;';
var t = 'c-note--end';
var bg = 'background-color:purple; color:white;';

}else{

        var classs = 'Service Provider';
var icon = '--account-color: rgba(21,79,255,1);';
var t = 'c-note--end';
var bg = 'background-color:rgba(21,79,255,1);';

    }



}


//appending audios here
    var audio = `<div class="custom-audio-player msg">
<div class="audio_date c-note__time trn">
Now
</div>
<div class="whom c-note__title trn" style="`+bg+`">`+classs+`</div>
    <audio class="audioPlayer" src="data:audio/mp3;base64,` + audioData + `"></audio>
    <button class="playPauseBtn audio_button">
        <svg viewBox="0 0 60 60" class="icon play-icon"><polygon points="0,0 50,30 0,60"></polygon></svg>
        <svg viewBox="0 0 60 60" class="icon pause-icon" style="display: none;"><rect x="0" y="0" width="20" height="60"></rect><rect x="40" y="0" width="20" height="60"></rect></svg>
    </button>
    <div class="sound-wave" style="display: none;">
        <div class="bar"></div>
        <div class="bar"></div>
        <div class="bar"></div>
    </div>
        <button id="muteBtn" class="muteBtn">Mute</button>
    <div class="progress-bar">
        <div class="progress"></div>
    </div>
</div>`;

$(audio).insertBefore( ".gapper" );

   // Initialize the new audio player
    $('.audioPlayer').each(function() {
        initializeAudioPlayer(this);
    });


    
 var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);




            //console.log('data:audio/mp3;base64,' + audioData);

        }




});

$(document).on('click', '.updateTicketBtn', function(){ 
var uuid = localStorage.getItem('uuid');
var note = $('.wholeNote:last').val();

var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');


if(note != '' && note != 'Add Note...'){

    var pmodal = document.getElementById('preloaderModal');
pmodal.show();

//$(this).prop('disabled', true);


$.ajax({
    url: ''+host+'go-postUpdateTicket.php?email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'&note='+note+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){
        

var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

      var json = JSON.stringify(data);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);

    $('.button').prop('disabled', false);
      $('.loaderIcon').hide();


if(parsed_data['status'] == 'OK'){

//var finalNote =  '<span style="color:blue">Gym Operator: </span>'+note+'';
    

var uType = localStorage.getItem('usertype');
var lang = localStorage.getItem('lang');



if(uType == 'Gym Operator'){

var classs = 'Gym Operator';
var icon = '--account-color: green;';
var t = 'c-note--start';
var bg = 'background-color:green';

}else if(uType == 'Service Provider'){

var role = localStorage.getItem('role');

if(role == 'ticket_admin'){

var classs = 'Ticket Admin';
var icon = '--account-color: yellow;';
var t = 'c-note--end';
var bg = 'background-color:yellow; color:black;';

    }else if (role == 'engineer'){
var classs = 'Technician';
var icon = '--account-color: rgba(0,175,239,1);';
var t = 'c-note--end';
var bg = 'background-color:rgba(0,175,239,1); color:black;';
    }else if(role == 'caretaker'){

var classs = 'Internal Technician';
var icon = '--account-color: rgba(0,175,239,1);';
var t = 'c-note--end';
var bg = 'background-color:rgba(0,175,239,1); color:black;';

}else if(role == 'manufacturer'){

var classs = 'Manufacturer';
var icon = '--account-color: purple;';
var t = 'c-note--end';
var bg = 'background-color:purple; color:white;';

}else{

        var classs = 'Service Provider';
var icon = '--account-color: rgba(21,79,255,1);';
var t = 'c-note--end';
var bg = 'background-color:rgba(21,79,255,1);';

    }



}


var today = new Date();
var dd = String(today.getDate()).padStart(2, '0');
var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
var yyyy = today.getFullYear();

today = mm + '/' + dd + '/' + yyyy;


         $( '<div class="c-note '+t+'" style="'+icon+'">'+
            '<div class="c-note__header">'+
               '<p class="c-note__name"></p>'+
               '<p class="c-note__title trn" style="'+bg+'">'+classs+'</p>'+
            '</div>'+
            '<p class="c-note__message">'+note+'</p>'+
            '<time class="c-note__time trn">Now</time>'+
         '</div>' ).insertBefore( ".gapper" );
 $('.notesD').scrollTop(1000000);

 var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);

      //$('.notesD').append(finalNote);

var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};

 $('.wholeNote').val('');
}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );

        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});

}
});

$(document).on('click', '.dialog-mask', function(){ 

hideDialog('my-dialog');

});

$(document).on('click', '.sPAddNote', function(){ 

var assetSerial = localStorage.getItem('serial-inner');
var uuid = localStorage.getItem('uuid');
var note = $('.indiNote').val();



var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

$(this).prop('disabled', true);
var pmodal = document.getElementById('preloaderModal');
pmodal.show();

$.ajax({
    url: ''+host+'sp-postUpdateTicket.php?email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'&note='+note+'&assetSerial='+assetSerial+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){
              //alert(JSON.stringify(data));

              var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

      var json = JSON.stringify(data);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);

$('.button').prop('disabled', false);
$('.loaderIcon').hide();


if(parsed_data['status'] == 'OK'){


      
var uType = localStorage.getItem('usertype');

if(uType == 'Gym Operator'){



classs = 'Gym Operator';
icon = '<img class="chat_avatar" src="images/image.png" >';

}else{

classs = 'Service Provider';
icon = '<img class="chat_avatar" src="images/sp-icon.png" >';


}




var today = new Date();
var dd = String(today.getDate()).padStart(2, '0');
var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
var yyyy = today.getFullYear();

today = mm + '/' + dd + '/' + yyyy;


var noSpaceNote = note.replace(/ /g,"_");

if(uType == 'Gym Operator'){
//$('.notesD').append('<div class="box sb1"><span><img src="images/image.png" style="width:23px;" > </span> <span>'+note+'</span></div>');


$('.notesI').append('<div class="chat '+noSpaceNote+'">'+icon+
         '<div class="chat_info">'+
           '<div class="contact_name">'+classs+'</div>'+
           '<div class="contact_msg">'+note+'</div>'+
         '</div>'+
         '<div class="chat_status">'+
           '<div class="chat_date">Now</div>'+
           '<div class="chat_new grad_pb"> New </div>'+
         '</div>'+
      '</div>');



}else{



$('.notesI').append('<div class="chat '+noSpaceNote+'">'+icon+
         '<div class="chat_info">'+
           '<div class="contact_name">'+classs+'</div>'+
           '<div class="contact_msg">'+note+'</div>'+
         '</div>'+
         '<div class="chat_status">'+
           '<div class="chat_date">Now</div>'+
           '<div class="chat_new grad_pb"> New </div>'+
         '</div>'+
      '</div>');


//$('.notesD').append('<div class="box2 sb2"><span><img src="images/sp-icon.png" style="width:23px;" > </span> <span>'+note+'</span></div>');
}



 $('.notesI').scrollTop(1000000);


      //$('.notesD').append(finalNote);

var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};

var notify = function() {
  //ons.notification.alert('You have successfully added a note.');
   ons.notification.toast('You have successfully added a note.', { timeout: 1500, animation: 'fall' });
};

notify();


hideDialog('my-dialog');
$('.indiNote').val('');

}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );

        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});

});


$(document).on('click', '.closeTicketBtn', function(){
    
    var uType = localStorage.getItem('usertype');

    

    if(uType == 'Gym Operators'){


    }else{



var uuid = $(this).attr('data-id');
var partsReq = "0";

localStorage.setItem('uuid-close', uuid);

var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');
var cost = 0;


var lang = localStorage.getItem('lang');

 

var msg, title, yesBtn, cancelBtn;

if (lang == 'ge') {
    msg = 'Möchten Sie dieses Ticket schließen?';
    title = 'Achtung';
    yesBtn = 'OK';
    cancelBtn = 'Abbrechen';
} else if (lang == 'po') {
    msg = 'Deseja fechar este ticket?';
    title = 'Atenção';
    yesBtn = 'Sim';
    cancelBtn = 'Cancelar';
} else if (lang == 'sp') {
    msg = '¿Desea cerrar este ticket?';
    title = 'Atención';
    yesBtn = 'Sí';
    cancelBtn = 'Cancelar';
} else if (lang == 'bul') {
    msg = 'Искате ли да затворите този билет?';
    title = 'Внимание';
    yesBtn = 'Да';
    cancelBtn = 'Отказ';
} else if (lang == 'it') {
    msg = 'Vuoi chiudere questo ticket?';
    title = 'Attenzione';
    yesBtn = 'Sì';
    cancelBtn = 'Annulla';
} else if (lang == 'fr') {
    msg = 'Voulez-vous fermer ce ticket ?';
    title = 'Attention';
    yesBtn = 'Oui';
    cancelBtn = 'Annuler';
} else if (lang == 'ar') {
    msg = 'هل تريد إغلاق هذه التذكرة؟';
    title = 'انتباه';
    yesBtn = 'نعم';
    cancelBtn = 'إلغاء';
} else if (lang == 'ja') {
msg = 'このチケットを閉じますか？';
title = '注意';
yesBtn = 'はい';
cancelBtn = 'キャンセル';
}else if (lang == 'tu') {
msg = 'Bu bilet kapatılsın mı?';
title = 'Dikkat';
yesBtn = 'Evet';
cancelBtn = 'İptal';
}  else {
    // Default to the original text if the language code is not recognized
    msg = 'Do you want to close this ticket?';
    title = 'Attention';
    yesBtn = 'Yes';
    cancelBtn = 'Cancel';
}

navigator.notification.confirm(
    msg, // message
     onConfirm,            // callback to invoke with index of button pressed
    title,           // title
    [cancelBtn, yesBtn]     // buttonLabels
);


function onConfirm(buttonIndex) {

    

         if(buttonIndex === 2){
//come back here
         //document.querySelector('#myNavigator').pushPage('questioner.html');

 cost = 0;

function containsOnlyNumbers(str) {
  return /^\d+\.\d+$|^\d+$/.test(str);
}


var c = containsOnlyNumbers(cost);

 if(c != true){

      

//check for cost value


var lang = localStorage.getItem('lang');



function alertDismissed() {
    // Do something if needed
}

if (lang == 'ge') {
    navigator.notification.alert(
        'Die Kosten dürfen nicht leer sein oder alphabetische Werte haben.',  // message
        alertDismissed,         // callback
        'Benachrichtigung',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'po') {
    navigator.notification.alert(
        'O custo não pode estar vazio ou ter valores alfabéticos.', // message
        alertDismissed,            // callback to invoke with the index of the button pressed
        'Notificação',           // title
        'OK'     // buttonLabels
    );
} else if (lang == 'sp') {
    navigator.notification.alert(
        'El costo no puede estar vacío ni tener valores alfabéticos.', // message
        alertDismissed,            // callback to invoke with the index of the button pressed
        'Notificación',           // title
        'OK'     // buttonLabels
    );
} else if (lang == 'bul') {
    navigator.notification.alert(
        'Разходите не могат да бъдат празни или да имат азбучни стойности.', // message
        alertDismissed,            // callback to invoke with the index of the button pressed
        'Известие',           // title
        'OK'     // buttonLabels
    );
} else if (lang == 'it') {
    navigator.notification.alert(
        'Il costo non può essere vuoto o avere valori alfabetici.', // message
        alertDismissed,            // callback to invoke with the index of the button pressed
        'Notifica',           // title
        'OK'     // buttonLabels
    );
} else if (lang == 'fr') {
    navigator.notification.alert(
        'Le coût ne peut pas être vide ou avoir des valeurs alphabétiques.', // message
        alertDismissed,            // callback to invoke with the index of the button pressed
        'Notification',           // title
        'OK'     // buttonLabels
    );
} else if (lang == 'ar') {
    navigator.notification.alert(
        'لا يمكن أن يكون التكلفة فارغة أو أن تحتوي على قيم أبجدية', // message
        alertDismissed,            // callback to invoke with the index of the button pressed
        'إشعار',           // title
        'حسنا'     // buttonLabels
    );
} else if (lang == 'ja') {
navigator.notification.alert(
    'コストは空白またはアルファベットの値にすることはできません', // メッセージ
    alertDismissed, // ボタンが押されたときに呼び出すコールバック
    '通知', // タイトル
    'OK' // ボタンのラベル
);
}else if (lang == 'tu') {
navigator.notification.alert(
    'Maliyet boş veya alfabetik bir değer olamaz', // Mesaj
    alertDismissed, // Butona basıldığında çağrılacak geri çağırma fonksiyonu
    'Bildirim', // Başlık
    'Tamam' // Buton etiketi
);

}else {
    // Default to the original text if the language code is not recognized
    navigator.notification.alert(
        'The Cost cannot be empty or have alphabetical values.', // message
        alertDismissed,            // callback to invoke with the index of the button pressed
        'Notification',           // title
        'OK'     // buttonLabels
    );
}



 }else{
     

var des = JSON.stringify(descriptions);
var ser = localStorage.getItem('cur_ser');


$.ajax({
    //url: ''+host+'closeTicket.php?email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'&partsReq='+partsReq+'&serial_numbers='+ser+'&descriptions='+des+'&sla='+JSON.stringify(results)+'&output=',
    url: ''+host+'...closeTicket.php?email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'&partsReq='+partsReq+'&serial_numbers='+ser+'&descriptions='+des+'&sla='+JSON.stringify(results)+'&output=',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

       

var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
             console.log(data);

      var json = JSON.stringify(data);


     console.log(json);
      //return false;

      

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);

$('.button').prop('disabled', false);
$('.loaderIcon').hide();


if(parsed_data['status'] == 'OK'){


$('.note').val('');


var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};

var notify = function() {
  //ons.notification.alert('You have successfully closed this ticket.');
  var lang = localStorage.getItem('lang');


if (lang == 'ge') {
    ons.notification.toast('Sie haben dieses Ticket erfolgreich geschlossen.', { timeout: 3000, animation: 'fall' });
} else if (lang == 'po') {
    ons.notification.toast('Você fechou este ticket com sucesso.', { timeout: 3000, animation: 'fall' });
} else if (lang == 'sp') {
    ons.notification.toast('Has cerrado este ticket con éxito.', { timeout: 3000, animation: 'fall' });
} else if (lang == 'bul') {
    ons.notification.toast('Успешно затворихте този билет.', { timeout: 3000, animation: 'fall' });
} else if (lang == 'it') {
    ons.notification.toast('Hai chiuso con successo questo ticket.', { timeout: 3000, animation: 'fall' });
} else if (lang == 'fr') {
    ons.notification.toast('Vous avez fermé ce ticket avec succès.', { timeout: 3000, animation: 'fall' });
}else if (lang == 'ar') {
    ons.notification.toast('لقد أغلقت هذه التذكرة بنجاح', { timeout: 3000, animation: 'fall' });
}else if (lang == 'ja') {
    ons.notification.toast('チケットを正常に閉じました', { timeout: 3000, animation: 'fall' });
}else if (lang == 'tu') {
   ons.notification.toast('Bilet başarıyla kapatıldı', { timeout: 3000, animation: 'fall' });

}  else {
    // Default to the original text if the language code is not recognized
    ons.notification.toast('You have successfully closed this ticket.', { timeout: 3000, animation: 'fall' });
}
};

notify();


//document.querySelector('#myNavigator').pages[3].remove();
document.querySelector('#myNavigator').popPage();


}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});

      }

}

}


//comeback here

//showcostTemplateDialog();


}

});


$(document).on('click', '.deleted', function(e){ 

e.stopPropagation();

var lang = localStorage.getItem('lang');


function alertDismissed() {
    // Do something if needed
}

if (lang == 'ge') {
    navigator.notification.alert(
        'Dieses Asset wird gelöscht und kann daher nicht bearbeitet werden.',  // message
        alertDismissed,         // callback
        'Benachrichtigung',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'po') {
    navigator.notification.alert(
        'Este ativo está sendo excluído e, portanto, não pode ser editado.',  // message
        alertDismissed,         // callback
        'Notificação',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'sp') {
    navigator.notification.alert(
        'Este activo se está eliminando y, por lo tanto, no se puede editar.',  // message
        alertDismissed,         // callback
        'Notificación',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'bul') {
    navigator.notification.alert(
        'Този актив се изтрива и поради това не може да бъде редактиран.',  // message
        alertDismissed,         // callback
        'Известие',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'it') {
    navigator.notification.alert(
        'Questo asset viene eliminato e quindi non può essere modificato.',  // message
        alertDismissed,         // callback
        'Notifica',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'fr') {
    navigator.notification.alert(
        'Cet actif est en cours de suppression et ne peut donc pas être modifié.',  // message
        alertDismissed,         // callback
        'Notification',            // title
        'OK'                  // buttonName
    );
}else if (lang == 'ar') {
    navigator.notification.alert(
        'هذا الأصل قيد الحذف ولذلك لا يمكن تعديله',  // message
        alertDismissed,         // callback
        'إشعار',            // title
        'موافق'                  // buttonName
    );
}else if (lang == 'ja') {
navigator.notification.alert(
    'この資産は削除されているため、編集できません',  // メッセージ
    alertDismissed,         // コールバック
    'お知らせ',            // タイトル
    '了解'                  // ボタン名
);
}else if (lang == 'tu') {
navigator.notification.alert(
    'Bu varlık silindiği için düzenlenemez',  // Mesaj
    alertDismissed,         // Geri çağırma
    'Bilgi',            // Başlık
    'Tamam'                  // Düğme Adı
);
}  else {
    // Default to the original text if the language code is not recognized
    navigator.notification.alert(
        'This asset is being deleted and therefore it cannot be edited.',  // message
        alertDismissed,         // callback
        'Notification',            // title
        'OK'                  // buttonName
    );
}



});



$(document).on('click', '.removeWithCost', function(e){ 

comps++;

var uuid = removeWithOdometerID;
var serial = removeWithOdometerSerial;
var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');
var odometerCost = $('.odometerCostC').val();

if(odometerCost ==""){

var lang = localStorage.getItem('lang');



function alertDismissed() {
    // Do something if needed
}

if (lang == 'ge') {
    navigator.notification.alert(
        'Bitte geben Sie die Kosten für die Reparatur/Service-Anlage ein!',  // message
        alertDismissed,         // callback
        'WICHTIG',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'po') {
    navigator.notification.alert(
        'Por favor, insira o custo para reparo/serviço do ativo!',  // message
        alertDismissed,         // callback
        'IMPORTANTE',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'sp') {
    navigator.notification.alert(
        '¡Por favor, ingrese el costo para reparar/servir el activo!',  // message
        alertDismissed,         // callback
        'IMPORTANTE',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'bul') {
    navigator.notification.alert(
        'Моля, въведете разходите за ремонт/сервиз на актива!',  // message
        alertDismissed,         // callback
        'ВАЖНО',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'it') {
    navigator.notification.alert(
        'Inserisci il costo per riparare/servire l\'asset!',  // message
        alertDismissed,         // callback
        'IMPORTANTE',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'fr') {
    navigator.notification.alert(
        'Veuillez entrer le coût pour réparer/servir l\'actif !',  // message
        alertDismissed,         // callback
        'IMPORTANT',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'ar') {
    navigator.notification.alert(
        'من فضلك، أدخل تكلفة إصلاح/خدمة الأصل',  // message
        alertDismissed,         // callback
        'مهم',            // title
        'موافق'                  // buttonName
    );
}else if (lang == 'ja') {
navigator.notification.alert(
    '修理/サービスの費用を入力してください',  // メッセージ
    alertDismissed,         // コールバック
    '重要',            // タイトル
    '了解'                  // ボタン名
);
}else if (lang == 'tu') {
navigator.notification.alert(
    'Tamir/Hizmet maliyetini girin',  // Mesaj
    alertDismissed,         // Geri çağırma
    'Önemli',            // Başlık
    'Tamam'                  // Düğme Adı
);

}else {
    // Default to the original text if the language code is not recognized
    navigator.notification.alert(
        'Please Enter Cost to Repair/Service Asset!',  // message
        alertDismissed,         // callback
        'IMPORTANT',            // title
        'OK'                  // buttonName
    );
}


}else{

    var pmodal = document.getElementById('preloaderModal');
pmodal.show();

$.ajax({
    url: ''+host+'closeAsset-without-odometer.php?odometerCost='+odometerCost+'&email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'&serial='+serial+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){
             console.log(JSON.stringify(data));

             var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

      var json = JSON.stringify(data);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);

$('.button').prop('disabled', false);
$('.loaderIcon').hide();


if(parsed_data['status'] == 'OK'){
  document
    .getElementById('my-alert-dialog2')
    .hide();
    howMany = howMany-1;

$('.odometerCostC').val('');


var notify = function() {

  ons.notification.toast('You have successfully marked this asset as complete.', { timeout: 3000, animation: 'fall' });
};

notify();

//}



remoerClicked.removeClass('remover');
remoerClicked.addClass('removed');
remoerClicked.html("Marked As Complete <br><ons-icon icon='fa-check-circle' size='20px'></ons-icon>");

}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );

        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});


}



});





$(document).on('click', '.removeWithOdometer', function(e){ 

comps++;

var uuid = removeWithOdometerID;
var serial = removeWithOdometerSerial;
var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');
var odometer = $('.odometer').val();
var odometerCost = $('.odometerCost').val();

if(odometerCost ==""){


var lang = localStorage.getItem('lang');


function alertDismissed() {
    // Do something if needed
}

if (lang == 'ge') {
    navigator.notification.alert(
        'Bitte füllen Sie alle erforderlichen Felder aus.',  // message
        alertDismissed,         // callback
        'WICHTIG',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'po') {
    navigator.notification.alert(
        'Por favor, preencha todos os campos obrigatórios.',  // message
        alertDismissed,         // callback
        'IMPORTANTE',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'sp') {
    navigator.notification.alert(
        'Por favor, complete todos los campos obligatorios.',  // message
        alertDismissed,         // callback
        'IMPORTANTE',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'bul') {
    navigator.notification.alert(
        'Моля, попълнете всички задължителни полета.',  // message
        alertDismissed,         // callback
        'ВАЖНО',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'it') {
    navigator.notification.alert(
        'Si prega di compilare tutti i campi obbligatori.',  // message
        alertDismissed,         // callback
        'IMPORTANTE',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'fr') {
    navigator.notification.alert(
        'Veuillez remplir tous les champs obligatoires.',  // message
        alertDismissed,         // callback
        'IMPORTANT',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'ar') {
    navigator.notification.alert(
        'يرجى ملء جميع الحقول المطلوبة',  // message
        alertDismissed,         // callback
        'مهم',            // title
        'موافق'                  // buttonName
    );
} else if (lang == 'ja') {
navigator.notification.alert(
    'すべての必須フィールドを入力してください',  // メッセージ
    alertDismissed,         // コールバック
    '重要',            // タイトル
    '了解'                  // ボタン名
);
}else if (lang == 'tu') {
navigator.notification.alert(
    'Tüm zorunlu alanları doldurun',  // Mesaj
    alertDismissed,         // Geri çağırma
    'Önemli',            // Başlık
    'Tamam'                  // Düğme Adı
);
}else {
    // Default to the original text if the language code is not recognized
    navigator.notification.alert(
        'Please enter all the required fields.',  // message
        alertDismissed,         // callback
        'Attention',            // title
        'OK'                  // buttonName
    );
}

}else{


var pmodal = document.getElementById('preloaderModal');
pmodal.show();
$.ajax({
    url: ''+host+'closeAsset.php?odometerCost='+odometerCost+'&odometer='+odometer+'&email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'&serial='+serial+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){
             console.log(JSON.stringify(data));

      var json = JSON.stringify(data);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);

$('.button').prop('disabled', false);
$('.loaderIcon').hide();


if(parsed_data['status'] == 'OK'){
hideAlertDialog();
    howMany = howMany-1;

$('.odometer').val('');
$('.odometerCost').val('');


var notify = function() {

  ons.notification.toast('You have successfully marked this asset as complete.', { timeout: 3000, animation: 'fall' });
};

var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

notify();

remoerClicked.removeClass('remover');
remoerClicked.addClass('removed');
remoerClicked.html("Marked As Complete <br><ons-icon icon='fa-check-circle' size='20px'></ons-icon>");

}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});


}



});

$(document).on('click', '.remover', function(e){ 

comps++;

var th = $(this);
remoerClicked = th;
var uuid = $(this).attr('data-id');
var has_odometer = $(this).attr('data-hasodometer');
var serial = $(this).attr('data-serial');
var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

removeWithOdometerID = uuid;
removeWithOdometerSerial = serial;


$(this).prop('disabled', true);
$('.loaderIcon').show();

var pmodal = document.getElementById('preloaderModal');
pmodal.show();

if(has_odometer == 1){

    var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

var createAlertDialog = function() {
  var dialog = document.getElementById('my-alert-dialog');

  if (dialog) {
    dialog.show();
  } else {
    ons.createElement('alert-dialog-odometer.html', { append: true })
      .then(function(dialog) {
        dialog.show();
      });
  }
};


var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};

createAlertDialog();

}else{



var createAlertDialog = function() {
  var dialog = document.getElementById('my-alert-dialog2');

  if (dialog) {
    dialog.show();
  } else {
    ons.createElement('alert-dialog-odometer2.html', { append: true })
      .then(function(dialog) {
        dialog.show();
      });
  }
};


var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog2')
    .hide();
};

createAlertDialog();


var pmodal = document.getElementById('preloaderModal');
pmodal.hide();



}






e.stopPropagation();



});

$(document).on('click', '.sPAddNote2', function(e){ 


var note = $('.indiNote2').val();
var serialNo = localStorage.getItem('addAsset-serial');


    serial_numbers.push(serialNo);
    descriptions.push(note);


    hideDialog('my-dialog2');

    console.log(serial_numbers);
    console.log(descriptions);

    
$('.indiNote2').val('');

});


$(document).on('click', '.myswitch', function(e){ 


  var checked = this.checked;
  var serialNo = $(this).val();



if (checked.toString() == 'false'){

    

localStorage.setItem('addAsset-serial', serialNo);
//showTemplateDialog2();

  }else{

var index = serial_numbers.indexOf(serialNo);
serial_numbers.splice(index, 1);
descriptions.splice(index, 1);

console.log(serial_numbers);
console.log(descriptions);


  }



});


    var app = {};

ons.ready(function () {
  ons.createElement('action-sheet.html', { append: true })
    .then(function (sheet) {
      app.showFromTemplate = sheet.show.bind(sheet);
      app.hideFromTemplate = sheet.hide.bind(sheet);
    });
});



$(document).on('click', '.addImgsBtn', function(e){ 
app.showFromTemplate();
$('#ticket-details').removeClass('backgroundBlur');
var modal = document.getElementById('ScrollingImagesModal');
modal.hide({animation: 'lift'});
});






$(document).on('click', '.sendImgBtn', function(){ 


var uuid = localStorage.getItem('uuid');
var imgTosend = localStorage.getItem('imgToSend');
var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

var serial = localStorage.getItem('serial-inner');
//base64 = "data:image/jpeg;base64,"+imageData+"";

console.log(imgTosend);



var values = {
            'serial': serial,
            'img': imgTosend,
            'email': email,
            'accesstoken': accesstoken,
            'uuid': uuid,
            'ticketType': localStorage.getItem('ticketType')
    };


var pmodal = document.getElementById('preloaderModal');
pmodal.show();

$.ajax({
    url: ''+host+'go-postUpdateTicketsendimg-new.php',
    //dataType: 'text',
    data: values,
    type: 'POST',
    success: function(data){

   
var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
//$('.viewport').append('<div class="addedImg"><img src="'+imgTosend+'"></div>');
$('.imghistory').append('<div class="grid__photo addedImg"><img src="'+imgTosend+'"></div>');

var notify = function() {
  //ons.notification.alert('You have successfully added a note.');
  var lang = localStorage.getItem('lang');


if (lang == 'ge') {
    ons.notification.toast('Sie haben erfolgreich ein Bild hinzugefügt.', { timeout: 3000, animation: 'fall' });
} else if (lang == 'po') {
    ons.notification.toast('Você adicionou com sucesso uma imagem.', { timeout: 3000, animation: 'fall' });
} else if (lang == 'sp') {
    ons.notification.toast('Has añadido con éxito una imagen.', { timeout: 3000, animation: 'fall' });
} else if (lang == 'bul') {
    ons.notification.toast('Успешно добавихте изображение.', { timeout: 3000, animation: 'fall' });
} else if (lang == 'it') {
    ons.notification.toast('Hai aggiunto con successo un\'immagine.', { timeout: 3000, animation: 'fall' });
} else if (lang == 'fr') {
    ons.notification.toast('Vous avez ajouté avec succès une image.', { timeout: 3000, animation: 'fall' });
} else if (lang == 'ar') {
    ons.notification.toast('تمت إضافة الصورة بنجاح', { timeout: 3000, animation: 'fall' });
}else if (lang == 'ja') {
ons.notification.toast('画像が正常に追加されました', { timeout: 3000, animation: 'fall' });
}else if (lang == 'tu') {
ons.notification.toast('Resim başarıyla eklendi', { timeout: 3000, animation: 'fall' });

}else {
    // Default to the original text if the language code is not recognized
    ons.notification.toast('You have successfully added an image.', { timeout: 3000, animation: 'fall' });
}
};

notify();


var modal = document.getElementById('ConfirmImageModal');
modal.hide();



    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});


});

$(document).on('click', '.showScrollingImgBtn', function(){ 

var modal = document.getElementById('ScrollingImagesModal');
modal.show({animation: 'lift'});

$('#ticket-asset-details').addClass('backgroundBlur');
$('#ticket-details').addClass('backgroundBlur');
});


//maggots


$(document).on('click', '.addedImg img', function() {
    const img = this; // The clicked image
    let backdrop = $('#backdrop');
    
    // Check if the backdrop already exists, if not, create it
    if (backdrop.length === 0) {
        backdrop = $('<div class="backdropEnlargedImage" id="backdrop" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); justify-content: center; align-items: center; z-index: 10; overflow: hidden;"></div>');
        $('body').append(backdrop);
    }

    let enlargedImg = $('#enlargedImage');
    
    // Check if the enlarged image already exists, if not, create it
    if (enlargedImg.length === 0) {
        enlargedImg = $('<img id="enlargedImage" style="max-width:100%;max-height:100%;position: absolute; transition: transform 0.25s ease, left 0.25s ease, top 0.25s ease, width 0.25s ease, height 0.25s ease;"></img>');

        backdrop.append(enlargedImg);
        $('body').append('<ons-icon class="arrowDowEnlargedimage" icon="fa-close"></ons-icon>');
    }

    const rect = img.getBoundingClientRect();
    enlargedImg.attr('src', img.src);
    
    enlargedImg.css({
        width: `${rect.width}px`,
        height: `${rect.height}px`,
        left: `${rect.left}px`,
        top: `${rect.top}px`,
        position: 'fixed',
        transform: 'none' // Reset any previous transformation
    });

    backdrop.show();

    setTimeout(() => {
        enlargedImg.css({
            width: '100%',
            height: '100%',
            left: '0',
            top: '0',
            //transform: 'translate(-50%, -50%)' // Center the image
        });
    }, 10); // Small delay to ensure the transition is visible

    // Handle clicks on the close button
    backdrop.off('click').on('click', '.arrowDowEnlargedimage', function(e) {
        e.stopPropagation(); // Prevent propagation to avoid interference with other click handlers
        
        backdrop.hide(); // Hide the backdrop
        enlargedImg.remove(); // Optionally remove the enlarged image
    });

    // Pinch and zoom functionality can be added here

    // Touch event handling for swipe gestures
    let startY = 0;
    let moveY = 0;
    let isSwiping = false;

    backdrop.on('touchstart', function(e) {
        startY = e.originalEvent.touches[0].pageY;
        isSwiping = true;
        // Prevent scrolling the background
        e.preventDefault();
    });

    backdrop.on('touchmove', function(e) {
        if (!isSwiping) return;
        moveY = e.originalEvent.touches[0].pageY - startY;

        if (moveY > 0) { // Downward swipe
            backdrop.css('transform', `translateY(${moveY}px)`);
        }
    });

    backdrop.on('touchend', function() {
        isSwiping = false;
        if (moveY > 150) { // Threshold for closing
            enlargedImg.remove(); // Remove the popup from the DOM
            backdrop.remove();
            $('.arrowDowEnlargedimage').remove();
        } else {
            backdrop.css('transform', 'translateY(0)'); // Reset position
        }
    });
});



$(document).on('click', '.arrowDowEnlargedimage', function(){ 

$('.backdropEnlargedImage').remove();
$(this).remove();

});


$(document).on('click', '.largeImg', function(){ 

$('.largeImg').remove();

});



$(document).on('change', '.addressList', function(){ 


    var loc = $(this).val();

    if(loc == 'Site Name'){
$('.tickets').show();
$('.openTitles').text('Open Tickets');
    }else{
        $('.openTitles').text('Address > ('+loc+')');
$('.tickets').hide();
$('.tickets').filter('[data-address="'+loc+'"]').show();
$('.tickets[data-address="'+loc+'"]').show();
    }

});

$(document).on('change', '.descriptionList', function(){ 


    var loc = $(this).val();

    if(loc == 'Description'){
$('.tickets').show();
$('.openTitles').text('Open Tickets');
    }else{
        $('.openTitles').text('Description > ('+loc+')');
$('.tickets').hide();
$('.tickets').filter('[data-des="'+loc+'"]').show();
$('.tickets[data-des="'+loc+'"]').show();
    }

});



document.addEventListener("pause", onPause, false);

function onPause() {
    // Handle the pause event
}


document.addEventListener("resume", onResume, false);

function onResume() {

}


$(document).on('click', '.leaveDetailsPage', function(e){ 

 var uType = localStorage.getItem('usertype');

 if(viewing == 'closedTicket'){

     //document.querySelector('#myNavigator').popPage();

 }else{

if (howMany == 0 && uType != 'Gym Operator'){

var lang = localStorage.getItem('lang');

//document.querySelector('#myNavigator').popPage();

}else{

//document.querySelector('#myNavigator').popPage();

}

 }

});


$(document).on('click', '.spSelectBtn', function(e){ 

var title = $(this).attr('data-title');
var serial = $(this).attr('data-serial');
var company = $(this).attr('data-company');

//var modal = document.getElementById('spSelect');
//modal.hide({animation: 'lift'});

console.log(JSON.stringify(asset_sps));

/*const index2 = asset_sps.indexOf(serial);
if (index2 > -1) {
  asset_sps.splice(index2, 1);
}*/

asset_sps.push(title);


console.log(JSON.stringify(asset_sps));


setTimeout(doSomething, 500);

function doSomething() {


var lang = localStorage.getItem('lang');

function alertDismissed() {
    // Do something if needed
}


if (lang == 'ge') {
    navigator.notification.alert(
        'Sie haben den Dienstanbieter (' + title + ' ' + company + ') für dieses Asset ausgewählt.',  // message
        alertDismissed,         // callback
        'Achtung',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'po') {
    navigator.notification.alert(
        'Você selecionou o provedor de serviços (' + title + ' ' + company + ') para este ativo.',  // message
        alertDismissed,         // callback
        'Atenção',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'sp') {
    navigator.notification.alert(
        'Ha seleccionado al proveedor de servicios (' + title + ' ' + company + ') para este activo.',  // message
        alertDismissed,         // callback
        'Atención',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'bul') {
    navigator.notification.alert(
        'Избрахте доставчика на услуги (' + title + ' ' + company + ') за този актив.',  // message
        alertDismissed,         // callback
        'Внимание',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'it') {
    navigator.notification.alert(
        'Hai selezionato il fornitore di servizi (' + title + ' ' + company + ') per questo asset.',  // message
        alertDismissed,         // callback
        'Attenzione',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'fr') {
    navigator.notification.alert(
        'Vous avez sélectionné le fournisseur de services (' + title + ' ' + company + ') pour cet actif.',  // message
        alertDismissed,         // callback
        'Attention',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'ar') {
    navigator.notification.alert(
        'لقد اخترت مزود الخدمات (' + title + ' ' + company + ') لهذا العنصر',  // message
        alertDismissed,         // callback
        'تنبيه',            // title
        'موافق'                  // buttonName
    );
}else if (lang == 'ja') {
navigator.notification.alert(
    'このアイテムのサービスプロバイダー（' + title + ' ' + company + '）を選択しました', // message
    alertDismissed,         // callback
    '警告',            // title
    '了解'                  // buttonName
);
}else if (lang == 'tu') {
navigator.notification.alert(
    'Bu öğenin hizmet sağlayıcısı (' + title + ' ' + company + ') seçildi', // mesaj
    alertDismissed,         // geriçağırma
    'Uyarı',            // başlık
    'Anladım'                  // düğmeAdı
);

}else {
    // Default to the original text if the language code is not recognized
    navigator.notification.alert(
        'You have selected (' + title + ' ' + company + ') service provider for this asset.',  // message
        alertDismissed,         // callback
        'Attention',            // title
        'OK'                  // buttonName
    );
}

}
});


$(document).on('click', '.cancelAddAsset', function(e){ 

$('.catiSel').removeClass('tinted');
$('.proceedbtns').hide();
document.querySelector('#myNavigator').popPage();

setTimeout(doSomething, 500);

function doSomething() {
var modal = document.getElementById('assetmodal'); 
modal.hide({animation: 'lift'});


//$('.spgoholder').hide();
 $('.whoSend').eq(0).removeClass('animated slideOutLeft');
$('.whoSend').eq(1).removeClass('animated slideOutRight');
$('.whoSend').eq(0).addClass('animated slideInLeft');
$('.whoSend').eq(1).addClass('animated slideInRight');
 //$('.btnsHolder').show();
}
});


$(document).on('click', '.addAssetToTicket', function(e){ 

document.querySelector('#myNavigator').pushPage('edit.html');


});



    function callQRscanner2(){

var lang = localStorage.getItem('lang');

if (lang == 'ge') {
    notdetected = 'QR-Code nicht erkannt';
} else if (lang == 'po') {
    notdetected = 'Código QR não detectado';
} else if (lang == 'sp') {
    notdetected = 'Código QR no detectado';
} else if (lang == 'bul') {
    notdetected = 'QR-кодът не беше разпознат';
} else if (lang == 'it') {
    notdetected = 'Codice QR non rilevato';
} else if (lang == 'fr') {
    notdetected = 'Code QR non détecté';
} else if (lang == 'ar') {
    notdetected = 'الرمز الشريطي QR غير مُعترف به';
} else if (lang == 'ja') {
   notdetected = 'QRコードが認識されませんでした';
}else if (lang == 'tu') {
   notdetected = 'QR kodu algılanamadı';

}else {
    // Default to the original text if the language code is not recognized
    notdetected = 'QR-Code not detected';
}
     

//SpinnerDialog.show(null, "Please wait...");
cordova.plugins.mlkit.barcodeScanner.scan(
  barCodeOptions,
  (result) => {


var serial = result.text;



//SpinnerDialog.hide();


const includesTwenty = current_appendable_assets.includes(serial);

console.log(JSON.stringify(current_appendable_assets));
if(includesTwenty == true || current_appendable_assets.length === 0){


var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

//$(this).prop('disabled', true);
//$('.loaderIcon').show();


console.log(serial);

$.ajax({
    url: ''+host+'getAsset.php?serial='+serial+'&email='+email+'&accesstoken='+accesstoken+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

    var json = JSON.stringify(data);

     //var obj = parseJSON(data);
  var parsed_data = JSON.parse(data);

  var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

if(parsed_data['status'] == 'OK'){

  $('.note').val('');

var serial = parsed_data.asset['serial_number'];

var active_seller_packages = parsed_data.asset['active_seller_packages'];

console.log(JSON.stringify(parsed_data.asset['active_seller_packages']));

count = _.countBy(active_seller_packages, obj => obj.lot_title !== '');


if(count.true > 1){




var lang = localStorage.getItem('lang');


function alertDismissed() {
    // Do something if needed
}

if (lang == 'ge') {
    navigator.notification.alert(
        'Bitte erstellen Sie ein neues Ticket für dieses Asset!',  // message
        alertDismissed,         // callback
        'Achtung',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'po') {
    navigator.notification.alert(
        'Por favor, crie um novo chamado para este ativo!',  // message
        alertDismissed,         // callback
        'Atenção',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'sp') {
    navigator.notification.alert(
        'Por favor, cree un nuevo ticket para este activo.',  // message
        alertDismissed,         // callback
        'Atención',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'bul') {
    navigator.notification.alert(
        'Моля, създайте нов билет за този актив!',  // message
        alertDismissed,         // callback
        'Внимание',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'it') {
    navigator.notification.alert(
        'Si prega di creare un nuovo ticket per questo asset!',  // message
        alertDismissed,         // callback
        'Attenzione',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'fr') {
    navigator.notification.alert(
        'Veuillez créer un nouveau ticket pour cet actif !',  // message
        alertDismissed,         // callback
        'Attention',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'ar') {
    navigator.notification.alert(
        'رجى إنشاء تذكرة جديدة لهذا العنصر',  // message
        alertDismissed,         // callback
        'تنبيه',            // title
        'موافق'                  // buttonName
    );
}else if (lang == 'ja') {
navigator.notification.alert(
    'このアイテムの新しいチケットを作成してください',  // message
    alertDismissed,         // callback
    '警告',            // title
    'OK'                  // buttonName
);
}else if (lang == 'tu') {
navigator.notification.alert(
    'Bu öğe için yeni bir bilet oluşturun',  // mesaj
    alertDismissed,         // geriçağırma
    'Uyarı',            // başlık
    'OK'                  // düğmeAdı
);

}else {
    // Default to the original text if the language code is not recognized
    navigator.notification.alert(
        'Please create a new ticket for this asset!',  // message
        alertDismissed,         // callback
        'Attention',            // title
        'OK'                  // buttonName
    );
}


}else{

localStorage.setItem('moreSp', 'no');

}


if(count.true > 1){

}else{



$('.addAassetBtn').attr('data-serial', serial);


var max_spend_percentage = parsed_data.asset['max_spend_percentage'];

if (max_spend_percentage > 100){


var lang = localStorage.getItem('lang');


function alertDismissed() {
    // Do something if needed
}

if (lang == 'ge') {
    navigator.notification.alert(
        'Das maximale Ausgabenbudget für Asset ' + serial + ' wurde erreicht. Bitte erhöhen Sie das maximale Ausgabenlimit für diesen Vermögenswert.',  // message
        alertDismissed,         // callback
        'Achtung',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'po') {
    navigator.notification.alert(
        'O orçamento máximo de gastos para o ativo ' + serial + ' foi atingido. Por favor, aumente o limite máximo de gastos para este ativo.',  // message
        alertDismissed,         // callback
        'Atenção',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'sp') {
    navigator.notification.alert(
        'Se ha alcanzado el presupuesto máximo de gastos para el activo ' + serial + '. Por favor, aumente el límite máximo de gastos para este activo.',  // message
        alertDismissed,         // callback
        'Atención',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'bul') {
    navigator.notification.alert(
        'Максималният бюджет за разходи за актива ' + serial + ' е достигнат. Моля, увеличете максималния лимит за разходи за този актив.',  // message
        alertDismissed,         // callback
        'Внимание',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'it') {
    navigator.notification.alert(
        'Il budget massimo di spesa per l\'asset ' + serial + ' è stato raggiunto. Si prega di aumentare il limite massimo di spesa per questo asset.',  // message
        alertDismissed,         // callback
        'Attenzione',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'fr') {
    navigator.notification.alert(
        'Le budget maximum de dépenses pour l\'actif ' + serial + ' a été atteint. Veuillez augmenter la limite maximale de dépenses pour cet actif.',  // message
        alertDismissed,         // callback
        'Attention',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'ar') {
    navigator.notification.alert(
        'تم الوصول إلى الحد الأقصى للميزانية المخصصة للنفقات للعنصر ' + serial + '. يرجى زيادة الحد الأقصى للنفقات لهذا العنصر',  // message
        alertDismissed,         // callback
        'تنبيه',            // title
        'موافق'                  // buttonName
    );
}else if (lang == 'ja') {
navigator.notification.alert(
    'アイテム ' + serial + ' の支出の予算限度額に達しました。このアイテムの予算限度額を増やしてください',  // message
    alertDismissed,         // callback
    '警告',            // title
    'OK'                  // buttonName
);
}else if (lang == 'tu') {
navigator.notification.alert(
    'Öğe ' + serial + ' için harcama bütçe limitine ulaşıldı. Bu öğenin bütçe limitini artırın lütfen.',  // mesaj
    alertDismissed,         // geriçağırma
    'Uyarı',            // başlık
    'Tamam'                  // düğmeAdı
);

}else {
    // Default to the original text if the language code is not recognized
    navigator.notification.alert(
        'The maximum spend budget has been reached for asset ' + serial + '. Please raise the maximum spend limit for this asset.',  // message
        alertDismissed,         // callback
        'Attention',            // title
        'OK'                  // buttonName
    );
}

}//else{

var fullname = parsed_data.asset['full_name'];
$('.assetFullname').text(fullname);

var image = parsed_data.asset['image']['large'];
//$('.assetImg').attr('src', 'https://'+apiType+'.weservicegymequipment.com/'+image+'');

//$('.assetImg').css('background', 'url(https://'+apiType+'.weservicegymequipment.com/'+image+')  no-repeat center center');

var li = '<ons-list-item>'+
      '<div class="left">'+
        '<img class="list-item__thumbnail assetImg" src="https://'+apiType+'.weservicegymequipment.com/'+image+'">'+
      '</div>'+
      '<div class="center" style="color:black !important;">'+
        '<span class="trn">Tap on image to enlarge</span>'+
      '</div>'+
      '<div class="right">'+
        '<div class="imgRemover" data-serial=""><ons-ripple color="#bb8fce" background="#85c1e9"></ons-ripple><p>X</p></div>'+
      '</div>'+
    '</ons-list-item>';

$('.assetImgShow').html(li);

$('.addAassetBtn').attr('data-image', 'https://'+apiType+'.weservicegymequipment.com/'+image+'');



$('.asset_note').remove();
$('<textarea class="asset_note trn" data-prev="" style="box-sizing: border-box; display: inline-block; min-height: 70px;  width: calc(100% - 18px);margin-left: 9px;margin-right: 9px;" placeholder="Write full description of the fault"></textarea>').insertAfter('.after');
var modal = document.getElementById('assetmodal');
  modal.show({animation: 'lift'});

var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);


//}


}
  


}else{

console.log(data);
var parsed_data = JSON.parse(data);



function alertDismissed() {

}

navigator.notification.alert(
    parsed_data['msg'],  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);

}




    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
    }
});

}else{

var lang = localStorage.getItem('lang');


function alertDismissed() {
    // Do something if needed
}

if (lang == 'ge') {
    navigator.notification.alert(
        'Dieses Asset kann diesem Ticket nicht hinzugefügt werden! Dies kann daran liegen, dass dieser Vermögenswert nicht im selben Vertrag enthalten ist oder dass dieser Vermögenswert bereits im selben Ticket enthalten ist.',  // message
        alertDismissed,         // callback
        'Fehler',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'po') {
    navigator.notification.alert(
        'Este ativo não pode ser adicionado a este chamado! Isso pode ocorrer porque este ativo não está no mesmo contrato ou porque este ativo já está no mesmo chamado.',  // message
        alertDismissed,         // callback
        'Erro',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'sp') {
    navigator.notification.alert(
        '¡Este activo no puede ser añadido a este ticket! Esto podría deberse a que este activo no está en el mismo contrato o porque este activo ya está en el mismo ticket.',  // message
        alertDismissed,         // callback
        'Error',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'bul') {
    navigator.notification.alert(
        'Този актив не може да бъде добавен към този билет! Това може да се дължи на факта, че този актив не е в същия договор или че този актив вече е в същия билет.',  // message
        alertDismissed,         // callback
        'Грешка',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'it') {
    navigator.notification.alert(
        'Questo asset non può essere aggiunto a questo ticket! Questo potrebbe essere dovuto al fatto che questo asset non è nello stesso contratto o perché questo asset è già nello stesso ticket.',  // message
        alertDismissed,         // callback
        'Errore',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'fr') {
    navigator.notification.alert(
        'Cet actif ne peut pas être ajouté à ce ticket ! Cela pourrait être dû au fait que cet actif n\'est pas dans le même contrat ou parce que cet actif est déjà dans le même ticket.',  // message
        alertDismissed,         // callback
        'Erreur',            // title
        'OK'                  // buttonName
    );
}  else if (lang == 'ar') {
    navigator.notification.alert(
        'لا يمكن إضافة هذا العنصر إلى هذه التذكرة! قد يكون هذا بسبب أن هذا العنصر ليس في نفس العقد أو لأن هذا العنصر بالفعل في نفس التذكرة',  // message
        alertDismissed,         // callback
        'خطأ',            // title
        'شكرًا'                  // buttonName
    );
}else if (lang == 'ja') {
navigator.notification.alert(
    'このアイテムをこのチケットに追加できません！これは、このアイテムが同じ契約にないか、既に同じチケットにあるためかもしれません',  // message
    alertDismissed,         // callback
    'エラー',            // title
    'ありがとうございます'                  // buttonName
);
}else if (lang == 'tu') {
navigator.notification.alert(
    'Bu öğeyi bu bilete ekleyemezsiniz! Bu, öğenin aynı sözleşmede olmadığı veya zaten aynı bilete ekli olduğu anlamına gelebilir.',  // Mesaj
    alertDismissed,         // Geri çağırma
    'Hata',            // Başlık
    'Anladım'                  // Düğme Adı
);

}else {
    // Default to the original text if the language code is not recognized
    navigator.notification.alert(
        'This asset cannot be added to this ticket! This could be because this asset is not in the same contract or because this asset is already in the same ticket.',  // message
        alertDismissed,         // callback
        'Error',            // title
        'OK'                  // buttonName
    );
}

}



    },
  (error) => {
    // Error handling
  },
);



}



$(document).on('click', '.submitEditTicketBtn', function(){ 
var uuid = localStorage.getItem('uuid');
var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');


var dis = JSON.stringify(descriptions);
var sers = JSON.stringify(serial_numbers);

console.log(sers);
console.log(dis);

    var pmodal = document.getElementById('preloaderModal');
pmodal.show();

$(this).prop('disabled', true);


$.ajax({
    url: ''+host+'go-postUpdateTicketAddingNewAsset.php?email='+email+'&accesstoken='+accesstoken+'&serial_number='+sers+'&description='+dis+'&uuid='+uuid+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

              var pmodal = document.getElementById('preloaderModal');
pmodal.hide();


      var json = JSON.stringify(data);


     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);

    $('.button').prop('disabled', false);
      $('.loaderIcon').hide();


if(parsed_data['status'] == 'OK'){



      //$('.notesD').append(finalNote);

var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};

var lang = localStorage.getItem('lang');


function alertDismissed() {
    document.querySelector('#myNavigator').popPage();
}

if (lang == 'ge') {
    navigator.notification.alert(
        'Sie haben dieses Ticket erfolgreich aktualisiert.',  // message
        alertDismissed,         // callback
        'Bestätigung',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'po') {
    navigator.notification.alert(
        'Você atualizou este chamado com sucesso.',  // message
        alertDismissed,         // callback
        'Sucesso',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'sp') {
    navigator.notification.alert(
        'Ha actualizado este ticket con éxito.',  // message
        alertDismissed,         // callback
        'Éxito',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'bul') {
    navigator.notification.alert(
        'Успешно актуализирахте този билет.',  // message
        alertDismissed,         // callback
        'Успех',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'it') {
    navigator.notification.alert(
        'Hai aggiornato con successo questo ticket.',  // message
        alertDismissed,         // callback
        'Successo',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'fr') {
    navigator.notification.alert(
        'Vous avez mis à jour ce ticket avec succès.',  // message
        alertDismissed,         // callback
        'Succès',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'ar') {
    navigator.notification.alert(
        'لقد قمت بتحديث هذه التذكرة بنجاح',  // message
        alertDismissed,         // callback
        'نجاح',            // title
        'حسناً'                  // buttonName
    );
}else if (lang == 'ja') {
navigator.notification.alert(
    'このチケットは正常に更新されました',  // message
    alertDismissed,         // callback
    '成功',            // title
    'わかりました'                  // buttonName
);
}else if (lang == 'tu') {
navigator.notification.alert(
    'Bu bilet başarıyla güncellendi',  // mesaj
    alertDismissed,         // geri çağırma
    'Başarılı',            // başlık
    'Anladım'                  // düğme adı
);

}else {
    // Default to the original text if the language code is not recognized
    navigator.notification.alert(
        'You have successfully updated this ticket.',  // message
        alertDismissed,         // callback
        'Success',            // title
        'OK'                  // buttonName
    );
}

}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );

        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});


});


$(document).on('click', '.imgRemover', function(event, state){ 

var serial = $(this).attr('data-serial');

function onConfirm(buttonIndex) {

         if(buttonIndex === 2){

             var pmodal = document.getElementById('preloaderModal');
pmodal.show();


var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

//$(this).prop('disabled', true);
//$('.loaderIcon').show();

var values = {
            'serial': serial,
            'img': null,
            'email': email,
            'accesstoken': accesstoken
    };

$.ajax({
    url: ''+host+'asset-add-img.php',
    //dataType: 'text',
    data: values,
    type: 'POST',
    success: function( data, textStatus, jQxhr ){

        //$('.assetImg').attr('src', 'images/no_img.jpg');

        //$('.assetImg').css('background', 'url(images/no_img.jpg)  no-repeat center center');

        var li = '<ons-list-item>'+
      '<div class="left">'+
        '<img class="list-item__thumbnail assetImg" src="images/no_img.jpg">'+
      '</div>'+
      '<div class="right">'+
        
      '</div>'+
    '</ons-list-item>';

$('.assetImgShow').html(li);

        

function alertDismissed() {

    navigator.camera.getPicture(onSuccess, onFail, { 
    quality: 100,
    destinationType: Camera.DestinationType.DATA_URL,
    sourceType: Camera.PictureSourceType.CAMERA,
    encodingType: Camera.EncodingType.JPEG,
   targetWidth: screen.width,
    targetHeight: screen.height,
    correctOrientation: true
});

function onSuccess(imageData) {

var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

//$(this).prop('disabled', true);
//$('.loaderIcon').show();

var values = {
            'serial': serial,
            'img': imageData,
            'email': email,
            'accesstoken': accesstoken
    };

$.ajax({
    url: ''+host+'asset-add-img.php',
    //dataType: 'text',
    data: values,
    type: 'POST',
    success: function( data, textStatus, jQxhr ){


var lang = localStorage.getItem('lang');


function alertDismissed() {
    // Do something if needed
}

if (lang == 'ge') {
    navigator.notification.alert(
        'Das Bild wurde diesem Gerät hinzugefügt.',  // message
        alertDismissed,         // callback
        'Bestätigung',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'po') {
    navigator.notification.alert(
        'A imagem foi adicionada a este ativo.',  // message
        alertDismissed,         // callback
        'Sucesso',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'sp') {
    navigator.notification.alert(
        'La imagen se ha añadido a este activo.',  // message
        alertDismissed,         // callback
        'Éxito',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'bul') {
    navigator.notification.alert(
        'Снимката е добавена към този актив.',  // message
        alertDismissed,         // callback
        'Успех',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'it') {
    navigator.notification.alert(
        'L\'immagine è stata aggiunta a questo asset.',  // message
        alertDismissed,         // callback
        'Successo',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'fr') {
    navigator.notification.alert(
        'L\'image a été ajoutée à cet actif.',  // message
        alertDismissed,         // callback
        'Succès',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'ar') {
    navigator.notification.alert(
        'تمت إضافة الصورة إلى هذا العنصر',  // message
        alertDismissed,         // callback
        'نجاح',            // title
        'حسناً'                  // buttonName
    );
}else if (lang == 'ja') {
navigator.notification.alert(
    'このアイテムに画像が追加されました',  // message
    alertDismissed,         // callback
    '成功',            // title
    '了解'                  // buttonName
);
}else if (lang == 'tu') {
navigator.notification.alert(
    'Bu öğeye resim eklendi',  // mesaj
    alertDismissed,         // geri çağırma
    'Başarılı',            // başlık
    'Anladım'                  // düğme adı
);
}else {
    // Default to the original text if the language code is not recognized
    navigator.notification.alert(
        'The image has been added to this asset.',  // message
        alertDismissed,         // callback
        'Success',            // title
        'OK'                  // buttonName
    );
}


$('.assetImgShow').html('');
//$('.assetImg').attr('src', 'data:image/jpeg;base64,'+imageData+'');

//$('.assetImg').css('background', 'url(data:image/jpeg;base64,'+imageData+')  no-repeat center center');

var li = '<ons-list-item>'+
      '<div class="left">'+
        '<img class="list-item__thumbnail assetImg" src="data:image/jpeg;base64,'+imageData+'">'+
      '</div>'+
      '<div class="center" style="color:black !important;">'+
        '<span class="trn">Tap on image to enlarge</span>'+
      '</div>'+
      '<div class="right">'+
        '<div class="imgRemover" data-serial=""><ons-ripple color="#bb8fce" background="#85c1e9"></ons-ripple><p>X</p></div>'+
      '</div>'+
    '</ons-list-item>';

$('.assetImgShow').html(li);

  var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);

var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});
}

function onFail() {
  ///var modal2 = document.getElementById('spSelect');
  ///modal2.hide();


var modal = document.getElementById('assetmodal');
  modal.hide({animation: 'lift'});


var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

}

}

var lang = localStorage.getItem('lang');


function alertDismissed() {
    var pmodal = document.getElementById('preloaderModal');
    pmodal.hide();
}

if (lang == 'ge') {
    navigator.notification.alert(
        'Dieses Bild wurde gelöscht. Sie müssen ein weiteres Bild für dieses Asset hinzufügen.',  // message
        alertDismissed,         // callback
        'Bestätigung',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'po') {
    navigator.notification.alert(
        'Esta imagem foi excluída. Você precisará adicionar outra imagem para este ativo.',  // message
        alertDismissed,         // callback
        'Sucesso',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'sp') {
    navigator.notification.alert(
        'Esta imagen ha sido eliminada. Necesitará agregar otra imagen para este activo.',  // message
        alertDismissed,         // callback
        'Éxito',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'bul') {
    navigator.notification.alert(
        'Тази снимка е изтрита. Ще трябва да добавите друга снимка за този актив.',  // message
        alertDismissed,         // callback
        'Успех',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'it') {
    navigator.notification.alert(
        'Questa immagine è stata eliminata. Dovrai aggiungere un\'altra immagine per questo asset.',  // message
        alertDismissed,         // callback
        'Successo',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'fr') {
    navigator.notification.alert(
        'Cette image a été supprimée. Vous devrez ajouter une autre image pour cet actif.',  // message
        alertDismissed,         // callback
        'Succès',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'ar') {
    navigator.notification.alert(
        'تم حذف هذه الصورة. يجب عليك إضافة صورة أخرى لهذا العنصر.',  // message
        alertDismissed,         // callback
        'نجاح',            // title
        'حسنًا'                  // buttonName
    );
}else if (lang == 'ja') {
navigator.notification.alert(
    'この画像が削除されました。このアイテムに別の画像を追加する必要があります。',  // message
    alertDismissed,         // callback
    '成功',            // title
    '了解'                  // buttonName
);
}else if (lang == 'tu') {
navigator.notification.alert(
    'Bu resim silindi. Bu öğeye başka bir resim eklemeniz gerekmektedir.',  // mesaj
    alertDismissed,         // geri çağırma
    'Başarılı',            // başlık
    'Anladım'                  // düğme adı
);

}  else {
    // Default to the original text if the language code is not recognized
    navigator.notification.alert(
        'This image has been deleted. You will require to add another image for this asset.',  // message
        alertDismissed,         // callback
        'Success',            // title
        'OK'                  // buttonName
    );
}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});

         }

}



var lang = localStorage.getItem('lang');


if (lang == 'ge') {
    var msg = 'Möchten Sie das Bild dieses Assets löschen?';
    var title = 'Achtung';
    var yesBtn = 'OK';
    var cancelBtn = 'Abbrechen';
} else if (lang == 'po') {
    var msg = 'Deseja excluir a imagem deste ativo?';
    var title = 'Atenção';
    var yesBtn = 'OK';
    var cancelBtn = 'Cancelar';
} else if (lang == 'sp') {
    var msg = '¿Desea eliminar la imagen de este activo?';
    var title = 'Atención';
    var yesBtn = 'OK';
    var cancelBtn = 'Cancelar';
} else if (lang == 'bul') {
    var msg = 'Искате ли да изтриете изображението на този актив?';
    var title = 'Внимание';
    var yesBtn = 'OK';
    var cancelBtn = 'Отказ';
} else if (lang == 'it') {
    var msg = 'Vuoi eliminare l\'immagine di questo asset?';
    var title = 'Attenzione';
    var yesBtn = 'OK';
    var cancelBtn = 'Annulla';
} else if (lang == 'fr') {
    var msg = 'Voulez-vous supprimer l\'image de cet actif ?';
    var title = 'Attention';
    var yesBtn = 'OK';
    var cancelBtn = 'Annuler';
} else if (lang == 'ar') {
    var msg = 'هل ترغب في حذف الصورة من هذا العنصر؟';
    var title = 'تنبيه';
    var yesBtn = 'حسناً';
    var cancelBtn = 'تم الإلغاء';
}else if (lang == 'ja') {
var msg = 'このアイテムから画像を削除しますか？';
var title = '警告';
var yesBtn = 'はい';
var cancelBtn = 'キャンセル';
}else if (lang == 'tu') {
var msg = 'Bu öğeden resmi silmek istiyor musunuz?';
var title = 'Uyarı';
var yesBtn = 'Evet';
var cancelBtn = 'İptal';

}else {
    // Default to the original text if the language code is not recognized
    var msg = 'Do you want to delete this asset\'s image?';
    var title = 'Attention';
    var yesBtn = 'Yes. Delete';
    var cancelBtn = 'Cancel';
}

navigator.notification.confirm(
    msg, // message
     onConfirm,            // callback to invoke with index of button pressed
    title,           // title
    [cancelBtn, yesBtn]     // buttonLabels
);

});

$(document).on('click', '.assetImg', function(event, state){ 

var img = $(this).attr('src');
//var img = src.replace(/(?:^url\(["']?|["']?\)$)/g, "");



$('<div class="floatingImgHolder"><img class="floatingImg"><div>').appendTo('body');
$(".floatingImg").attr('src', img);

});


$(document).on('click', '.floatingImgHolder', function(event, state){ 

$(this).remove();


});




$(document).on('click', '.player-overlay', function(event, state){ 

var v = $(this).attr('data-src');
$('.player-overlay').css('opacity', '100%');
$(this).css('opacity', '40%');


  var videoUrl = ""+v+"";

    // Play a video with callbacks
var options = {
    successCallback: function() {
      console.log("Video was closed without error.");
    },
    errorCallback: function(errMsg) {
      console.log("Error! " + errMsg);
    },
    orientation: 'portrait',
    shouldAutoClose: true,  // true(default)/false
    controls: true // true(default)/false. Used to hide controls on fullscreen
  };
  window.plugins.streamingMedia.playVideo(videoUrl, options);


  var userAgent = navigator.userAgent || navigator.vendor || window.opera;

  if( userAgent.match( /iPad/i ) || userAgent.match( /iPhone/i ) || userAgent.match( /iPod/i ) )
  {
    

  }
  else if( userAgent.match( /Android/i ) )
  {


   
  }
  else
  {
    //alert('unknown'); 
  }

});



function callQRscanner3(){

    $('.o-tickets0').empty();

//SpinnerDialog.show(null, "Please wait...");

var lang = localStorage.getItem('lang');


if (lang == 'ge') {
    notdetected = 'QR-Code nicht erkannt';
} else if (lang == 'po') {
    notdetected = 'Código QR não reconhecido';
} else if (lang == 'sp') {
    notdetected = 'Código QR no reconocido';
} else if (lang == 'bul') {
    notdetected = 'QR-кодът не е разпознат';
} else if (lang == 'it') {
    notdetected = 'Codice QR non riconosciuto';
} else if (lang == 'fr') {
    notdetected = 'Code QR non reconnu';
} else if (lang == 'ar') {
    notdetected = 'الرمز الشريطي QR غير معترف به';
}  else if (lang == 'ja') {
     notdetected = 'QRコードが検出されませんでした';
} else if (lang == 'tu') {
     notdetected = 'QR kodu algılanamadı';

} else {
    // Default to the original text if the language code is not recognized
    notdetected = 'QR-Code not detected';
}

cordova.plugins.mlkit.barcodeScanner.scan(
  barCodeOptions,
(result) => {

var serial = result.text;



    /*monaca.BarcodeScanner.scan((result) => {
   if (result.cancelled) {
      // scan cancelled
    } else {

const serial = result.data.text;*/

var s = serial;

var pmodal = document.getElementById('preloaderModal');
pmodal.show();


var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');



$.ajax({
    url: ''+host+'getAsset.php?serial='+serial+'&email='+email+'&accesstoken='+accesstoken+'&force=1',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

    var json = JSON.stringify(data);

     //var obj = parseJSON(data);
  var parsed_data = JSON.parse(data);

  var pmodal = document.getElementById('preloaderModal');
pmodal.hide();


if(parsed_data['status'] == 'OK'){



var serial = parsed_data.asset['serial_number'];

var active_seller_packages = parsed_data.asset['active_seller_packages'];


count = _.countBy(active_seller_packages, obj => obj.lot_title !== '');



var mainimage = parsed_data.asset['image'];

if (mainimage != null){

var image = parsed_data.asset['image']['large'];
var li = '<ons-list-item>'+
      '<div class="left">'+
        '<img class="list-item__thumbnail assetImg" src="https://'+apiType+'.weservicegymequipment.com/'+image+'">'+
      '</div>'+
      '<div class="center" style="color:black !important;">'+
        '<span class="trn">Tap on image to enlarge</span>'+
      '</div>'+
      '<div class="right">'+
        '<div class="imgRemover" data-serial=""><ons-ripple color="#bb8fce" background="#85c1e9"></ons-ripple><p>X</p></div>'+
      '</div>'+
    '</ons-list-item>';

$('.assetImgShow').html(li);

var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);


$('.imgRemover').attr('data-serial', serial);






}else{


var lang = localStorage.getItem('lang');


function alertDismissed() {
    // Do something if needed
}

if (lang == 'ge') {
    navigator.notification.alert(
        'Zu dem Gerät gibt es noch kein Bild. Nehmen Sie jetzt ein Standardbild Kamera auf.',  // message
        alertDismissed,         // callback
        'Hinweis',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'po') {
    navigator.notification.alert(
        'Este ativo não possui uma imagem padrão. Tire agora uma foto padrão.',  // message
        alertDismissed,         // callback
        'Atenção',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'sp') {
    navigator.notification.alert(
        'Este activo no tiene una imagen predeterminada. Tome ahora una foto predeterminada.',  // message
        alertDismissed,         // callback
        'Atención',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'bul') {
    navigator.notification.alert(
        'Този актив няма стандартно изображение. Вземете сега стандартна снимка.',  // message
        alertDismissed,         // callback
        'Внимание',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'it') {
    navigator.notification.alert(
        'Questo asset non ha un\'immagine predefinita. Scatta ora una foto predefinita.',  // message
        alertDismissed,         // callback
        'Attenzione',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'fr') {
    navigator.notification.alert(
        'Cet actif n\'a pas d\'image par défaut. Prenez maintenant une photo par défaut.',  // message
        alertDismissed,         // callback
        'Attention',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'ar') {
    navigator.notification.alert(
        'هذا العنصر ليس لديه صورة افتراضية. يرجى التقاط صورة افتراضية الآن',  // message
        alertDismissed,         // callback
        'تنبيه',            // title
        'حسنًا'                  // buttonName
    );
}else if (lang == 'ja') {
navigator.notification.alert(
    'このアイテムにはデフォルトの画像がありません。今すぐデフォルトの画像を撮影してください',  // message
    alertDismissed,         // callback
    '警告',            // title
    'OK'                  // buttonName
);
}else if (lang == 'tu') {
navigator.notification.alert(
    'Bu öğenin varsayılan bir resmi yok. Şimdi varsayılan bir resim çekin.',  // message
    alertDismissed,         // geri çağrı
    'Uyarı',            // başlık
    'Tamam'                  // düğme adı
);

}else {
    // Default to the original text if the language code is not recognized
    navigator.notification.alert(
        'This asset has no default image.',  // message
        alertDismissed,         // callback
        'Attention',            // title
        'OK'                  // buttonName
    );
}



function alertDismissed() {

    navigator.camera.getPicture(onSuccess, onFail, { 
    quality: 100,
    destinationType: Camera.DestinationType.DATA_URL,
    sourceType: Camera.PictureSourceType.CAMERA,
    encodingType: Camera.EncodingType.JPEG,
   targetWidth: screen.width,
    targetHeight: screen.height,
    correctOrientation: true
});

function onSuccess(imageData) {

var pmodal = document.getElementById('preloaderModal');
pmodal.show();

var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

//$(this).prop('disabled', true);
//$('.loaderIcon').show();

var values = {
            'serial': serial,
            'img': imageData,
            'email': email,
            'accesstoken': accesstoken
    };

$.ajax({
    url: ''+host+'asset-add-img.php',
    //dataType: 'text',
    data: values,
    type: 'POST',
    success: function( data, textStatus, jQxhr ){



var li = '<ons-list-item>'+
      '<div class="left">'+
        '<img class="list-item__thumbnail assetImg" src="data:image/jpeg;base64,'+imageData+'">'+
      '</div>'+
      '<div class="center" style="color:black !important;">'+
        '<span class="trn">Tap on image to enlarge</span>'+
      '</div>'+
      '<div class="right">'+
        '<div class="imgRemover" data-serial=""><ons-ripple color="#bb8fce" background="#85c1e9"></ons-ripple><p>X</p></div>'+
      '</div>'+
    '</ons-list-item>';

$('.assetImgShow').html(li);


var lang = localStorage.getItem('lang');


function alertDismissed() {
    // Do something if needed
}

if (lang == 'ge') {
    navigator.notification.alert(
        'Das Bild wurde diesem Gerät hinzugefügt.',  // message
        alertDismissed,         // callback
        'Bestätigung',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'po') {
    navigator.notification.alert(
        'A imagem foi adicionada a este ativo.',  // message
        alertDismissed,         // callback
        'Sucesso',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'sp') {
    navigator.notification.alert(
        'La imagen se ha añadido a este activo.',  // message
        alertDismissed,         // callback
        'Éxito',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'bul') {
    navigator.notification.alert(
        'Снимката е добавена към този актив.',  // message
        alertDismissed,         // callback
        'Успех',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'it') {
    navigator.notification.alert(
        'L\'immagine è stata aggiunta a questo asset.',  // message
        alertDismissed,         // callback
        'Successo',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'fr') {
    navigator.notification.alert(
        'L\'image a été ajoutée à cet actif.',  // message
        alertDismissed,         // callback
        'Succès',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'ar') {
navigator.notification.alert(
    'تمت إضافة الصورة إلى هذا العنصر.',  // message
    alertDismissed,         // callback
    'نجاح',            // title
    'حسناً'                  // buttonName
);

} else if (lang == 'ja') {
navigator.notification.alert(
    'このアイテムに画像が追加されました。',  // message
    alertDismissed,         // callback
    '成功',            // title
    'OK'                  // buttonName
);
} else if (lang == 'tu') {
navigator.notification.alert(
    'Bu öğeye bir resim eklendi.',  // mesaj
    alertDismissed,         // geri çağrı
    'Başarılı',            // başlık
    'Tamam'                  // düğme adı
);

}else {
    // Default to the original text if the language code is not recognized
    navigator.notification.alert(
        'The image has been added to this asset.',  // message
        alertDismissed,         // callback
        'Success',            // title
        'OK'                  // buttonName
    );
}


var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});
}

function onFail() {
  //var modal2 = document.getElementById('spSelect');
  //modal2.hide();


var modal = document.getElementById('assetmodal');
  modal.hide({animation: 'lift'});


var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

}

}


}


}else{

console.log(data);
var parsed_data = JSON.parse(data);



function alertDismissed() {

}

navigator.notification.alert(
    parsed_data['msg'],  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);

}




    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
    }
});





var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

 $('.loader').removeClass('hiddenLoader');
$('.whity').show();
//miki


$.ajax({
    url: ''+host+'getTickets.php?serial_number='+s+'&email='+email+'&accesstoken='+accesstoken+'&status=open_engineer_deployed',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

$('.loader').addClass('hiddenLoader');
    $('.whity').hide();


    console.log(data);
        
        var json = JSON.stringify(data);
        var uType = localStorage.getItem('usertype');
        var role = localStorage.getItem('role');
     //var obj = parseJSON(data);

  var parsed_data = JSON.parse(data);

for(i=0;i<parsed_data.tickets.open_engineer_deployed_tickets.length;i++){

var output_string = "";

var appendable = parsed_data.tickets.open_engineer_deployed_tickets[i].appendable;

var appendable_assets = parsed_data.tickets.open_engineer_deployed_tickets[i].appendable_assets;

var encodedObject = window.btoa(JSON.stringify(appendable_assets));



$('.descriptionList').append('<option value="'+parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.description+'">'+parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.description+'</option>');

if(uType == 'Gym Operator'){
//$('.addressList').append('<option value="'+parsed_data.tickets.open_tickets[i].seller_package?.buyer.buyer_profile.site_name+'">'+parsed_data.tickets.open_tickets[i].seller_package?.buyer.buyer_profile.site_name+'</option>');


}else if(uType == 'Service Provider' && role =='buyer'){
$('.addressList').append('<option value="'+parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.seller.seller_profile.site_name+'">'+parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.seller.seller_profile.site_name+'</option>');
}




var optionValues2 =[];
$('.addressList option').each(function(){
    //remove every undefined value here
    $(".addressList option[value='undefined']").remove();
   if($.inArray(this.value, optionValues2) >-1){
      $(this).remove()
   }else{
      optionValues2.push(this.value);
   }
});


var optionValues3 =[];
$('.descriptionList option').each(function(){
    //remove every undefined value here
    $(".descriptionList option[value='undefined']").remove();
   if($.inArray(this.value, optionValues3) >-1){
      $(this).remove()
   }else{
      optionValues3.push(this.value);
   }
});
    

  $('.noIcon').hide();

   var created_at = parsed_data.tickets.open_engineer_deployed_tickets[i].created_at;

  
  var date = new Date(created_at);
  
  var output = ((date.getMonth() > 8) ? (date.getMonth() + 1) : ('0' + (date.getMonth() + 1))) + '/' + ((date.getDate() > 9) ? date.getDate() : ('0' + date.getDate())) + '/' + date.getFullYear();

   var ticket_number = parsed_data.tickets.open_engineer_deployed_tickets[i].ticket_number;
   
   var uuid = parsed_data.tickets.open_engineer_deployed_tickets[i].uuid;
   if(uType == 'Gym Operator'){
   var address = '';
   }else{
   var address = '';
   }
   var location = '';
var des = '';

var co = 'Club Name';
if(uType == 'Gym Operator'){

var company_name = parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.buyer.buyer_profile?.company_name;
co = 'Service Provider';
}else if(uType == 'Service Provider' && role =='buyer'){

   var company_name = parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.seller.seller_profile.company_name;

}else{
var company_name = parsed_data.tickets.open_engineer_deployed_tickets[i].seller_package?.buyer.buyer_profile?.company_name;
co = 'Service Provider';
}


var notes = parsed_data.tickets.open_engineer_deployed_tickets[i].notes;


if(notes == null){

  notes = '';

}


$('.o-tickets0').append('<div class="ticketss" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'" style="width:90%; margin:10px; display:inline-block;"><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="viewTicketBtn button trn" data-type="open">View</button></div><div class="ticketSmallDetails" style="float:left;font-size:12px;padding-top:8px;">'+ticket_number+' </div></div>');

var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);

}

    

    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        $('.loader').addClass('hiddenLoader');
        $('.whity').hide();

    }
});



$.ajax({
    url: ''+host+'getTickets.php?serial_number='+s+'&email='+email+'&accesstoken='+accesstoken+'&status=sub',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

$('.loader').addClass('hiddenLoader');
    $('.whity').hide();
        
        var json = JSON.stringify(data);
        var uType = localStorage.getItem('usertype');

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);



for(i=0;i<parsed_data.tickets.open_sub_tickets.length;i++){

var output_string = "";

var appendable = parsed_data.tickets.open_sub_tickets[i].appendable;

var appendable_assets = parsed_data.tickets.open_sub_tickets[i].appendable_assets;

var encodedObject = window.btoa(JSON.stringify(appendable_assets));


$('.descriptionList').append('<option value="'+parsed_data.tickets.open_sub_tickets[i].seller_package?.description+'">'+parsed_data.tickets.open_sub_tickets[i].seller_package?.description+'</option>');

if(uType == 'Gym Operator'){
//$('.addressList').append('<option value="'+parsed_data.tickets.open_tickets[i].seller_package?.buyer.buyer_profile.site_name+'">'+parsed_data.tickets.open_tickets[i].seller_package?.buyer.buyer_profile.site_name+'</option>');


}else{
$('.addressList').append('<option value="'+parsed_data.tickets.open_sub_tickets[i].seller_package?.seller.seller_profile.site_name+'">'+parsed_data.tickets.open_sub_tickets[i].seller_package?.seller.seller_profile.site_name+'</option>');
}




var optionValues2 =[];
$('.addressList option').each(function(){
    //remove every undefined value here
    $(".addressList option[value='undefined']").remove();
   if($.inArray(this.value, optionValues2) >-1){
      $(this).remove()
   }else{
      optionValues2.push(this.value);
   }
});


var optionValues3 =[];
$('.descriptionList option').each(function(){
        //remove every undefined value here
    $(".descriptionList option[value='undefined']").remove();
   if($.inArray(this.value, optionValues3) >-1){
      $(this).remove()
   }else{
      optionValues3.push(this.value);
   }
});
    

  $('.noIcon').hide();

   var created_at = parsed_data.tickets.open_sub_tickets[i].created_at;

  
  var date = new Date(created_at);
  
  var output = ((date.getMonth() > 8) ? (date.getMonth() + 1) : ('0' + (date.getMonth() + 1))) + '/' + ((date.getDate() > 9) ? date.getDate() : ('0' + date.getDate())) + '/' + date.getFullYear();

   var ticket_number = parsed_data.tickets.open_sub_tickets[i].ticket_number;
   
   var uuid = parsed_data.tickets.open_sub_tickets[i].uuid;
   if(uType == 'Gym Operator'){
   var address = parsed_data.tickets.open_sub_tickets[i].seller_package?.buyer.buyer_profile.site_name;
   }else{
   var address = parsed_data.tickets.open_sub_tickets[i].seller_package?.seller.seller_profile.site_name;
   }
   var location = parsed_data.tickets.open_sub_tickets[i].seller_package?.location;
var des = parsed_data.tickets.open_sub_tickets[i].seller_package?.description;

var co = 'Club Name';
if(uType == 'Gym Operator'){

var company_name = parsed_data.tickets.open_sub_tickets[i].seller_package?.buyer.buyer_profile?.company_name;
co = 'Service Provider';
}else{

   var company_name = parsed_data.tickets.open_sub_tickets[i].seller_package?.seller.seller_profile.company_name;

}


var notes = parsed_data.tickets.open_sub_tickets[i].notes;


if(notes == null){

  notes = '';

}


$('.o-tickets0').append('<div class="ticketss" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'" style="width:90%; margin:10px; display:inline-block;"><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="viewTicketBtn button trn" data-type="open">View</button></div><div class="ticketSmallDetails" style="float:left;font-size:12px;padding-top:8px;">'+ticket_number+'</div></div>');

var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);

}

    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        $('.loader').addClass('hiddenLoader');
        $('.whity').hide();

    }
});


$.ajax({
    url: ''+host+'getTickets.php?serial_number='+s+'&email='+email+'&accesstoken='+accesstoken+'&status=open',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

$('.loader').addClass('hiddenLoader');
    $('.whity').hide();
        
        var json = JSON.stringify(data);
        var uType = localStorage.getItem('usertype');

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);



for(i=0;i<parsed_data.tickets.open_tickets.length;i++){

var output_string = "";

var appendable = parsed_data.tickets.open_tickets[i].appendable;

var appendable_assets = parsed_data.tickets.open_tickets[i].appendable_assets;

var encodedObject = window.btoa(JSON.stringify(appendable_assets));



$('.descriptionList').append('<option value="'+parsed_data.tickets.open_tickets[i].seller_package?.description+'">'+parsed_data.tickets.open_tickets[i].seller_package?.description+'</option>');

if(uType == 'Gym Operator'){
//$('.addressList').append('<option value="'+parsed_data.tickets.open_tickets[i].seller_package?.buyer.buyer_profile.site_name+'">'+parsed_data.tickets.open_tickets[i].seller_package?.buyer.buyer_profile.site_name+'</option>');


}else{
$('.addressList').append('<option value="'+parsed_data.tickets.open_tickets[i].seller_package?.seller.seller_profile.site_name+'">'+parsed_data.tickets.open_tickets[i].seller_package?.seller.seller_profile.site_name+'</option>');
}




var optionValues2 =[];
$('.addressList option').each(function(){
    //remove every undefined value here
    $(".addressList option[value='undefined']").remove();
   if($.inArray(this.value, optionValues2) >-1){
      $(this).remove()
   }else{
      optionValues2.push(this.value);
   }
});


var optionValues3 =[];
$('.descriptionList option').each(function(){
        //remove every undefined value here
    $(".descriptionList option[value='undefined']").remove();
   if($.inArray(this.value, optionValues3) >-1){
      $(this).remove()
   }else{
      optionValues3.push(this.value);
   }
});
    

  $('.noIcon').hide();

   var created_at = parsed_data.tickets.open_tickets[i].created_at;

  
  var date = new Date(created_at);
  
  var output = ((date.getMonth() > 8) ? (date.getMonth() + 1) : ('0' + (date.getMonth() + 1))) + '/' + ((date.getDate() > 9) ? date.getDate() : ('0' + date.getDate())) + '/' + date.getFullYear();

   var ticket_number = parsed_data.tickets.open_tickets[i].ticket_number;
   
   var uuid = parsed_data.tickets.open_tickets[i].uuid;
   if(uType == 'Gym Operator'){
   var address = parsed_data.tickets.open_tickets[i].seller_package?.buyer.buyer_profile.site_name;
   }else{
   var address = parsed_data.tickets.open_tickets[i].seller_package?.seller.seller_profile.site_name;
   }
   var location = parsed_data.tickets.open_tickets[i].seller_package?.location;
var des = parsed_data.tickets.open_tickets[i].seller_package?.description;

var co = 'Club Name';
if(uType == 'Gym Operator'){

var company_name = parsed_data.tickets.open_tickets[i].seller_package?.buyer.buyer_profile?.company_name;
co = 'Service Provider';
}else{

   var company_name = parsed_data.tickets.open_tickets[i].seller_package?.seller.seller_profile.company_name;

}


var notes = parsed_data.tickets.open_tickets[i].notes;


if(notes == null){

  notes = '';

}


$('.o-tickets0').append('<div class="ticketss" data-appendable="'+appendable+'" data-address="'+address+'" data-des="'+des+'" data-location="'+location+'" style="width:90%; margin:10px; display:inline-block;"><div style="float:right;"><button modifier="small" data-uuid="'+uuid+'" data-address="'+address+'" data-location="'+location+'" data-ticketNumber="'+ticket_number+'" data-notes="'+notes+'" data-appendable="'+appendable+'" data-array="'+encodedObject+'" class="viewTicketBtn button trn" data-type="open">View</button></div><div class="ticketSmallDetails" style="float:left;font-size:12px;padding-top:8px;">'+ticket_number+'</div></div>');

var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);

}

    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        $('.loader').addClass('hiddenLoader');
        $('.whity').hide();

    }
});


//}else{



/*function alertDismissed() {

}

navigator.notification.alert(
    'This asset cannot be added to this ticket! This could be because this asset is not in the same contract or because this asset is already in the same ticket.',  // message
    alertDismissed,         // callback
    'Error',            // title
    'OK'                  // buttonName
);*/

//}



      
},
  (error) => {
    // Error handling
  },
);


   /*}
  }, (error) => {
    // permission error
    const error_message = error;
  }, {
    "oneShot" : true,
    "timeoutPrompt" : {
      "show" : true,
      "timeout" : 5,
      "prompt" : "Not detected"
    }
  });*/
//end of QR scanner for adding images


}
$(document).on('click', '.HomeBtnsMain', function(){ 

$('.HomeBtnsMain').removeClass('animated pulse');

$(this).addClass('animated pulse');


});


$(document).on('click', '.assetManagmentBtn', function(){ 

    var ser = $(this).attr('data-serial');
    localStorage.setItem('assetserial', ser);

document.querySelector('#myNavigator').pushPage('asset.html');

});


$(document).on('click', '.completeTask', function(){ 

    var id = $(this).attr('data-id');
var pmodal = document.getElementById('preloaderModal');
pmodal.show();

var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');


var values = {
            'id': id,
            'email': email,
            'accesstoken': accesstoken
    };

$.ajax({
    url: ''+host+'ppm-post.php',
    //dataType: 'text',
    data: values,
    type: 'POST',
    success: function( data, textStatus, jQxhr ){


var pmodal = document.getElementById('preloaderModal');
pmodal.hide();


var lang = localStorage.getItem('lang');


function alertDismissed() {
    $("."+id).remove();
}

if (lang == 'ge') {
    navigator.notification.alert(
        'Sie haben diese Aufgabe als abgeschlossen markiert.',  // message
        alertDismissed,         // callback
        'Bestätigung',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'po') {
    navigator.notification.alert(
        'Você marcou esta tarefa como concluída.',  // message
        alertDismissed,         // callback
        'Sucesso',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'sp') {
    navigator.notification.alert(
        'Has marcado esta tarea como completada.',  // message
        alertDismissed,         // callback
        'Éxito',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'bul') {
    navigator.notification.alert(
        'Отбелязахте тази задача като завършена.',  // message
        alertDismissed,         // callback
        'Успех',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'it') {
    navigator.notification.alert(
        'Hai contrassegnato questo compito come completato.',  // message
        alertDismissed,         // callback
        'Successo',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'fr') {
    navigator.notification.alert(
        'Vous avez marqué cette tâche comme terminée.',  // message
        alertDismissed,         // callback
        'Succès',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'ar') {
navigator.notification.alert(
    'لقد قمت بتحديد هذه المهمة كمكتملة.',  // message
    alertDismissed,         // callback
    'نجاح',            // title
    'حسناً'                  // buttonName
);

} else if (lang == 'ja') {
navigator.notification.alert(
    'このタスクを完了しました。',  // message
    alertDismissed,         // callback
    '成功',            // title
    'OK'                  // buttonName
);
}else if (lang == 'tu') {
navigator.notification.alert(
    'Bu görev tamamlandı.',  // mesaj
    alertDismissed,         // geri çağrı
    'Başarılı',            // başlık
    'Tamam'                  // düğme adı
);

}else {
    // Default to the original text if the language code is not recognized
    navigator.notification.alert(
        'You have marked this task as complete.',  // message
        alertDismissed,         // callback
        'Success',            // title
        'OK'                  // buttonName
    );
}

var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

$.ajax({
    url: ''+host+'get-ppm-tasks.php?email='+email+'&accesstoken='+accesstoken+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

    var json = JSON.stringify(data);

    console.log(json);

     //var obj = parseJSON(data);
  var parsed_data = JSON.parse(data);


if(parsed_data['status'] == 'OK'){

    $('.completedTasks').empty();
    

  for(i=0;i<parsed_data.tasks.today_completed.length;i++){
var title = parsed_data.tasks.today_completed[i].title;
var completed_at = parsed_data.tasks.today_completed[i].completed_at;
var description = parsed_data.tasks.today_completed[i].description;
var product_types = parsed_data.tasks.today_completed[i].product_types;

var localDate = new Date(completed_at);

if(description == null){
description = 'Not Provided';
}
//ariana


$('.completedTasks').append('<ons-list-item expandable style="color:black !important;" class="taskListItem">'+title+'<div class="expandable-content"><span class="trn">Completed at:</span>  '+localDate+'<br><span class="trn">Description:</span>  '+description+'<br><span class="trn">Product Types:</span>  '+product_types+'</div></ons-list-item>');

var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);




  }


}



    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );

         var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});




    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});

});


$(document).on('click', '.active', function(e){ 

    e.preventDefault();
$('.tasksTitles').empty();
var day = $(this).children('a').data('day');
var month = $(this).children('a').data('month');
var year = $(this).children('a').data('year');

if(day < 10){
day = '0'+day;

  }

if(month < 10){
month = '0'+month;
  }



var mydate = year+'-'+month+'-'+day;





calArr = calArray.filter(task => task.date == mydate);

console.log(JSON.stringify(calArr));


    var createCalDialog = function() {
  var dialog = document.getElementById('my-calendar-dialog');

  if (dialog) {
    dialog.show();
  } else {
    ons.createElement('calendar-dialog.html', { append: true })
      .then(function(dialog) {
        dialog.show();
      });
  }
};

createCalDialog();

function doSomething() {

for(i=0;i<calArr.length;i++){

    


var title = calArr[i].title;


$('.tasksTitles').append('<p>'+title+'</p>');

 }

}

 setTimeout(doSomething, 200);




 



});




$(document).on('click', 'a', function(e){ 

if ($(this).data('go')) {

    $(".responsive-calendar").responsiveCalendar('clearAll');

setTimeout(function(){
   const month = ["January","February","March","April","May","June","July","August","September","October","November","December"];
const d = new Date();
let m = month[d.getMonth()];


  var monthNumber = "January___February__March_____April_____May_______June______July______August____September_October___November__December__".indexOf(m) / 10 + 1;

var nextM = '';

if(monthNumber == 12){
nextM = 1;
}else{
nextM = Number(monthNumber) + 1;
}

  if(nextM < 10){
nextM = '0'+nextM;

  }




var lastD = $("a").last().text();
var firstD = $(".day a").first().text();

if(firstD < 10){
firstD = '0'+firstD;

  }

  if(lastD < 10){
lastD = '0'+lastD;

  }

var year = new Date().getFullYear();
 var to = year+'-'+nextM+'-'+lastD;
var old = localStorage.getItem('oldMonth');


  if(old < 10){
old = '0'+old;

  }



 var fro = year+'-'+old+'-'+firstD;



var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');
var serial = localStorage.getItem('assetserial');


$.ajax({
    url: ''+host+'getMaintenanceHistory.php?serial='+serial+'&email='+email+'&accesstoken='+accesstoken+'&to='+to+'&from='+fro+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

    var json = JSON.stringify(data);

  var parsed_data = JSON.parse(data);



  var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

 

  console.log(json);

if(parsed_data['status'] == 'OK'){
var result = {};
 calArray = [];



 for(i=0;i<parsed_data.tasks.length;i++){
var mydate = parsed_data.tasks[i].date;

  // Check if an object with the date already exists in the result object
  if (!result[mydate]) {

    // If it doesn't exist, create a new object with the date as the key and an empty object as the value
    result[mydate] = {};

  }

  // Set the number and url values for the corresponding object in the result object
  result[mydate]["number"] = "";
  result[mydate]["url"] = parsed_data.tasks[i].title;


  var assetToAdd = {
  "date": parsed_data.tasks[i].date,
  "title": parsed_data.tasks[i].title,
}


calArray.push(assetToAdd);

 }


/*result = JSON.stringify(result);

result = result.replace(/({)([}\w]+)(})/,'$2');

console.log(JSON.stringify(result));*/

/*var j = JSON.stringify(result);

localStorage.setItem('calendar', j);*/


 $(".responsive-calendar").responsiveCalendar('clearAll');

$('.responsive-calendar').responsiveCalendar('edit',result);

console.log($('.calendarMonth').html());



}

    }

});




}, 2000);      

}

});

$(document).on('click', '.odoAddBtn', function(e){ 
var odoMeter = $('.odoMeter').val();

var pmodal = document.getElementById('preloaderModal');
pmodal.show();

var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');
var serial = localStorage.getItem('assetserial');


var values = {
            'serial': serial,
            'reading': odoMeter,
            'email': email,
            'accesstoken': accesstoken
    };

$.ajax({
    url: ''+host+'postNewOdometerReading.php',
    //dataType: 'text',
    data: values,
    type: 'POST',
    success: function( data, textStatus, jQxhr ){

        console.log(data);

  var parsed_data = JSON.parse(data);

  

if(parsed_data['status'] == 'OK'){

var lang = localStorage.getItem('lang');


function alertDismissed() {
    $('.odoMeter').val('');
}

if (lang == 'ge') {
    navigator.notification.alert(
        'Die Lesung wurde diesem Gerät hinzugefügt.',  // message
        alertDismissed,         // callback
        'Bestätigung',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'po') {
    navigator.notification.alert(
        'A leitura foi adicionada a este ativo.',  // message
        alertDismissed,         // callback
        'Sucesso',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'sp') {
    navigator.notification.alert(
        'La lectura se ha añadido a este activo.',  // message
        alertDismissed,         // callback
        'Éxito',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'bul') {
    navigator.notification.alert(
        'Отчетът е добавен към този актив.',  // message
        alertDismissed,         // callback
        'Успех',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'it') {
    navigator.notification.alert(
        'La lettura è stata aggiunta a questo asset.',  // message
        alertDismissed,         // callback
        'Successo',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'fr') {
    navigator.notification.alert(
        'La lecture a été ajoutée à cet actif.',  // message
        alertDismissed,         // callback
        'Succès',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'ar') {
navigator.notification.alert(
    'تمت إضافة القراءة إلى هذا العنصر',  // message
    alertDismissed,         // callback
    'نجاح',            // title
    'حسناً'                  // buttonName
);
} else if (lang == 'ja') {
navigator.notification.alert(
    'このアイテムに読み込みが追加されました。',  // message
    alertDismissed,         // callback
    '成功',            // title
    'OK'                  // buttonName
);
}  else if (lang == 'tu') {
navigator.notification.alert(
    'Bu öğeye yükleme eklendi.',  // mesaj
    alertDismissed,         // geri çağrı
    'Başarılı',            // başlık
    'Tamam'                  // düğme adı
);

} else {
    // Default to the original text if the language code is not recognized
    navigator.notification.alert(
        'The reading has been added to this asset.',  // message
        alertDismissed,         // callback
        'Success',            // title
        'OK'                  // buttonName
    );
}
var pmodal = document.getElementById('preloaderModal');
pmodal.hide();



$.ajax({
    url: ''+host+'getAsset.php?serial='+serial+'&email='+email+'&accesstoken='+accesstoken+'&force=1',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

    var json = JSON.stringify(data);

     //var obj = parseJSON(data);
  var parsed_data = JSON.parse(data);

  var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

  console.log(json);

if(parsed_data['status'] == 'OK'){

    $('.odolist').empty();

var odometerReadings = parsed_data.asset['odometer_readings']; 
for(i=0;i<odometerReadings.length;i++){

var value = odometerReadings[i].value;
var who = odometerReadings[i].who;
var formatted_created_at = odometerReadings[i].formatted_created_at;


var list = '<ons-list-item class="odoListItem" expandable>'+value+'<div class="expandable-content">Created at: '+formatted_created_at+'<br>User: '+who+'</div></ons-list-item>';

$('.odolist').append(list);

 }


}
    }


    });




}

    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});

});


document.addEventListener('deviceready', onDeviceReady, false);


function onDeviceReady () {



    //Calculate the space left to store in the app.
    /*function getLocalStorageSize() {
        let totalSize = 0;
        for (let key in localStorage) {
            if (localStorage.hasOwnProperty(key)) {
                totalSize += key.length + localStorage.getItem(key).length;
            }
        }
        return totalSize;
    }
    
    const totalSizeInBytes = getLocalStorageSize();
    const totalSizeInKB = (totalSizeInBytes / 1024).toFixed(2);
    
    alert(`Total size in LocalStorage: ${totalSizeInBytes} bytes (${totalSizeInKB} KB)`);*/
    


    // Optionally hide the cover completely after the animation
 setTimeout(() => {

    // Assuming you want to trigger this at the same time
    
    $('.cover').fadeOut();
    }, 4000); // Adjust the 

    const passwordInput = document.getElementById('password');
    const togglePasswordButton = document.getElementById('togglePassword');

    togglePasswordButton.addEventListener('click', () => {
      const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
      passwordInput.setAttribute('type', type);
    });

/*var store = cordova.file.dataDirectory;





var assetURL = "https://rooz-dev.co.uk/o4-app/test.js";
var fileName = "test.js";

//alert(store);
//alert(fileName);
//alert(store + fileName);

window.resolveLocalFileSystemURL(store + fileName, appStart, downloadAsset);
var siteURL = '';
var sitetoURL = '';
function downloadAsset() {

var fileTransfer = new FileTransfer();

fileTransfer.onprogress = function(result){
     var percent =  result.loaded / result.total * 100;
     percent = Math.round(percent);
     console.log('Downloaded:  ' + percent + '%');
	 //document.querySelector('ons-progress-bar').setAttribute('value', ''+percent+'');

};

	fileTransfer.download(assetURL, store + fileName, 
		function(entry) {
			alert("Success!");
			

sitetoURL = entry.toURL();
siteURL = store + fileName;

//alert(entry.toURL());
//alert(siteURL);






            appStart();



			//console.log(entry.nativeURL());
			//console.log(entry.toNativeURL());
			//alert(entry.toURL());
            //alert(entry.toNativeURL());

            
			
			//$('.audioname').text(vid_name);
			
			

}, function(){
			
			
		}, 
		function(err) {
			console.log("Error");
			console.dir(err);
		});

}

function appStart() {
//alert(siteURL);


function loadJS(FILE_URL, async = true) {
  let scriptEle = document.createElement("script");

  scriptEle.setAttribute("src", FILE_URL);
  scriptEle.setAttribute("type", "text/javascript");
  scriptEle.setAttribute("async", async);

  document.body.appendChild(scriptEle);

  // success event 
  scriptEle.addEventListener("load", () => {
    alert("File loaded")
  });
   // error event
  scriptEle.addEventListener("error", (ev) => {
    alert("Error on loading file", ev);
  });
}

loadJS(sitetoURL, true);
}*/

   }

      // Handle the back button
    //
    /*function onBackKeyDown() {
    


document.addEventListener('show', function(event) {
var page = event.target;

if(page.matches('#home2')){

alert('its homepage so cant pop the page');

}else{
document.querySelector('#myNavigator').popPage();
}

});
    }*/

$(document).on('click', '.largeThumb', function(){ 

var src = $(this).attr('src');
$('body').append('<div class="largeImg"><img class="animated zoomIn" src="'+src+'"></div>');

   
});

$(document).on('click', '.largeThumb2', function(e){ 

    e.preventDefault();

var src = $(this).css('background-image');
var img = src.replace(/(?:^url\(["']?|["']?\)$)/g, "");
$('body').append('<div class="largeImg"><img class="animated zoomIn" src="'+img+'"></div>');
//$('.flip-card-back').css('background-image', ''+src+'');

//$('.flip-card-inner').css('transform','rotateY(180deg)');
   
});


$(document).on('click', '.newqrCaller', function(){ 


var numItems = $('.addedAsset').length; 


if(numItems == 0){

callQRscanner();

}else{

var lang = localStorage.getItem('lang');


if (lang == 'ge'){
function alertDismissed() {

}
navigator.notification.alert(
    'Bitte pro Ticket nur ein Gerät hinzufügen',  // message
    alertDismissed,         // callback
    'Achtung',            // title
    'OK'                  // buttonName
);
}else{

    function alertDismissed() {

}
navigator.notification.alert(
    'Only one asset per ticket can be submitted!',  // message
    alertDismissed,         // callback
    'Attention',            // title
    'OK'                  // buttonName
);

}
}
   
});



$(document).on('click', '.td_backBtn', function(){ 
combinedNotes =[];

});

$(document).on('click', '.addimg', function(){ 

var numItems = $('.addedAsset').length; 


if(numItems == 0){

var lang = localStorage.getItem('lang');

var alertTitle, alertMessage;

if (lang == 'ge') {
    alertTitle = 'Achtung';
    alertMessage = 'Bitte fügen Sie diesem Ticket zuerst ein Asset hinzu, bevor Sie Bilder hinzufügen!';
} else if (lang == 'po') {
    alertTitle = 'Atenção';
    alertMessage = 'Por favor, adicione um ativo a este chamado antes de adicionar imagens!';
} else if (lang == 'sp') {
    alertTitle = 'Atención';
    alertMessage = 'Por favor, añada un activo a este ticket antes de agregar imágenes.';
} else if (lang == 'bul') {
    alertTitle = 'Внимание';
    alertMessage = 'Моля, добавете актив към този билет, преди да добавите изображения!';
} else if (lang == 'it') {
    alertTitle = 'Attenzione';
    alertMessage = 'Si prega di aggiungere un asset a questo ticket prima di aggiungere immagini!';
} else if (lang == 'fr') {
    alertTitle = 'Attention';
    alertMessage = 'Veuillez ajouter un actif à ce ticket avant d\'ajouter des images !';
} else if (lang == 'ar') {
alertTitle = 'تنبيه';
alertMessage = 'يرجى إضافة عنصر إلى هذه التذكرة قبل إضافة الصور!';

}else if (lang == 'ja') {
alertTitle = '警告';
alertMessage = '画像を追加する前に、このチケットにアイテムを追加してください！';


}else if (lang == 'tu') {
alertTitle = 'Uyarı';
alertMessage = 'Lütfen resim eklemek için önce bu bilet üzerine bir öğe ekleyin!';



}else {
    // Default to English if the language code is not recognized
    alertTitle = 'Attention';
    alertMessage = 'Please add an asset to this ticket first before adding images!';
}

Swal.fire({
    title: alertTitle,
    text: alertMessage,
    icon: 'warning',
    showCancelButton: false,
    confirmButtonColor: '#da116d',
    //cancelButtonColor: '#d33',
    confirmButtonText: 'OK'
});

}else{

$('.addImgManual').click();



/*var app = {};


//horses
var lang = localStorage.getItem('lang');


var useCameratext = 'Use Camera';
var selectGaltxt = 'Use Gallery';
var  recordVideotxt = 'Record Video';
var cl = 'Cancel';
var ttle = '';

if (lang == 'ge') {
    useCameratext = 'Kamera verwenden';
    selectGaltxt = 'Galerie verwenden';
    recordVideotxt = 'Video aufnehmen';
    cl = 'Abbrechen';
    ttle = '';
} else if (lang == 'po') {
    useCameratext = 'Usar câmera';
    selectGaltxt = 'Usar galeria';
    recordVideotxt = 'Gravar vídeo';
    cl = 'Cancelar';
    ttle = '';
} else if (lang == 'sp') {
    useCameratext = 'Usar cámara';
    selectGaltxt = 'Usar galería';
    recordVideotxt = 'Grabar vídeo';
    cl = 'Cancelar';
    titleText = '';
} else if (lang == 'bul') {
    useCameratext = 'Използване на камера';
    selectGaltxt = 'Използване на галерия';
    recordVideotxt = 'Запис на видео';
    cl = 'Отказ';
    ttle = '';
} else if (lang == 'it') {
    useCameratext= 'Usa fotocamera';
    selectGaltxt = 'Usa galleria';
    recordVideotxt = 'Registrare video';
    cl = 'Annulla';
    ttle = '';
} else if (lang == 'fr') {
    useCameratext = 'Utiliser l\'appareil photo';
    selectGaltxt = 'Utiliser la galerie';
    recordVideotxt = 'Enregistrer une vidéo';
    cl = 'Annuler';
    ttle = '';
}
else if (lang == 'ar') {
useCameratext = 'استخدام الكاميرا';
selectGaltxt = 'استخدام المعرض';
recordVideotxt = 'تسجيل فيديو';
cl = 'إلغاء';
    ttle = '';
}else if (lang == 'ja') {
useCameratext = 'カメラを使用する';
selectGaltxt = 'ギャラリーを選択する';
recordVideotxt = 'ビデオを録画する';
cl = 'キャンセル';
ttle = '';
}else if (lang == 'tu') {
useCameratext = 'Kamerayı Kullan';
selectGaltxt = 'Galeriyi Seç';
recordVideotxt = 'Video Kaydı Yap';
cl = 'İptal';
ttle = '';

}

app.showFromObject = function () {
  ons.openActionSheet({
    title: '',
    cancelable: true,
    buttons: [
   selectGaltxt,
   useCameratext,
   recordVideotxt,
      
      {
        label: cl,
        icon: 'md-close'
      }
    ]
  }).then(function (index) { 

//lets do it here
if (index == 0){


    navigator.camera.getPicture(onSuccess, onFail, { 
    quality: 100,
    destinationType: Camera.DestinationType.DATA_URL,
    sourceType: Camera.PictureSourceType.PHOTOLIBRARY,
    encodingType: Camera.EncodingType.JPEG,
       targetWidth: screen.width,
    targetHeight: screen.height,
    correctOrientation: true
});

function onSuccess(imageData) {
$('.viewport2').append('<div class="addedImg"><img src="data:image/jpeg;base64,'+imageData+'"></div>');


newAddImgs.push('data:image/jpeg;base64,'+imageData);

}

function onFail() {

}

}else if(index == 1){

navigator.camera.getPicture(onSuccess, onFail, { 
    quality: 100,
    destinationType: Camera.DestinationType.DATA_URL,
    sourceType: Camera.PictureSourceType.CAMERA,
    encodingType: Camera.EncodingType.JPEG,
       targetWidth: screen.width,
    targetHeight: screen.height,
    correctOrientation: true
});

function onSuccess(imageData) {
$('.viewport2').append('<div class="addedImg"><img src="data:image/jpeg;base64,'+imageData+'"></div>');


newAddImgs.push('data:image/jpeg;base64,'+imageData);

}

function onFail() {

}

}else if(index == 2){

recordVideo();

}


   });
};



app.showFromObject();*/

}
});



$(document).on('click', '.catiSel', function(){ 

var pri = $(this).attr('data-cat'); 
priority = pri;
document.querySelector('.prioritySelect').value = priority;
//$('.selectedIndicator').fadeOut();
$('.catiSel').find('div').removeClass('greyedBg');
$(this).find('div').addClass('greyedBg');
//$(this).append('<div class="selectedIndicator"><ons-icon icon="fa-check"></ons-icon></div>');
});

/*$(document).on('focus', '.asset_note', function(){ 
if (Keyboard.isVisible) {
c
}

});

$(document).on('focusout', '.asset_note', function(){ 
if (Keyboard.isVisible) {
    $('.cancelAddAsset').show();
    $('.addAassetBtn').show();
}

});*/

window.addEventListener('resize', (event) => {

    
  // if current/available height ratio is small enough, virtual keyboard is probably visible
  const isKeyboardHidden = ((window.innerHeight / window.screen.availHeight) > 0.6);

  if (isKeyboardHidden == true){

         $('.cancelAddAsset').show();
    $('.addAassetBtn').show();


  }else{


          $('.cancelAddAsset').hide();
    $('.addAassetBtn').hide();

  }
});

$(document).on('click', '#preloaderModal', function(){ 
var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

});







function getTotalUnred() {


    
totalUnredOpen = 0;
totalUnredOpenSub = 0;
totalUnredOpenDeployed = 0;


var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

$.ajax({
    url: ''+host+'getTickets.php?email='+email+'&accesstoken='+accesstoken+'&status=open',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

      var json = JSON.stringify(data);


     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);


if(parsed_data.tickets.open_tickets.length == 0){
$('.pncircle').remove();
}

for(i=0;i<parsed_data.tickets.open_tickets.length;i++){
var unactioned_notes = parsed_data.tickets.open_tickets[i].unactioned_notes;
unactioned_notes = objectLength(unactioned_notes);

totalUnredOpen = unactioned_notes + totalUnredOpen;



if(totalUnredOpen != '0'){

    $('.openTicketsHome').append('<div class="pncircle"><span class="pncircle__content">'+totalUnredOpen+' <ons-icon icon="fa-bell" class="animated wobble"></ons-icon></span></div>');
}

}


}

});




$.ajax({
    url: ''+host+'getTickets.php?email='+email+'&accesstoken='+accesstoken+'&status=sub',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

      var json = JSON.stringify(data);


     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);

if(parsed_data.tickets.open_sub_tickets.length == 0){
$('.pncircle').remove();
}


for(i=0;i<parsed_data.tickets.open_sub_tickets.length;i++){

var unactioned_notes = parsed_data.tickets.open_sub_tickets[i].unactioned_notes;


unactioned_notes = objectLength(unactioned_notes);


totalUnredOpenSub = unactioned_notes + totalUnredOpenSub;



if(totalUnredOpenSub != '0'){

    $('.openTicketsSubHome').append('<div class="pncircle"><span class="pncircle__content">'+totalUnredOpenSub+' <ons-icon icon="fa-bell" class="animated wobble"></ons-icon></span></div>');
}

}


}

});





$.ajax({
    url: ''+host+'getTickets.php?email='+email+'&accesstoken='+accesstoken+'&status=open_engineer_deployed',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

      var json = JSON.stringify(data);


     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);


if(parsed_data.tickets.open_engineer_deployed_tickets.length == 0){
$('.pncircle').remove();
}

for(i=0;i<parsed_data.tickets.open_engineer_deployed_tickets.length;i++){
var unactioned_notes = parsed_data.tickets.open_engineer_deployed_tickets[i].unactioned_notes;
unactioned_notes = objectLength(unactioned_notes);




totalUnredOpenDeployed = unactioned_notes + totalUnredOpenDeployed;

if(totalUnredOpenDeployed != '0'){

    $('.openTicketsDepHome').append('<div class="pncircle"><span class="pncircle__content">'+totalUnredOpenDeployed+' <ons-icon icon="fa-bell" class="animated wobble"></ons-icon></span></div>');
}

}


}

});

}


document.addEventListener("deviceready", function() {
    // Your code using the plugin

});

$(document).on('click', '.langSelector', function(e){

var lang = $(this).attr('data-lang'); 
var currency = $(this).attr('data-currency'); 
var c = $(this).attr('data-country');  
localStorage.setItem('lang', lang);
localStorage.setItem('currency', currency);
localStorage.setItem('country', c);



   /*var $langHolderInner = $('.langHolderInner');
    var originalHTML = $langHolderInner.html();

//$(this).addClass('langSelectorSingle');

      var $selectedLang = $(this);
      var directions = ['left', 'right', 'top', 'bottom'];
      $('.langSelector').not($selectedLang).each(function(index) {
        var direction = directions[Math.floor(Math.random() * directions.length)];
        var distance = Math.random() * 300 + 150;
        var rotate = Math.random() * 360;
        var transformString = 'translate(0,0) rotate(0)';
        switch (direction) {
          case 'left':
            transformString = 'translate(-' + distance + 'px,0) rotate(' + rotate + 'deg)';
            break;
          case 'right':
            transformString = 'translate(' + distance + 'px,0) rotate(' + rotate + 'deg)';
            break;
          case 'top':
            transformString = 'translate(0,-' + distance + 'px) rotate(' + rotate + 'deg)';
            break;
          case 'bottom':
            transformString = 'translate(0,' + distance + 'px) rotate(' + rotate + 'deg)';
            break;
        }
        $(this).css({
          transform: transformString,
          opacity: 0
        });
      });*/

      // Reset buttons after animation

  

    // Function to reset buttons by re-inserting original HTML
    function resetButtons() {
     //$langHolderInner.html(originalHTML);
    }

//$('.langHolder').addClass('animated bounceOutDown');


//if (lang == 'ge'){
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
//}


//$(this).siblings('.langSelector').addClass('animated fadeOut');

setTimeout(showLogin, 1500);

function showLogin() {
   $('.langHolder').addClass('animated bounceOutDown');

}



});


$(document).on('click', '.openMessagesBtn', function(e){ 
$('#ticket-details').removeClass('backgroundBlur');var modal = document.getElementById('ScrollingImagesModal');modal.show({animation: 'lift'});

});


$(document).on('click', '.openTicketDetails', function(e){ 
var modal = document.getElementById('ticketDetailsModal');
modal.show({animation: 'fade'});

});

$(document).on('click', '.actions__btn', function(e){ 

var t = $(this).attr('data-seg');
$('.actions__btn').removeClass('actions__btn--active');
$(this).addClass('actions__btn--active');


if(t == 'notes'){
$('.segs').hide();
    $('.noteseg').show();

    $('.footerMsgHolder').show();


}else if(t == 'media'){
$('.segs').hide();
    $('.imghistory').css('display','flex');
     $('.footerMsgHolder').hide();
}else if(t == 'status'){
    $('.segs').hide();
    $('.statusseg').show();
    $('.footerMsgHolder').hide();

}else if(t == 'docs'){
    $('.segs').hide();
    $('.docsge').show();
   $('.footerMsgHolder').hide();

}else{
$('.footerMsgHolder').hide();
}
});

$(document).on('click', '.sp_action_btns', function(e){ 



///clock out
   if($(this).hasClass('clockOut')){

        function onConfirm(buttonIndex) {

         if(buttonIndex === 2){

               var engineer_arrived_at = new Date().toISOString().replace('T', ' ').substring(0, 19);
//=> dformat => 'yyyy-mm-dd hh:mm:ss'




var uuid = localStorage.getItem('uuid');
var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');
var pmodal = document.getElementById('preloaderModal');
pmodal.show();

//clock in
$.ajax({
    url: host + 'postClock.php',
    type: 'POST',
    data: {
        email: email,
        accesstoken: accesstoken,
        uuid: uuid,
        engineer_arrived_at: engineer_arrived_at,
        type: 'out'
    },
    success: function(data, textStatus, jQxhr) {
        var pmodal = document.getElementById('preloaderModal');
        pmodal.hide();

        var json = JSON.stringify(data);
        console.log(json);

        var parsed_data = JSON.parse(data);

        if (parsed_data['status'] == 'OK') {
            $('.clockOut').addClass('shimmer');

            var notify = function() {
                var lang = localStorage.getItem('lang');
                var message = 'Thank you for confirming.';

                switch (lang) {
                    case 'ge':
                        message = 'Vielen Dank für die Bestätigung.';
                        break;
                    case 'po':
                        message = 'Obrigado por confirmar.';
                        break;
                    case 'sp':
                        message = 'Gracias por confirmar.';
                        break;
                    case 'bul':
                        message = 'Благодарим ви за потвърждението.';
                        break;
                    case 'it':
                        message = 'Grazie per la conferma.';
                        break;
                    case 'fr':
                        message = 'Merci de confirmer.';
                        break;
                    case 'ar':
                        message = 'شكرًا على التأكيد';
                        break;
                    case 'ja':
                        message = '確認していただきありがとうございます';
                        break;
                    case 'tu':
                        message = 'Teşekkür ederiz, kontrol ettiğiniz için.';
                        break;
                }

                ons.notification.toast(message, { timeout: 1500, animation: 'fall' });
            };

            notify();
        }
    },
    error: function(jqXhr, textStatus, errorThrown) {
        console.log(errorThrown);
        var pmodal = document.getElementById('preloaderModal');
        pmodal.hide();
    }
});

         }

        }
var lang = localStorage.getItem('lang');


if (lang == 'ge') {
    navigator.notification.confirm(
        'Hinweis: Sie bestätigen hiermit, dass der Techniker am Einsatzort ist, um den Service durchzuführen.', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Techniker vor Ort!',           // title
        ['Abbrechen', 'OK']     // buttonLabels
    );
} else if (lang == 'po') {
    navigator.notification.confirm(
        'Nota: Você está declarando que está no local. O envio disso pausará o SLA "Tempo para chegar ao local".', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Confirmar',           // title
        ['Cancelar', 'OK']     // buttonLabels
    );
} else if (lang == 'sp') {
    navigator.notification.confirm(
        'Nota: Estás declarando que estás en el lugar. Enviar esto pausará el SLA "Tiempo para llegar al sitio".', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Confirmar',           // title
        ['Cancelar', 'OK']     // buttonLabels
    );
} else if (lang == 'bul') {
    navigator.notification.confirm(
        'Забележка: Декларирате, че сте на място. Изпращането на това ще постави на пауза SLA "Време за пристигане на място".', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Потвърждение',           // title
        ['Отказ', 'OK']     // buttonLabels
    );
} else if (lang == 'it') {
    navigator.notification.confirm(
        'Nota: Stai dichiarando di essere sul posto. L\'invio di questo metterà in pausa l\'SLA "Tempo per arrivare sul posto".', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Conferma',           // title
        ['Annulla', 'OK']     // buttonLabels
    );
} else if (lang == 'fr') {
    navigator.notification.confirm(
        "Remarque : Vous déclarez être sur place. L'envoi de ceci mettra en pause le SLA 'Temps pour arriver sur site'.", // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Confirmer',           // title
        ['Annuler', 'OK']     // buttonLabels
    );
}else if (lang == 'ar') {
    navigator.notification.confirm(
    "ملاحظة: تعلن أنك متواجد في الموقع. إرسال هذا سيوقف SLA 'الوقت للوصول إلى الموقع'.", // message
    onConfirm,            // callback to invoke with the index of the button pressed
    'تأكيد',           // title
    ['إلغاء', 'حسنًا']     // buttonLabels
);

}else if (lang == 'ja') {
navigator.notification.confirm(
    "注意: この場所にいることを通知します。 これを送信すると、現場到着までのSLAが停止します。",
    onConfirm,
    '確認',
    ['キャンセル', 'はい']
);
}else if (lang == 'tu') {
navigator.notification.confirm(
    "Dikkat: Bu konumda olduğunuzu bildirir. Gönderildiğinde, saha varışına kadar SLA durdurulur.",
    onConfirm,
    'Onayla',
    ['İptal', 'Evet']
);

}  else {
    // Default to the original text if the language code is not recognized
    navigator.notification.confirm(
        "Note: You are confirming the Technician is clocking out.", // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Confirm',           // title
        ['Cancel', 'OK']     // buttonLabels
    );
}

    }




//clock in
    if($(this).hasClass('clockIn') && !$(this).hasClass('addedTime')){



if(engineer_id_isSet == null){


var lang = localStorage.getItem('lang');
var msg, title, yesBtn, cancelBtn;

if (lang == 'ge') {
    msg = 'Bitte stellen Sie vor dieser Aktion einen Techniker bereit.'; // Translation: "Please deploy a technician before this action."
    title = 'Achtung'; // Translation: "Attention"
    yesBtn = 'OK'; // Translation: "OK"
} else if (lang == 'po') {
    msg = 'Por favor, implante um técnico antes desta ação.'; // Translation: "Please deploy a technician before this action."
    title = 'Atenção'; // Translation: "Attention"
    yesBtn = 'OK'; // Translation: "OK"
} else if (lang == 'sp') {
    msg = 'Por favor, despliegue un técnico antes de esta acción.'; // Translation: "Please deploy a technician before this action."
    title = 'Atención'; // Translation: "Attention"
    yesBtn = 'OK'; // Translation: "OK"
} else if (lang == 'bul') {
    msg = 'Моля, разгърнете техник преди тази действие.'; // Translation: "Please deploy a technician before this action."
    title = 'Внимание'; // Translation: "Attention"
    yesBtn = 'OK'; // Translation: "OK"
} else if (lang == 'it') {
    msg = 'Si prega di schierare un tecnico prima di questa azione.'; // Translation: "Please deploy a technician before this action."
    title = 'Attenzione'; // Translation: "Attention"
    yesBtn = 'OK'; // Translation: "OK"
} else if (lang == 'fr') {
    msg = 'Veuillez déployer un technicien avant cette action.'; // Translation: "Please deploy a technician before this action."
    title = 'Attention'; // Translation: "Attention"
    yesBtn = 'OK'; // Translation: "OK"
} else if (lang == 'ar') {
    msg = 'يرجى نشر فني قبل هذا الإجراء.'; // Translation: "Please deploy a technician before this action."
    title = 'انتباه'; // Translation: "Attention"
    yesBtn = 'OK'; // Translation: "OK"
} else if (lang == 'ja') {
    msg = 'このアクションの前に技術者を配置してください。'; // Translation: "Please deploy a technician before this action."
    title = '注意'; // Translation: "Attention"
    yesBtn = 'OK'; // Translation: "OK"
} else if (lang == 'tu') {
msg = 'Bu işlemi yapmadan önce bir teknisyen atayın.'; // Translation: "Please deploy a technician before this action."
title = 'Dikkat'; // Translation: "Attention"
yesBtn = 'Tamam'; // Translation: "OK"

} else {
    // Default to the original text if the language code is not recognized
    msg = 'Please deploy a technician before this action.';
    title = 'Attention';
    yesBtn = 'OK';
}


navigator.notification.confirm(
    msg, // message
     onConfirm_0,            // callback to invoke with index of button pressed
    title,           // title
    [yesBtn]     // buttonLabels
);

function onConfirm_0(buttonIndex) {

}



return;
}
   


        function onConfirm(buttonIndex) {

         if(buttonIndex === 2){

               var engineer_arrived_at = new Date().toISOString().replace('T', ' ').substring(0, 19);
//=> dformat => 'yyyy-mm-dd hh:mm:ss'




var uuid = localStorage.getItem('uuid');
var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');
var pmodal = document.getElementById('preloaderModal');
pmodal.show();

//clock in
$.ajax({
    url: host + 'postClock.php',
    type: 'POST',
    data: {
        email: email,
        accesstoken: accesstoken,
        uuid: uuid,
        engineer_arrived_at: engineer_arrived_at,
        type: 'in'
    },
    success: function(data, textStatus, jQxhr) {
        var pmodal = document.getElementById('preloaderModal');
        pmodal.hide();

        var json = JSON.stringify(data);
        console.log(json);

        var parsed_data = JSON.parse(data);

        if (parsed_data['status'] == 'OK') {
            //$('.clockIn').css('background', 'orange');

            $('.clockIn').addClass('shimmer');

            var notify = function() {
                var lang = localStorage.getItem('lang');
                var message = 'Thank you for confirming.';

                switch (lang) {
                    case 'ge':
                        message = 'Vielen Dank für die Bestätigung.';
                        break;
                    case 'po':
                        message = 'Obrigado por confirmar.';
                        break;
                    case 'sp':
                        message = 'Gracias por confirmar.';
                        break;
                    case 'bul':
                        message = 'Благодарим ви за потвърждението.';
                        break;
                    case 'it':
                        message = 'Grazie per la conferma.';
                        break;
                    case 'fr':
                        message = 'Merci de confirmer.';
                        break;
                    case 'ar':
                        message = 'شكرًا على التأكيد';
                        break;
                    case 'ja':
                        message = '確認していただきありがとうございます';
                        break;
                    case 'tu':
                        message = 'Teşekkür ederiz, kontrol ettiğiniz için.';
                        break;
                }

                ons.notification.toast(message, { timeout: 1500, animation: 'fall' });
            };

            notify();
        }
    },
    error: function(jqXhr, textStatus, errorThrown) {
        console.log(errorThrown);
        var pmodal = document.getElementById('preloaderModal');
        pmodal.hide();
    }
});



//return;
/*$.ajax({
    url: ''+host+'postUpdateTicketClockIn.php?email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'&engineer_arrived_at='+engineer_arrived_at+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){
              //alert(JSON.stringify(data));

              var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

      var json = JSON.stringify(data);

console.log(json);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);

if(parsed_data['status'] == 'OK'){

$('.clockIn').css('background', 'orange')

var notify = function() {
  //ons.notification.alert('You have successfully added a note.');
  var lang = localStorage.getItem('lang');


if (lang == 'ge') {
    ons.notification.toast('Vielen Dank für die Bestätigung.', { timeout: 1500, animation: 'fall' });
} else if (lang == 'po') {
    ons.notification.toast('Obrigado por confirmar.', { timeout: 1500, animation: 'fall' });
} else if (lang == 'sp') {
    ons.notification.toast('Gracias por confirmar.', { timeout: 1500, animation: 'fall' });
} else if (lang == 'bul') {
    ons.notification.toast('Благодарим ви за потвърждението.', { timeout: 1500, animation: 'fall' });
} else if (lang == 'it') {
    ons.notification.toast('Grazie per la conferma.', { timeout: 1500, animation: 'fall' });
} else if (lang == 'fr') {
    ons.notification.toast('Merci de confirmer.', { timeout: 1500, animation: 'fall' });
}  else if (lang == 'ar') {
    ons.notification.toast('شكرًا على التأكيد', { timeout: 1500, animation: 'fall' });
}  else if (lang == 'ja') {
    ons.notification.toast('確認していただきありがとうございます', { timeout: 1500, animation: 'fall' });
}  else if (lang == 'tu') {
  ons.notification.toast('Teşekkür ederiz, kontrol ettiğiniz için.', { timeout: 1500, animation: 'fall' });

}else {
    // Default to the original text if the language code is not recognized
    ons.notification.toast('Thank you for confirming.', { timeout: 1500, animation: 'fall' });
}
};

notify();

//document.querySelector('#myNavigator').popPage();


}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );

        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});*/



         }

        }
var lang = localStorage.getItem('lang');

if (lang == 'ge') {
    navigator.notification.confirm(
        'Hinweis: Sie bestätigen hiermit, dass der Techniker am Einsatzort ist, um den Service durchzuführen.', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Techniker vor Ort!',           // title
        ['Abbrechen', 'OK']     // buttonLabels
    );
} else if (lang == 'po') {
    navigator.notification.confirm(
        'Nota: Você está declarando que está no local. O envio disso pausará o SLA "Tempo para chegar ao local".', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Confirmar',           // title
        ['Cancelar', 'OK']     // buttonLabels
    );
} else if (lang == 'sp') {
    navigator.notification.confirm(
        'Nota: Estás declarando que estás en el lugar. Enviar esto pausará el SLA "Tiempo para llegar al sitio".', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Confirmar',           // title
        ['Cancelar', 'OK']     // buttonLabels
    );
} else if (lang == 'bul') {
    navigator.notification.confirm(
        'Забележка: Декларирате, че сте на място. Изпращането на това ще постави на пауза SLA "Време за пристигане на място".', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Потвърждение',           // title
        ['Отказ', 'OK']     // buttonLabels
    );
} else if (lang == 'it') {
    navigator.notification.confirm(
        'Nota: Stai dichiarando di essere sul posto. L\'invio di questo metterà in pausa l\'SLA "Tempo per arrivare sul posto".', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Conferma',           // title
        ['Annulla', 'OK']     // buttonLabels
    );
} else if (lang == 'fr') {
    navigator.notification.confirm(
        "Remarque : Vous déclarez être sur place. L'envoi de ceci mettra en pause le SLA 'Temps pour arriver sur site'.", // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Confirmer',           // title
        ['Annuler', 'OK']     // buttonLabels
    );
}else if (lang == 'ar') {
    navigator.notification.confirm(
    "ملاحظة: تعلن أنك متواجد في الموقع. إرسال هذا سيوقف SLA 'الوقت للوصول إلى الموقع'.", // message
    onConfirm,            // callback to invoke with the index of the button pressed
    'تأكيد',           // title
    ['إلغاء', 'حسنًا']     // buttonLabels
);

}else if (lang == 'ja') {
navigator.notification.confirm(
    "注意: この場所にいることを通知します。 これを送信すると、現場到着までのSLAが停止します。",
    onConfirm,
    '確認',
    ['キャンセル', 'はい']
);
}else if (lang == 'tu') {
navigator.notification.confirm(
    "Dikkat: Bu konumda olduğunuzu bildirir. Gönderildiğinde, saha varışına kadar SLA durdurulur.",
    onConfirm,
    'Onayla',
    ['İptal', 'Evet']
);

}  else {
    // Default to the original text if the language code is not recognized
    navigator.notification.confirm(
        "Note: You are confirming the Technician is now on site.", // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Confirm',           // title
        ['Cancel', 'OK']     // buttonLabels
    );
}
    }



var c = $(this).attr('data-color');
$(this).css('box-shadow', 'inset 0 0 30px '+c+'');
setTimeout(fadeBorder, 1000);

function fadeBorder() {
   $('.sp_action_btns').css('box-shadow', 'none');

}

});

//deploy technician
$(document).on('click', '.depbtn', function(e){

getPermissions();

    var uType = localStorage.getItem('usertype');

    if(uType == 'Gym Operator'){

    }else{

if(localStorage.getItem('page_type') == 'deployed'){

}else{



var lang = localStorage.getItem('lang');

if (lang == 'ge') {
    var o = '<ons-list-item class="enginnersListItem" data-id="other" tappable>Andere</ons-list-item>';
    var t = 'Sie ändern den Ticketstatus auf "Techniker zugewiesen". Bitte wählen Sie eine der folgenden Optionen aus:<br><br>Wählen Sie einen Techniker aus der Liste aus';
} else if (lang == 'po') {
    var o = '<ons-list-item class="enginnersListItem" data-id="other" tappable>Outro</ons-list-item>';
    var t = 'Você está movendo o status do ticket para "Técnico Atribuído". Por favor, selecione uma das opções abaixo:<br><br>Selecione a partir da lista de técnicos existente';
} else if (lang == 'sp') {
    var o = '<ons-list-item class="enginnersListItem" data-id="other" tappable>Otro</ons-list-item>';
    var t = 'Está cambiando el estado del ticket a "Técnico Desplegado". Por favor, seleccione una de las siguientes opciones:<br><br>Seleccione de la lista existente de técnicos';
} else if (lang == 'bul') {
    var o = '<ons-list-item class="enginnersListItem" data-id="other" tappable>Друг</ons-list-item>';
    var t = 'Променяте статуса на билета на "Назначен техник". Моля, изберете една от следните опции:<br><br>Изберете от съществуващия списък с техници';
} else if (lang == 'it') {
    var o = '<ons-list-item class="enginnersListItem" data-id="other" tappable>Altro</ons-list-item>';
    var t = 'Stai modificando lo stato del ticket a "Tecnico Assegnato". Per favore, seleziona una delle seguenti opzioni:<br><br>Seleziona dalla lista esistente di tecnici';
} else if (lang == 'fr') {
   var o = '<ons-list-item class="enginnersListItem" data-id="other" tappable>Autre</ons-list-item>';
    var t = 'Vous modifiez le statut du ticket à "Technicien déployé". Veuillez sélectionner l\'une des options suivantes :<br><br>Sélectionner dans la liste existante des techniciens';
} else if (lang == 'ar') {
var o = '<ons-list-item class="enginnersListItem" data-id="other" tappable>آخر</ons-list-item>';
var t = 'تقوم بتعديل حالة التذكرة إلى "الفني المنفذ". يرجى اختيار إحدى الخيارات التالية:<br><br>اختيار من قائمة الفنيين الحالية';

}else if (lang == 'ja') {
var o = '<ons-list-item class="enginnersListItem" data-id="other" tappable>その他</ons-list-item>';
var t = 'チケットのステータスを"エンジニアが実行中"に変更しています。 次のオプションのいずれかを選択してください：<br><br>現在のエンジニアリストから選択する';

}else if (lang == 'tu') {
var o = '<ons-list-item class="enginnersListItem" data-id="other" tappable>Diğer</ons-list-item>';
var t = 'Bilet durumu "Mühendis çalışıyor" olarak değiştiriliyor. Lütfen aşağıdaki seçeneklerden birini seçin:<br><br>Mevcut mühendis listesinden seçin';


}else {
    // Default to the original text if the language code is not recognized
    var o = '<ons-list-item class="enginnersListItem" data-id="other" tappable>Other</ons-list-item>';
    var t = 'You are moving the ticket status to Technician Deployed. Please select from one of the options below:<br><br>Select from the existing list of technicians';
}

var manage_engineers = localStorage.getItem('permissions_manage_engineers');

if (manage_engineers == 'true'){

      //$('.page').addClass('scaled');
//$('.bottomToolbar').addClass('scaled');
//$('html').addClass('blacked');
//$('body').addClass('blacked');

    // Example usage with custom content
/*addSheetModal({
  modalContent: '<p style="text-align: center;" class="engTitle">'+t+'</p>'+
'<div class="card custom_card">'+
  '<ons-list class="enginnersList_m">'+o+'</ons-list>'+
'</div>'+
  '<div style="width:100%;display:inline-block;text-align:center;font-weight:bold;margin-bottom:10px;margin-top:10px;" class="trn">OR</div>'+
  '<div style="width:100%;display:inline-block;text-align:center;" class="trn">Invite a new technician</div>'+

'<div class="card custom_card">'+
  '<input type="email" class="englineerEmailToInv inps" placeholder="Email"/>'+
  '</div>'+

  '<div class="card custom_card">'+
  '<button class="button button--large trn finalDeployEngBtn">Deploy Technician</button>'+
  '</div>'
});*/


addModernSheetModal({
    modalContent: '<div class="modalInfo"><ons-icon icon="ion-ios-information-circle-outline"></ons-icon></div><div class="modalClose"><ons-icon icon="ion-ios-close"></ons-icon></div><p style="text-align: center;" class="engTitle trn">Select an internal technician</p>'+
    '<div class="card custom_card">'+
    '<ons-list class="enginnersList_m">'+o+'</ons-list>'+
'</div>'+
  '<div style="width:100%;display:inline-block;text-align:center;font-weight:bold;margin-bottom:10px;margin-top:10px;" class="trn">OR</div>'+
  '<div style="width:100%;display:inline-block;text-align:center;" class="trn">Invite a new technician</div>'+

'<div class="card custom_card">'+
  '<input type="email" class="englineerEmailToInv inps" placeholder="Email"/>'+
  '</div>'+

  '<div class="card custom_card">'+
  '<button class="button button--large trn finalDeployEngBtn">Deploy Technician</button>'+
      '</div>'
  });






var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');


        var values = {
            'email': email,
            'accesstoken': accesstoken,
    };


$.ajax({
    url: ''+host+'..getEngineer.php',
   //dataType: 'text',
    data: values,
    type: 'POST',
    success: function( data, textStatus, jQxhr ){
              //alert(JSON.stringify(data));
console.log(data);
      var json = JSON.stringify(data);



     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);

if(parsed_data['status'] == 'OK'){

//come back here addressFinder

  for(i=0;i<parsed_data.engineers.length;i++){
var id = parsed_data.engineers[i].id;
var email = parsed_data.engineers[i].email;
var status = parsed_data.engineers[i].status;
var name = parsed_data.engineers[i].name;


$('.enginnersList_m').append('<ons-list-item class="enginnersListItem" data-id="'+id+'" tappable>'+email+' ('+status+')</ons-list-item>');


  }




}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );

    }
});


}else{

//IF the manage teccnician permssion is NOT allowed
if (lang == 'ge') {
    var depText = 'Dieses Ticket wird in den Status \'Techniker eingesetzt\' verschoben. Der Fitnessstudio-Betreiber wird über diese Änderung benachrichtigt.'; // German
} else if (lang == 'po') {
    var depText = 'Este bilhete será movido para o status \'Técnico Designado\'. O operador da academia será notificado dessa alteração.'; // Portuguese
} else if (lang == 'sp') {
    var depText = 'Este ticket se moverá al estado \'Técnico Desplegado\'. El operador del gimnasio será notificado de este cambio.'; // Spanish
} else if (lang == 'bul') {
    var depText = 'Този билет ще бъде преместен в статус \'Разпределен техник\'. Операторът на фитнеса ще бъде уведомен за тази промяна.'; // Bulgarian
} else if (lang == 'it') {
    var depText = 'Questo ticket sarà spostato allo stato \'Tecnico Assegnato\'. L\'operatore della palestra sarà informato di questa modifica.'; // Italian
} else if (lang == 'fr') {
    var depText = 'Ce ticket sera déplacé à l\'état \'Technicien Déployé\'. L\'opérateur de la salle de sport sera informé de ce changement.'; // French
}  else if (lang == 'ar') {
var depText = 'سيتم نقل هذه التذكرة إلى الحالة الفني المنفذ. سيتم إبلاغ مشغل صالة الرياضة بتلك التغييرات';

}  else if (lang == 'ja') {
var depText = 'このチケットは「エンジニアが実行中」の状態に移行されます。 これらの変更はジムのオペレータに通知されます。';
} else if (lang == 'tu') {
var depText = 'Bu bilet "Mühendis Çalışıyor" durumuna geçecektir. Bu değişiklikler Jim Operatörüne bildirilecektir.';

}else {
    // Default to the original text if the language code is not recognized
    var depText = 'This ticket will be moved to \'Technician Deployed\' status. The Gym Operator will be notified this change has been made.'; // English
}


navigator.notification.alert(
    depText,  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);


function alertDismissed() {
    // do something

var uuid = localStorage.getItem('uuid');
var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');
var id = 'other';
var englineerEmailToInv = '';


$.ajax({
    url: ''+host+'sp-postUpdateTicketDeploy-new.php?email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'&id='+id+'&englineerEmailToInv='+englineerEmailToInv+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){
              //alert(JSON.stringify(data));

var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

      var json = JSON.stringify(data);

console.log(json);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);

$('.button').prop('disabled', false);
$('.loaderIcon').hide();


if(parsed_data['status'] == 'OK'){

    $('.englineerEmailToInv').val('');

var notify = function() {
  //ons.notification.alert('You have successfully added a note.');
  var lang = localStorage.getItem('lang');



var confirmationMessage;

if (lang == 'ge') {
    confirmationMessage = 'Vielen Dank für die Bestätigung.';
} else if (lang == 'po') {
    confirmationMessage = 'Obrigado por confirmar.';
} else if (lang == 'sp') {
    confirmationMessage = 'Gracias por confirmar.';
} else if (lang == 'bul') {
    confirmationMessage = 'Благодаря за потвърждението.';
} else if (lang == 'it') {
    confirmationMessage = 'Grazie per la conferma.';
} else if (lang == 'fr') {
    confirmationMessage = 'Merci de confirmer.';
}  else if (lang == 'ar') {
    confirmationMessage = 'شكرا للتأكيد';
}   else if (lang == 'ja') {
    confirmationMessage = '確認していただきありがとうございます';
}   else if (lang == 'tu') {
    confirmationMessage = 'Onayladığınız için teşekkür ederiz.';

}else {
    // Default to the original text if the language code is not recognized
    confirmationMessage = 'Thank you for confirming.';
}

// Now you can use the variable confirmationMessage in your code.
ons.notification.toast(confirmationMessage, { timeout: 1500, animation: 'fall' });

};

notify();

document.querySelector('#myNavigator').popPage();

}else{

    function alertDismissed() {
    // do something
}

navigator.notification.alert(
    JSON.stringify(parsed_data['msg']),  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);


}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );

    }
});
}


}


}
}
});


//deploy technician
$(document).on('click', '.ptrbtn', function(e){ 

if(localStorage.getItem('page_type') == 'parts required'){

}else{




}


});


function partsRequired(){

    var uType = localStorage.getItem('usertype');
    var role = localStorage.getItem('role');

    if(uType == 'Gym Operator'){

    }else{

//we gonna check if the ticket is ad-hoc
if(localStorage.getItem('ticketType') == 'ad-hoc'){

var uuid = localStorage.getItem('uuid-close');
var partsReq = 1;
var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

var lang = localStorage.getItem('lang');


if (lang == 'ge') {
    navigator.notification.confirm(
        'Wenn Teile benötigt werden, wird ein neues Ticket erstellt.', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Bestätigen',           // title
        ['Abbrechen', 'OK']     // buttonLabels
    );
} else if (lang == 'po') {
    navigator.notification.confirm(
        'Se forem necessárias peças, será criado um novo ticket.', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Confirmar',           // title
        ['Cancelar', 'OK']     // buttonLabels
    );
} else if (lang == 'sp') {
    navigator.notification.confirm(
        'Si se necesitan piezas, se creará un nuevo ticket.', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Confirmar',           // title
        ['Cancelar', 'OK']     // buttonLabels
    );
} else if (lang == 'bul') {
    navigator.notification.confirm(
        'Ако са необходими части, ще бъде създаден нов билет.', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Потвърждение',           // title
        ['Отказ', 'OK']     // buttonLabels
    );
} else if (lang == 'it') {
    navigator.notification.confirm(
        'Se sono necessarie parti, verrà creato un nuovo ticket.', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Conferma',           // title
        ['Annulla', 'OK']     // buttonLabels
    );
} else if (lang == 'fr') {
    navigator.notification.confirm(
        'Si des pièces sont nécessaires, un nouveau ticket sera créé.', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Confirmer',           // title
        ['Annuler', 'OK']     // buttonLabels
    );
}  else if (lang == 'ar') {
navigator.notification.confirm(
    'إذا كانت هناك أجزاء مطلوبة، سيتم إنشاء تذكرة جديدة', // message
    onConfirm,            // callback to invoke with the index of the button pressed
    'تأكيد',           // title
    ['إلغاء', 'حسنًا']     // buttonLabels
);

}  else if (lang == 'ja') {
navigator.notification.confirm(
    '必要な部品がある場合、新しいチケットが作成されます', // メッセージ
    onConfirm,            // ボタンが押されたときに呼び出すコールバック
    '確認',           // タイトル
    ['キャンセル', 'はい']     // ボタンラベル
);
}  else if (lang == 'tu') {
navigator.notification.confirm(
    'Gerekli parçalar varsa, yeni bir bilet oluşturulur.', // Mesaj
    onConfirm,            // Butona basıldığında çağrılacak geri çağırma işlevi
    'Onaylama',           // Başlık
    ['İptal', 'Evet']     // Buton Etiketleri
);

}else {
    // Default to the original text if the language code is not recognized
    navigator.notification.confirm(
        'If parts are required, this ticket will be moved to \'Parts Required\' tickets.', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Confirm',           // title
        ['Cancel', 'OK']     // buttonLabels
    );
}

function onConfirm(buttonIndex) {
    if(buttonIndex === 2){

        //submit parts required

var uuid = localStorage.getItem('uuid-close');

var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

$(this).prop('disabled', true);
var pmodal = document.getElementById('preloaderModal');
pmodal.show();


var partsReq = 1;

serial_numbers =[];

var des = JSON.stringify(descriptions);
var ser = JSON.stringify(serial_numbers);


console.log(''+host+'closeTicket.php?email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'&partsReq='+partsReq+'&serial_numbers='+ser+'&descriptions='+des+'&sla='+JSON.stringify(results)+'&output=');

$.ajax({
    url: ''+host+'closeTicket.php?email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'&partsReq='+partsReq+'&serial_numbers='+ser+'&descriptions='+des+'&sla='+JSON.stringify(results)+'&output=',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){
var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
             console.log(JSON.stringify(data));

      var json = JSON.stringify(data);


     console.log(json);
      //return false;

      

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);

$('.button').prop('disabled', false);
$('.loaderIcon').hide();


if(parsed_data['status'] == 'OK'){


$('.note').val('');


var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};

var notify = function() {
  //ons.notification.alert('You have successfully closed this ticket.');

  var lang = localStorage.getItem('lang');



if (lang == 'it') {
    ons.notification.toast('Hai chiuso con successo questo ticket.', { timeout: 3000, animation: 'fall' });
} else if (lang == 'ge') {
    ons.notification.toast('Sie haben dieses Ticket erfolgreich geschlossen.', { timeout: 3000, animation: 'fall' });
} else if (lang == 'bul') {
    ons.notification.toast('Успешно затворихте този билет.', { timeout: 3000, animation: 'fall' });
} else if (lang == 'fr') {
    ons.notification.toast('Vous avez fermé ce ticket avec succès.', { timeout: 3000, animation: 'fall' });
} else if (lang == 'sp') {
    ons.notification.toast('Ha cerrado este ticket con éxito.', { timeout: 3000, animation: 'fall' });
}  else if (lang == 'ar') {
    ons.notification.toast('لقد أغلقت هذه التذكرة بنجاح', { timeout: 3000, animation: 'fall' });
} else if (lang == 'ja') {
   ons.notification.toast('このチケットは正常に閉じられました', { timeout: 3000, animation: 'fall' });
} else if (lang == 'tu') {
   ons.notification.toast('Bu bilet başarıyla kapatıldı', { timeout: 3000, animation: 'fall' });

}else {
    // Default to the original text if the language code is not recognized
    ons.notification.toast('You have successfully moved this ticket to parts required.', { timeout: 3000, animation: 'fall' });
}

   
};

notify();


//document.querySelector('#myNavigator').pages[3].remove();
document.querySelector('#myNavigator').popPage();


}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});



    }
}



///end of closing an ad-hoc ticket
}


    var page = localStorage.getItem('page_type');

if(page == 'parts required'){
}else{

var uuid = localStorage.getItem('uuid-close');
var partsReq = 1;
var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');
var pmodal = document.getElementById('preloaderModal');
pmodal.show();
if(partsReq == 1){

  $('.hiddenHead').show();
  $('.assBtns2').remove();


$.ajax({
    url: ''+host+'getTicket.php?email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
      var json = JSON.stringify(data);

      //console.log(json);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);

console.log(data);

localStorage.setItem('current-viewing-assets', json);

for(i=0;i<parsed_data.ticket.assets.length;i++){


   var full_name = parsed_data.ticket.assets[i].full_name;

   var description = parsed_data.ticket.assets[i].description

    var serial_number = parsed_data.ticket.assets[i].serial_number;


    var complete = parsed_data.ticket.assets[i].complete;

    var comp = '';

   
//var img = parsed_data.ticket.assets[i].image['thumb'];

var innernotes = parsed_data.ticket.assets[i].notes;
var trashed = parsed_data.ticket.assets[i].trashed;


innernotes = JSON.stringify(innernotes);

var uType = localStorage.getItem('usertype');

if(trashed == true){
}else{
    localStorage.setItem('addAsset-serial', serial_number);



    function onConfirm(buttonIndex) {
    if(buttonIndex === 2){

        //submit parts required

var uuid = localStorage.getItem('uuid-close');

var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

$(this).prop('disabled', true);
var pmodal = document.getElementById('preloaderModal');
pmodal.show();


var partsReq = 1;

serial_numbers =[];
serial_numbers.push(serial_number);

var des = JSON.stringify(descriptions);
var ser = JSON.stringify(serial_numbers);

$.ajax({
    url: ''+host+'closeTicket.php?email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'&partsReq='+partsReq+'&serial_numbers='+ser+'&descriptions='+des+'&sla='+JSON.stringify(results)+'&output=',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){
var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
             console.log(JSON.stringify(data));

      var json = JSON.stringify(data);


     console.log(json);
      //return false;

      

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);

$('.button').prop('disabled', false);
$('.loaderIcon').hide();


if(parsed_data['status'] == 'OK'){


$('.note').val('');


var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};

var notify = function() {
  //ons.notification.alert('You have successfully closed this ticket.');

  var lang = localStorage.getItem('lang');


if (lang == 'it') {
    ons.notification.toast('Hai chiuso con successo questo ticket.', { timeout: 3000, animation: 'fall' });
} else if (lang == 'ge') {
    ons.notification.toast('Sie haben dieses Ticket erfolgreich geschlossen.', { timeout: 3000, animation: 'fall' });
} else if (lang == 'bul') {
    ons.notification.toast('Успешно затворихте този билет.', { timeout: 3000, animation: 'fall' });
} else if (lang == 'fr') {
    ons.notification.toast('Vous avez fermé ce ticket avec succès.', { timeout: 3000, animation: 'fall' });
} else if (lang == 'sp') {
    ons.notification.toast('Ha cerrado este ticket con éxito.', { timeout: 3000, animation: 'fall' });
}  else if (lang == 'ar') {
    ons.notification.toast('لقد أغلقت هذه التذكرة بنجاح', { timeout: 3000, animation: 'fall' });
}   else if (lang == 'ja') {
    ons.notification.toast('このチケットは正常に閉じられました', { timeout: 3000, animation: 'fall' });
}   else if (lang == 'tu') {
    ons.notification.toast('Bu bilet başarıyla kapatıldı', { timeout: 3000, animation: 'fall' });

} else {
    // Default to the original text if the language code is not recognized
    ons.notification.toast('You have successfully moved this ticket to parts required.', { timeout: 3000, animation: 'fall' });
}

   
};

notify();


//document.querySelector('#myNavigator').pages[3].remove();
document.querySelector('#myNavigator').popPage();


}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});



    }
}

var lang = localStorage.getItem('lang');


if (lang == 'ge') {
    navigator.notification.confirm(
        'Wenn Teile benötigt werden, wird ein neues Ticket erstellt.', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Bestätigen',           // title
        ['Abbrechen', 'OK']     // buttonLabels
    );
} else if (lang == 'po') {
    navigator.notification.confirm(
        'Se forem necessárias peças, será criado um novo ticket.', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Confirmar',           // title
        ['Cancelar', 'OK']     // buttonLabels
    );
} else if (lang == 'sp') {
    navigator.notification.confirm(
        'Si se necesitan piezas, se creará un nuevo ticket.', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Confirmar',           // title
        ['Cancelar', 'OK']     // buttonLabels
    );
} else if (lang == 'bul') {
    navigator.notification.confirm(
        'Ако са необходими части, ще бъде създаден нов билет.', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Потвърждение',           // title
        ['Отказ', 'OK']     // buttonLabels
    );
} else if (lang == 'it') {
    navigator.notification.confirm(
        'Se sono necessarie parti, verrà creato un nuovo ticket.', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Conferma',           // title
        ['Annulla', 'OK']     // buttonLabels
    );
} else if (lang == 'fr') {
    navigator.notification.confirm(
        'Si des pièces sont nécessaires, un nouveau ticket sera créé.', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Confirmer',           // title
        ['Annuler', 'OK']     // buttonLabels
    );
}  else if (lang == 'ar') {
navigator.notification.confirm(
    'إذا كانت هناك قطع مطلوبة، سيتم إنشاء تذكرة جديدة', // message
    onConfirm,            // callback to invoke with the index of the button pressed
    'تأكيد',           // title
    ['إلغاء', 'حسنا']     // buttonLabels
);

}  else if (lang == 'ja') {
navigator.notification.confirm(
    '必要な部品がある場合、新しいチケットが作成されます', // message
    onConfirm,            // 押されたボタンのインデックスを引き出すためのコールバック
    '確認',           // title
    ['キャンセル', 'OK']     // buttonLabels
);
}  else if (lang == 'tu') {
navigator.notification.confirm(
    'Gerekli parçalar varsa yeni bir bilet oluşturulacak', // mesaj
    onConfirm,            // tıklanan düğmenin dizinini döndüren geri çağrı
    'Onay',           // başlık
    ['İptal', 'Tamam']     // düğme etiketleri
);

}else {
    // Default to the original text if the language code is not recognized
    navigator.notification.confirm(
        'If parts are required, this ticket will be moved to \'Parts Required\' tickets.', // message
        onConfirm,            // callback to invoke with the index of the button pressed
        'Confirm',           // title
        ['Cancel', 'OK']     // buttonLabels
    );
}

}
}



    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});


}

}

}

}




$(document).on('focus', '.footerMsgNote', function(){ 

$(this).val('');

});

$(document).on('focus', '.asset_note', function(){ 

$(this).val('');

});


///new cod here 
$(document).on('focus', 'textarea', function(){ 
 $('.updateTicketBtn').removeClass('microphopne');
$('.sIconMic').hide();
$('.sIcon').show();

if (Keyboard.isVisible) {
 $('.updateTicketBtn').removeClass('microphopne');
$('.sIcon').show();
}

});


   /*$(document).on('focusin touchstart', '.asset_note', function() {
        console.log('Focusin or Touchstart event triggered');
        $(this).focus();
    });

    $(document).on('click', '.asset_note', function() {
        console.log('Click event triggered');
        $(this).focus();
    });*/


//selecting asset in the manually raise ticket section
$(document).on('change', '.assetsSelect', function(){ 




var lang = localStorage.getItem('lang');


if (lang == 'ge') {
    $('.chooseTxt').text('Ausgewähltes Gerät');
} else if (lang == 'po') {
    $('.chooseTxt').text('Dispositivo Selecionado');
} else if (lang == 'sp') {
    $('.chooseTxt').text('Dispositivo Seleccionado');
} else if (lang == 'bul') {
    $('.chooseTxt').text('Избрано Устройство');
} else if (lang == 'it') {
    $('.chooseTxt').text('Dispositivo Selezionato');
} else if (lang == 'fr') {
    $('.chooseTxt').text('Appareil Sélectionné');
}  else if (lang == 'ar') {
    $('.chooseTxt').text('الجهاز المحدد');
}  else if (lang == 'ja') {
    $('.chooseTxt').text('選択したデバイス');
}  else if (lang == 'tu') {
   $('.chooseTxt').text('Seçilen Cihazlar');

} else {
    // Default to the original text if the language code is not recognized
    $('.chooseTxt').text('Selected Device');
}

var sel = $(this).val();

if(sel == 'other'){

$('.whoSendm').addClass('disabled-div');
$('.intwhom').removeClass('disabled-div');
$('.tawhom').removeClass('disabled-div');

//$('.intwhom').show();
$('.hiddenField').show();
var pr = localStorage.getItem('permissions_raise_internal_ticket');
if(pr == 'false' || pr == false){
$('.chooseAdminTicketSection').hide();


}else{
$('.chooseAdminTicketSection').show();

}

$('.serviceContactHolder').hide();
//$('.tyselectedIndicator').fadeOut();
//$('.intwhom').append('<div class="tyselectedIndicator"><ons-icon icon="fa-check"></ons-icon></div>');

$('.tyselectedIndicator').remove();
$('.hiddenField').show();
$('.chooseAdminTicketSection').hide();
$('.serviceContactHolder').hide();
$('.chooseTechSection').hide();

function countVisibleElementsByClassName(className) {
  // Get all elements with the specified class name
  var elements = document.getElementsByClassName(className);
  var visibleElements = [];

  // Loop through the elements and count only those that are visible
  for (var i = 0; i < elements.length; i++) {
    var element = elements[i];
    if (isVisible(element)) {
      visibleElements.push(element);
    }
  }

  // Click on the element if there's only one visible element
  if (visibleElements.length === 1) {
    visibleElements[0].click();
  }

  return visibleElements.length;
}

// Helper function to check if an element is visible
function isVisible(element) {
  return element.offsetParent !== null;
}

// Example usage:
var className = 'whoSendm';
var visibleCount = countVisibleElementsByClassName(className);
//alert('Number of visible elements with class "' + className + '": ' + visibleCount);

}else{


var pmodal = document.getElementById('preloaderModal');
pmodal.show();

//$('.intwhom').hide();
//$('.tyselectedIndicator').remove();


$('.whoSendm').removeClass('disabled-div');


//$('.serviceContactHolder').show();

var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

$.ajax({
    url: ''+host+'getAsset.php?serial='+sel+'&email='+email+'&accesstoken='+accesstoken+'&force=1',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

    var json = JSON.stringify(data);

     //var obj = parseJSON(data);
  var parsed_data = JSON.parse(data);

  var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

if(parsed_data['status'] == 'OK'){



if(parsed_data.asset['open_ticket'] == null){


  $('.note').val('');

var serial = parsed_data.asset['serial_number'];

var active_seller_packages = parsed_data.asset['active_seller_packages'];

console.log(JSON.stringify(parsed_data.asset['active_seller_packages']));

count = _.countBy(active_seller_packages, obj => obj.lot_title !== '');


$('.addAassetBtn').attr('data-serial', serial);


var assetSerial = serial;

var max_spend_percentage = parsed_data.asset['max_spend_percentage'];

if (max_spend_percentage > 100){

$('.hiddenField').hide();

var lang = localStorage.getItem('lang');


function alertDismissed() {
    // do something
}

if (lang == 'ge') {
    navigator.notification.alert(
        'Das maximale Ausgabenbudget für Asset ' + assetSerial + ' wurde erreicht. Bitte erhöhen Sie das maximale Ausgabenlimit für diesen Vermögenswert.',  // message
        alertDismissed,         // callback
        'Achtung',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'po') {
    navigator.notification.alert(
        'O orçamento máximo de gastos para o ativo ' + assetSerial + ' foi atingido. Por favor, aumente o limite máximo de gastos para este ativo.',  // message
        alertDismissed,         // callback
        'Atenção',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'sp') {
    navigator.notification.alert(
        'El presupuesto máximo de gastos para el activo ' + assetSerial + ' se ha alcanzado. Por favor, aumente el límite máximo de gastos para este activo.',  // message
        alertDismissed,         // callback
        'Atención',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'bul') {
    navigator.notification.alert(
        'Максималният бюджет за разходи за актив ' + assetSerial + ' е достигнат. Моля, увеличете максималния бюджет за този актив.',  // message
        alertDismissed,         // callback
        'Внимание',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'it') {
    navigator.notification.alert(
        'Il budget massimo di spesa per l\'asset ' + assetSerial + ' è stato raggiunto. Si prega di aumentare il limite massimo di spesa per questo asset.',  // message
        alertDismissed,         // callback
        'Attenzione',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'fr') {
    navigator.notification.alert(
        'Le budget de dépenses maximum pour l\'actif ' + assetSerial + ' a été atteint. Veuillez augmenter la limite de dépenses maximale pour cet actif.',  // message
        alertDismissed,         // callback
        'Attention',            // title
        'OK'                  // buttonName
    );
}  else if (lang == 'ar') {
navigator.notification.alert(
    'تم الوصول إلى الحد الأقصى للميزانية المخصصة للنفقات للعنصر ' + assetSerial + '. يرجى زيادة الحد الأقصى للنفقات لهذا العنصر',  // message
    alertDismissed,         // callback
    'تنبيه',            // title
    'حسناً'                  // buttonName
);

}  else if (lang == 'ja') {
navigator.notification.alert(
    'この資産（' + assetSerial + '）の費用割り当て予算の上限に達しました。この資産の費用割り当て予算の上限を増やしてください。',
    alertDismissed,
    '警告',
    '了解'
);
}  else if (lang == 'tu') {
navigator.notification.alert(
    'Bu varlığın (' + assetSerial + ') maliyet tahsis bütçesinin sınırına ulaşıldı. Bu varlığın maliyet tahsis bütçesinin sınırını artırın.',
    alertDismissed,
    'Uyarı',
    'Anladım'
);

}else {
    // Default to the original text if the language code is not recognized
    navigator.notification.alert(
        'The maximum spend budget has been reached for asset ' + assetSerial + '. Please raise the maximum spend limit for this asset.',  // message
        alertDismissed,         // callback
        'Attention',            // title
        'OK'                  // buttonName
    );
}

}//else{

$('.tyselectedIndicator').remove();
$('.hiddenField').show();
$('.chooseAdminTicketSection').hide();
$('.serviceContactHolder').hide();
$('.chooseTechSection').hide();

var fullname = parsed_data.asset['full_name'];

var active_seller_packages = parsed_data.asset['active_seller_packages'];
$(".serviceConractSelect").empty();



    if (parsed_data.asset.active_seller_packages.length === 1) {
        // Only one ticket_admins
        //alert('there is only 1 SP');
       $('.spwhom').click();
       $('.serviceContactHolder').hide();

    } else if (parsed_data.asset.active_seller_packages.length > 1) {
        // More than one ticket_admins
        //alert('there are multiple SPs');
    } else {
        // No ticket_admins
        //alert('there is no SP');
    }

console.log(JSON.stringify(parsed_data.asset.active_seller_packages));

for(i=0;i<parsed_data.asset.active_seller_packages.length;i++){




var cname= parsed_data.asset.active_seller_packages[i].buyer.buyer_profile.company_name;
var lot_title = parsed_data.asset.active_seller_packages[i].lot_title;

//adding sps here
$('.serviceConractSelect').append('<option value="'+lot_title+'">'+lot_title+' - '+cname+'</option>');

}

//}


}else{


    var lang = localStorage.getItem('lang');


var alertTitle, alertMessage;

if (lang == 'ge') {
    alertTitle = 'Achtung';
    alertMessage = 'Für dieses Gerät wurde bereits ein Serviceticket erstellt';
} else if (lang == 'po') {
    alertTitle = 'Atenção';
    alertMessage = 'Já foi criado um ticket de serviço para este ativo.';
} else if (lang == 'sp') {
    alertTitle = 'Atención';
    alertMessage = 'Ya se ha creado un ticket de servicio para este activo.';
} else if (lang == 'bul') {
    alertTitle = 'Внимание';
    alertMessage = 'Вече е създаден билет за обслужване за този актив.';
} else if (lang == 'it') {
    alertTitle = 'Attenzione';
    alertMessage = 'È già stato creato un ticket di servizio per questa risorsa.';
} else if (lang == 'fr') {
    alertTitle = 'Attention';
    alertMessage = 'Un ticket de service a déjà été créé pour cet actif.';
}  else if (lang == 'ar') {
alertTitle = 'تنبيه';
alertMessage = 'تم بالفعل إنشاء تذكرة خدمة لهذا العنصر';
}  else if (lang == 'ja') {
alertTitle = '警告';
alertMessage = 'このアイテムのサービスチケットはすでに作成されています。';
}  else if (lang == 'tu') {
var alertTitle = 'Uyarı';
var alertMessage = 'Bu öğenin hizmet bileti zaten oluşturulmuştur.';

}else {
    // Default to English if the language code is not recognized
    alertTitle = 'Warning';
    alertMessage = 'This asset is already in an open ticket!';
}

Swal.fire({
    title: alertTitle,
    icon: 'warning',
    html: alertMessage,
    showCloseButton: false,
    showCancelButton: false,
    focusConfirm: false,
});

$('.hiddenField').hide();


}




}else{

console.log(data);
var parsed_data = JSON.parse(data);

$('.hiddenField').hide();

function alertDismissed() {

}

navigator.notification.alert(
    parsed_data['msg'],  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);

}




    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});

}


});



$(document).on('click', '.addImgManual', function(e){ 

e.preventDefault();


var lang = localStorage.getItem('lang');



if($('.video-container').length > 0 || $('.videoPrev img').length > 0){


if (lang == 'ge') {
    navigator.notification.alert(
        "Bitte fügen Sie nur 1 Medium des Fehlers hinzu, wenn Sie ein Ticket erstellen. Sie können weitere Medien hinzufügen, sobald Sie das Ticket erstellt haben.",  // message
        alertDismissed,         // callback
        'Achtung',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'po') {
    navigator.notification.alert(
        "Proszę dodawać tylko 1 medium błędu podczas zgłaszania zlecenia. Możesz dodać więcej mediów po zgłoszeniu zlecenia.",  // message
        alertDismissed,         // callback
        'Uwaga',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'sp') {
    navigator.notification.alert(
        "Por favor, añade solo 1 medio del fallo al crear un ticket. Puedes añadir más medios una vez hayas creado el ticket.",  // message
        alertDismissed,         // callback
        'Atención',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'bul') {
    navigator.notification.alert(
        "Моля, добавете само 1 медия на грешката при подаване на билет. Можете да добавите повече медии, след като сте подали билета.",  // message
        alertDismissed,         // callback
        'Внимание',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'it') {
    navigator.notification.alert(
        "Si prega di aggiungere solo 1 media del difetto quando si apre un ticket. È possibile aggiungere ulteriori media una volta aperto il ticket.",  // message
        alertDismissed,         // callback
        'Attenzione',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'fr') {
    navigator.notification.alert(
        "Veuillez ajouter seulement 1 média du défaut lors de l'ouverture d'un ticket. Vous pouvez ajouter plus de médias une fois le ticket ouvert.",  // message
        alertDismissed,         // callback
        'Attention',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'ar') {
    navigator.notification.alert(
        "يرجى إضافة ميديا واحدة فقط للخلل عند رفع تذكرة. يمكنك إضافة مزيد من الميديا بمجرد رفع التذكرة.",  // message
        alertDismissed,         // callback
        'تنبيه',            // title
        'موافق'                  // buttonName
    );
} else if (lang == 'ja') {
    navigator.notification.alert(
        "チケットを作成する際には、不具合のメディアを1つだけ追加してください。チケットを作成した後は、複数のメディアを追加できます。",  // message
        alertDismissed,         // callback
        '注意',            // title
        'OK'                  // buttonName
    );
}else if (lang == 'tu') {
navigator.notification.alert(
    "Bir bilet oluştururken, yalnızca bir medya ekleyin. Bilet oluşturulduktan sonra, birden fazla medya ekleyebilirsiniz.",
    alertDismissed,
    'Dikkat',
    'OK'
);

} else {
    navigator.notification.alert(
        "Please only add 1 media of the fault when raising a ticket. You can add more media once you have raised the ticket.",  // message
        alertDismissed,         // callback
        'Attention',            // title
        'OK'                  // buttonName
    );
}


function alertDismissed() {}

return;
}




var useCameratext = 'Use Camera';
var selectGaltxt = 'Use Gallery';
var  recordVideotxt = 'Record Video';
var cl = 'Cancel';
var ttle = '';

if (lang == 'ge') {
    useCameratext = 'Kamera verwenden';
    selectGaltxt = 'Galerie verwenden';
    recordVideotxt = 'Video aufnehmen';
    cl = 'Abbrechen';
    ttle = '';
} else if (lang == 'po') {
    useCameratext = 'Usar câmera';
    selectGaltxt = 'Usar galeria';
    recordVideotxt = 'Gravar vídeo';
    cl = 'Cancelar';
    ttle = '';
} else if (lang == 'sp') {
    useCameratext = 'Usar cámara';
    selectGaltxt = 'Usar galería';
    recordVideotxt = 'Grabar vídeo';
    cl = 'Cancelar';
    titleText = '';
} else if (lang == 'bul') {
    useCameratext = 'Използване на камера';
    selectGaltxt = 'Използване на галерия';
    recordVideotxt = 'Запис на видео';
    cl = 'Отказ';
    ttle = '';
} else if (lang == 'it') {
    useCameratext= 'Usa fotocamera';
    selectGaltxt = 'Usa galleria';
    recordVideotxt = 'Registrare video';
    cl = 'Annulla';
    ttle = '';
} else if (lang == 'fr') {
    useCameratext = 'Utiliser l\'appareil photo';
    selectGaltxt = 'Utiliser la galerie';
    recordVideotxt = 'Enregistrer une vidéo';
    cl = 'Annuler';
    ttle = '';
}
else if (lang == 'ar') {
useCameratext = 'استخدام الكاميرا';
selectGaltxt = 'استخدام المعرض';
recordVideotxt = 'تسجيل فيديو';
cl = 'إلغاء';
    ttle = '';
}else if (lang == 'ja') {
useCameratext = 'カメラを使用する';
selectGaltxt = 'ギャラリーを選択する';
recordVideotxt = 'ビデオを録画する';
cl = 'キャンセル';
ttle = '';
}else if (lang == 'tu') {
var useCameratext = 'Kamerayı kullan';
var selectGaltxt = 'Galeriyi seç';
var recordVideotxt = 'Video kaydı yap';
var cl = 'İptal';
var ttle = '';

}

app.showFromObject = function () {
  ons.openActionSheet({
    title: ttle,
    cancelable: true,
    buttons: [
      selectGaltxt,
      useCameratext,
      recordVideotxt,
      {
        label: cl,
        icon: 'md-close',
        modifier: 'destructive'
      }
    ]
  }).then(function (index) { 

if (index == 0){


    navigator.camera.getPicture(onSuccess, onFail, { 
    quality: 100,
    destinationType: Camera.DestinationType.DATA_URL,
    sourceType: Camera.PictureSourceType.PHOTOLIBRARY,
    encodingType: Camera.EncodingType.JPEG,
       targetWidth: screen.width,
    targetHeight: screen.height,
    correctOrientation: true
});

function onSuccess(imageData) {

newTicketImgs.push("data:image/jpeg;base64,"+imageData+"");



/*var assetToAdd = {
  "serial": serial,
  "note": note,
  "image": "data:image/jpeg;base64,"+imageData+"",
}

newTicketasset.push(assetToAdd);*/

$('.imgPreview').append("<img class='imgPrevi' src='data:image/jpeg;base64,"+imageData+"' />");
newAddImgs.push('data:image/jpeg;base64,'+imageData);


}

function onFail(message) {

}




}

if (index == 1){

    navigator.camera.getPicture(onSuccess, onFail, { 
    quality: 100,
    destinationType: Camera.DestinationType.DATA_URL,
    sourceType: Camera.PictureSourceType.CAMERA,
    encodingType: Camera.EncodingType.JPEG,
       targetWidth: screen.width,
    targetHeight: screen.height,
    correctOrientation: true
});

function onSuccess(imageData) {

newTicketImgs.push("data:image/jpeg;base64,"+imageData+"");



/*var assetToAdd = {
  "serial": serial,
  "note": note,
  "image": "data:image/jpeg;base64,"+imageData+"",
}

newTicketasset.push(assetToAdd);*/

$('.imgPreview').append("<img src='data:image/jpeg;base64,"+imageData+"' />");
newAddImgs.push('data:image/jpeg;base64,'+imageData);
$('.TicketImgRaise').show();

}

function onFail(message) {

}

  

}else if(index == 2){


recordVideo();

}



   });
};


app.showFromObject();

});


//get my details here...
function getMyDetails(){


    var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');


function getDetails(host, email, accesstoken) {
    return new Promise((resolve, reject) => {
        $.ajax({
            url: `${host}getMyDetails.php?email=${email}&accesstoken=${accesstoken}`,
            type: 'GET',
            processData: false,
            success: function(data, textStatus, jQxhr) {
                console.log("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
                console.log(data);
                resolve(data);
            },
            error: function(jqXhr, textStatus, errorThrown) {
                reject(errorThrown);
            }
        });
    });
}

async function updateUserDetails() {
    try {
        const data = await getDetails(host, email, accesstoken);
        const parsed_data = JSON.parse(data);

        const first_name = parsed_data.details['first_name'];
        const last_name = parsed_data.details['last_name'];
        const company_name = parsed_data.details['company_name'] || ''; // Default to empty string if undefined
        let site_name = parsed_data.details['site_name'] || ''; // Default to empty string if undefined

        const fullName = `${first_name} ${last_name}`;
        const usertype = localStorage.getItem('usertype');
    
        if (usertype === 'Gym Operator') {
            $('.dash').html(`<span style=""><span style="font-weight:bold;">${site_name}</span> Dashboard</span>`);
        } else {
            $('.dash').html(`<span style=""><span style="font-weight:bold;">${company_name}</span> Dashboard</span>`);
        }
        $('.userNameHolder').html(`<span style="">${fullName}</span>`);
        const avatar_url = parsed_data.details['avatar_url'];

        if (avatar_url !== null) {
            $('.textCanvas').hide();
            $('.homeAvi').css('background-image', `url(${avatar_url})`);
        } else {
            const colors = ['#0a6125', '#00aeef', '#a5c432', '#3498DB'];
            const random_color = colors[Math.floor(Math.random() * colors.length)];
            const initials = fullName.split(' ').map(name => name[0]).join('').toUpperCase();

            const canvas = document.getElementById('textCanvas');
            const tCtx = canvas.getContext('2d');

            canvas.width = 40;
            canvas.height = 40;
            canvas.style.width = '40px';
            canvas.style.height = '40px';
            canvas.style.backgroundColor = random_color;

            let fontSize = 20;
            if (initials.length > 2) {
                fontSize = Math.max(10, 40 / initials.length); // Adjust font size based on the number of initials
            }

            tCtx.font = `${fontSize}px Arial`;
            tCtx.fillStyle = "#ffffff";

            // Measure the text width and height to center it
            const textWidth = tCtx.measureText(initials).width;
            const textHeight = fontSize; // Approximate the text height with font size

            // Calculate the x and y positions to center the text
            const xPosition = (canvas.width - textWidth) / 2;
            const yPosition = (canvas.height + textHeight) / 2 - 5; // Subtract 5 to adjust for visual centering

            tCtx.fillText(initials, xPosition, yPosition);
        }
    } catch (error) {
        console.log(error);
    }
}


updateUserDetails();


}

$(document).on('click', '.homeAvi, .userNameHolder', function(){ 
document.querySelector('#myNavigator').pushPage('my-details.html', { animation : 'lift' });
});


$(document).on('click', '.shareBtn', function(){ 


navigator.share({
    title: "Sharing "+appName+" App",
    text: "Hey, please check out this app. It is called "+appName+"",
    url: "https://"+appName+".org"
}).then((packageNames) => {
    if (packageNames.length > 0) {
        console.log("Shared successfully with activity", packageNames[0]);
    } else {
        console.log("Share was aborted");
    }
}).catch((err) => {
    console.error("Share failed:", err.message);
});


});


$(document).on('click', '.profileDetails', function(){ 
var vlu = $(this).attr('data-value');

    function alertDismissed() {

}

if($(this).hasClass('tel')){

        navigator.notification.alert(
    vlu,  // message
    alertDismissed,         // callback
    'Tel',            // title
    'OK'                  // buttonName
);
}

if($(this).hasClass('business')){
var companyNametxt = 'Company Name';

var lang = localStorage.getItem('lang');


if (lang == 'ge') {
    companyNameText = 'Name der Firma';
} else if (lang == 'po') {
    companyNameText = 'Nome da Empresa';
} else if (lang == 'sp') {
    companyNameText = 'Nombre de la Empresa';
} else if (lang == 'bul') {
    companyNameText = 'Име на фирмата';
} else if (lang == 'it') {
    companyNameText = 'Nome dell\'azienda';
} else if (lang == 'fr') {
    companyNameText = 'Nom de l\'entreprise';
} else if (lang == 'ar') {
    companyNameText = 'اسم الشركة';
} else if (lang == 'ja') {
    companyNameText = '会社名';
} else if (lang == 'tu') {
var companyNameText = 'Şirket Adı';

}else {
    // Default to the original text if the language code is not recognized
    companyNameText = 'Company Name';
}


navigator.notification.alert(
    vlu,  // message
    alertDismissed,         // callback
    companyNametxt,            // title
    'OK'                  // buttonName
);
}

if($(this).hasClass('mail')){
        navigator.notification.alert(
    vlu,  // message
    alertDismissed,         // callback
    'Email',            // title
    'OK'                  // buttonName
);
}

});


$(document).on('click', '.showProfileOptions', function(){ 



    var btn1 = 'Logout';
    var btn2 = 'Push Notification ID: '+localStorage.getItem('device_id');


app.showFromObject = function () {
  ons.openActionSheet({
    title: '',
    cancelable: true,
    buttons: [
        btn2,
      //btn1,
      {
        label: 'Cancel',
        icon: 'md-close'
      }
    ]
  }).then(function (index) { 

if(index == 3){


   $('.langHolder').removeClass('animated bounceOutDown');
   $('.pncircle').remove();
   var deviceToken = localStorage.getItem('device_id');
   localStorage.clear();
  
   var modal = document.getElementById('loginmodal');
   modal.show();

    document.querySelector('#myNavigator').popPage();



}

  });
};

app.showFromObject();

});


var hidecostDialog = function(id) {
  document
    .getElementById(id)
    .hide();
};


//transfer ticket
$(document).on('click', '.transferTicketBtn', function(){ 
var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');
var uuid = localStorage.getItem('uuid');

//create modal here for TA
    /*addSheetModal({
  modalContent: '<p style="text-align: center;" class="engTitle trn">Select an internal technician</p>'+
'<div class="card custom_card">'+
  '<select class="inps internalTechList"></select>'+
  '<div style="width:100%;display:inline-block;text-align:center;font-weight:bold;margin-bottom:10px;margin-top:10px;" class="trn">OR</div>'+
   '<div style="width:100%;display:inline-block;text-align:center;" class="trn">Invite a new technician</div>'+
   '<input type="email" class="englineerEmailToInv inps" placeholder="Email"/>'+
   '<button class="button button--large trn finalDeployEngBtnInternal">Deploy Technician</button>'+
'</div>'+


'<p style="text-align: center;" class="notAdhoc engTitle trn">Select the service provider in the list below to transfer the ticket.</p>'+
  '<div class="notAdhoc card custom_card">'+
  '<select class="inps transferTicket"></select>'+
'<button class="button button--large trn transferBtn">Transfer</button>'+
  
  '</div>'
});*/


addModernSheetModal({
    modalContent: '<p style="text-align: center;" class="engTitle trn">Select an internal technician</p>'+
    '<div class="card custom_card"><div class="modalInfo"><ons-icon icon="ion-ios-information-circle-outline"></ons-icon></div><div class="modalClose"><ons-icon icon="ion-ios-close"></ons-icon></div>'+
      '<select class="inps internalTechList"></select>'+
      '<div style="width:100%;display:inline-block;text-align:center;font-weight:bold;margin-bottom:10px;margin-top:10px;" class="trn">OR</div>'+
       '<div style="width:100%;display:inline-block;text-align:center;" class="trn">Invite a new technician</div>'+
       '<input type="email" class="englineerEmailToInv inps" placeholder="Email"/>'+
       '<button class="button button--large trn finalDeployEngBtnInternal">Deploy Technician</button>'+
    '</div>'+ 
    '<p style="text-align: center;" class="notAdhoc engTitle trn">Select the service provider in the list below to transfer the ticket.</p>'+
      '<div class="notAdhoc card custom_card">'+
      '<select class="inps transferTicket"></select>'+
    '<button class="button button--large trn transferBtn">Transfer</button>'+
      '</div>'
  });



var ticketType = localStorage.getItem('ticketType');

    if(ticketType == 'ad-hoc'){
$('.notAdhoc').hide();
    }
  
  var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);





var values = {
            'email': email,
            'accesstoken': accesstoken,
            'uuid': uuid,
    };

    //get internal techs here...
 $.ajax({
    url: ''+host+'getCareTakers.php',
    //dataType: 'text',
     //dataType: 'text',
    data: values,
    type: 'POST',
    success: function( data, textStatus, jQxhr ){

    var json = JSON.stringify(data);

    console.log(data);

     //var obj = parseJSON(data);
  var parsed_data = JSON.parse(data);
if(parsed_data['status'] == 'OK'){
  for(i=0;i<parsed_data.caretakers.length;i++){
var full_name = parsed_data.caretakers[i].name;
var id = parsed_data.caretakers[i].id;
var email = parsed_data.caretakers[i].email;

$('.internalTechList').append('<option class="internalTechListItem" value="'+id+'">'+email+' </option>');

  }
}else{

console.log(data);
var parsed_data = JSON.parse(data);

    var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

function alertDismissed() {

}

navigator.notification.alert(
    parsed_data['msg'],  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);

}
    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
    }
});



$.ajax({
    url: ''+host+'getTicket.php?email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

      var json = JSON.stringify(data);

      console.log(data);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);


for(i=0;i<parsed_data.ticket.assets.length;i++){

//new Maxi


//if (typeof active_seller_packages_array !== 'undefined' && active_seller_packages_array.length > 0 ) {
var active_seller_packages = parsed_data.ticket.assets[i].active_seller_packages;


active_seller_packages.forEach((e) => {

 var lot_title = e.lot_title;
 var company_name = e.buyer_company_name;

console.log(company_name);

var lang = localStorage.getItem('lang');


$('.transferTicket').empty();

setTimeout(doSomething, 1000);

function doSomething() {
$('.transferTicket').append('<option value="'+lot_title+'">'+company_name+'</option>');

}

});
//}



//getEngineers here if the ticket type is ad-hock

//murder program

/*var values = {
            'email': email,
            'accesstoken': accesstoken
    };

$.ajax({
    url: ''+host+'..getEngineer.php',
   //dataType: 'text',
    data: values,
    type: 'POST',
    success: function( data, textStatus, jQxhr ){
              //alert(JSON.stringify(data));
console.log(data);
      var json = JSON.stringify(data);



     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);

if(parsed_data['status'] == 'OK'){

if (typeof parsed_data.engineers !== 'undefined' && parsed_data.engineers.length > 0 ) {
    addSheetModal({
  modalContent: '<p style="text-align: center;" class="engTitle">Select an internal technician</p>'+
'<div class="card custom_card">'+
  '<ons-list class="enginnersList_m"></ons-list>'+
'</div>'+
  '<div style="width:100%;display:inline-block;text-align:center;font-weight:bold;margin-bottom:10px;margin-top:10px;" class="trn">OR</div>'+
  '<div style="width:100%;display:inline-block;text-align:center;" class="trn">Invite a new technician</div>'+

'<div class="card custom_card">'+
  '<input type="email" class="englineerEmailToInv inps" placeholder="Email"/>'+
  '</div>'+

  '<div class="card custom_card">'+
  '<button class="button button--large trn finalDeployEngBtn">Deploy Technician</button>'+
  '</div>'
});

}

//come back here addressFinder

  for(i=0;i<parsed_data.engineers.length;i++){
var id = parsed_data.engineers[i].id;
var email = parsed_data.engineers[i].email;
var status = parsed_data.engineers[i].status;
var name = parsed_data.engineers[i].name;


$('.enginnersList_m').append('<ons-list-item class="enginnersListItem" data-id="'+id+'" tappable>'+email+' ('+status+')</ons-list-item>');


  }




}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );

    }
});*/



}



    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
    }
});

});





$(document).on('click', '.transferBtn', function(){ 
var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');
var uuid = localStorage.getItem('uuid');
var sp = $('.transferTicket').val();

$.ajax({
    url: ''+host+'postTransferTicket.php?email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'&sp='+sp+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){
var parsed_data = JSON.parse(data);

console.log(data);
if(parsed_data['status'] == 'OK'){



        $('.page').removeClass('scaled');
$('.bottomToolbar').removeClass('scaled');
$('html').removeClass('blacked');
$('body').removeClass('blacked');
$('.modal-in').css('bottom', '-3850px');
$('.sheet-backdrop').removeClass('backdrop-in');
$('.demo-sheet-swipe-to-close,.demo-sheet-swipe-to-step').scrollTop(0,0);

    $('.englineerEmailToInv').val('');

var notify = function() {
  //ons.notification.alert('You have successfully closed this ticket.');
  var lang = localStorage.getItem('lang');


var successTransferMessage;

if (lang == 'ge') {
    successTransferMessage = 'Sie haben dieses Ticket erfolgreich übertragen.';
} else if (lang == 'po') {
    successTransferMessage = 'Você transferiu com sucesso este ticket.';
} else if (lang == 'sp') {
    successTransferMessage = 'Has transferido este ticket con éxito.';
} else if (lang == 'bul') {
    successTransferMessage = 'Успешно прехвърлихте този билет.';
} else if (lang == 'it') {
    successTransferMessage = 'Hai trasferito con successo questo ticket.';
} else if (lang == 'fr') {
    successTransferMessage = 'Vous avez transféré avec succès ce ticket.';
}  else if (lang == 'ar') {
    successTransferMessage = 'لقد قمت بنقل هذه التذكرة بنجاح';
}  else if (lang == 'ja') {
  successTransferMessage = 'このチケットを正常に転送しました';

}  else if (lang == 'tu') {
successTransferMessage = 'Bu bilet başarıyla aktarıldı.';


}else {
    // Default to the original text if the language code is not recognized
    successTransferMessage = 'You have successfully transferred this ticket.';
}

// Now you can use the variable successTransferMessage in your code.
ons.notification.toast(successTransferMessage, { timeout: 3000, animation: 'fall' });


};

notify();


//document.querySelector('#myNavigator').pages[3].remove();
document.querySelector('#myNavigator').popPage();

}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
    }
});

});



$(document).on('click', '.closeBtn ', function(){ 
var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');
     
var cost = $('.costInput').val();


//return false;

var des = JSON.stringify(descriptions);
var ser = localStorage.getItem('cur_ser');
var uuid = localStorage.getItem('uuid');
var partsReq = 0;


$.ajax({
    //url: ''+host+'closeTicket.php?email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'&partsReq='+partsReq+'&serial_numbers='+ser+'&descriptions='+des+'&sla='+JSON.stringify(results)+'&output=',
    url: ''+host+'new_closeTicket.php?cost='+cost+'&email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'&partsReq='+partsReq+'&serial_numbers='+ser+'&descriptions='+des+'&sla='+JSON.stringify(results)+'&output=',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
             console.log(data);

      var json = JSON.stringify(data);


     console.log(json);
      //return false;

      

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);

$('.button').prop('disabled', false);
$('.loaderIcon').hide();


if(parsed_data['status'] == 'OK'){


$('.note').val('');


var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};

var notify = function() {
  //ons.notification.alert('You have successfully closed this ticket.');
  var lang = localStorage.getItem('lang');


var successCloseMessage;

if (lang == 'ge') {
    successCloseMessage = 'Sie haben dieses Ticket erfolgreich geschlossen.';
} else if (lang == 'po') {
    successCloseMessage = 'Você fechou este ticket com sucesso.';
} else if (lang == 'sp') {
    successCloseMessage = 'Has cerrado este ticket con éxito.';
} else if (lang == 'bul') {
    successCloseMessage = 'Успешно затворихте този билет.';
} else if (lang == 'it') {
    successCloseMessage = 'Hai chiuso con successo questo ticket.';
} else if (lang == 'fr') {
    successCloseMessage = 'Vous avez fermé ce ticket avec succès.';
} else if (lang == 'ar') {
   successCloseMessage = 'لقد أغلقت هذه التذكرة بنجاح'
} else if (lang == 'ja') {
successTransferMessage = 'このチケットを正常に転送しました';

} else if (lang == 'tu') {
successTransferMessage = 'Bu bilet başarıyla transfer edildi.';


}else {
    // Default to the original text if the language code is not recognized
    successCloseMessage = 'You have successfully closed this ticket.';
}

// Now you can use the variable successCloseMessage in your code.
ons.notification.toast(successCloseMessage, { timeout: 3000, animation: 'fall' });
};

notify();


//document.querySelector('#myNavigator').pages[3].remove();
document.querySelector('#myNavigator').popPage();


}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});


});



///Submit New Ticket (manually)
$(document).on('click', '.submitTicketBtn_manually', function(){ 


    function getCurrentPageId() {
  var currentPage = document.querySelector('ons-navigator').topPage;
  return currentPage.id;
}

// Example usage
var currentPageId = getCurrentPageId();


if(currentPageId == 'raise-manually'){


function countVisibleElementsByClassName(className) {
  // Get all elements with the specified class name
  var elements = document.getElementsByClassName(className);
  var visibleElements = [];

  // Loop through the elements and count only those that are visible
  for (var i = 0; i < elements.length; i++) {
    var element = elements[i];
    if (isVisible(element)) {
      visibleElements.push(element);
    }
  }

  // Click on the element if there's only one visible element
  if (visibleElements.length === 1) {
    visibleElements[0].click();
  }

  return visibleElements.length;
}

// Helper function to check if an element is visible
function isVisible(element) {
  return element.offsetParent !== null;
}

// Example usage:
var className = 'whoSendm';
var visibleCount = countVisibleElementsByClassName(className);
//alert('Number of visible elements with class "' + className + '": ' + visibleCount);

}


if(localStorage.getItem('permissions_force_ticket_media') == 'true'){
if (!$('.videoPrev').html()) {
var lang = localStorage.getItem('lang');
var confirmationMessage;

if (lang == 'ge') {
    confirmationMessage = 'Bitte fügen Sie mindestens ein Medium zu diesem Ticket hinzu.';
} else if (lang == 'po') {
    confirmationMessage = 'Por favor, adicione pelo menos uma mídia a este bilhete.';
} else if (lang == 'sp') {
    confirmationMessage = 'Por favor, agregue al menos un medio a este ticket.';
} else if (lang == 'bul') {
    confirmationMessage = 'Моля, добавете поне един медиен файл към този билет.';
} else if (lang == 'it') {
    confirmationMessage = 'Si prega di aggiungere almeno un supporto a questo biglietto.';
} else if (lang == 'fr') {
    confirmationMessage = 'Veuillez ajouter au moins un média à ce billet.';
} else if (lang == 'ar') {
    confirmationMessage = 'يرجى إضافة وسائط واحدة على الأقل إلى هذه التذكرة.';
} else if (lang == 'ja') {
    confirmationMessage = 'このチケットには少なくとも1つのメディアを追加してください。';
} else if (lang == 'tu') {
    confirmationMessage = 'Lütfen bu bilete en az bir ortam ekleyin.';
} else {
    // Default to the original text if the language code is not recognized
    confirmationMessage = 'Please add at least one media to this ticket.';
}

// Now you can use the variable confirmationMessage in your code.
ons.notification.toast(confirmationMessage, { timeout: 2000, animation: 'fall' });
   return
}

}


asset_sps = [];
descriptions = [];
serial_numbers = [];

var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

var m_dis = $('.m_dis').val();
var serial = $('.assetsSelect').val();
var asset_sp = $('.serviceConractSelect').val();
var ticketAdmin = $('.ticketAdminSelect').val();
var caretaker = $('.inetrnalTechSelect').val();
var newCaretaker = $('.newTechnician').val();
asset_sps.push(asset_sp);
var newTicketAdmin = $('.newTicketAdmin').val();


if(m_dis == ''){

var lastPageContent = $('.page__content:last');
lastPageContent.scrollTop(0);
$(".m_dis").addClass("blinking");
    // Remove blinking class after 3 seconds
    setTimeout(function(){
        $(".m_dis").removeClass("blinking");
    }, 3000);
return;
}

serial_numbers = [];

descriptions.push(m_dis);
serial_numbers.push(serial);
var dis = JSON.stringify(descriptions);
var sers = JSON.stringify(serial_numbers);
var assSps = JSON.stringify(asset_sps);
var images = newAddImgs;
var singleSerial = serial_numbers[0];
var priority = $('.prioritySelect').val();
var values = {};




if (serial == 'other') {
    if (manualTicketType == 'int') {
        values = {
            'ticketMediaToSend': ticketMediaToSend,
            'caretaker': caretaker,
            'newCaretaker': newCaretaker,
            'type': 'ad-hoc',
            'sps': assSps,
            'email': email,
            'accesstoken': accesstoken,
            'serial_number': sers,
            'description': dis,
            'images': images,
            'singleSerial': singleSerial,
            'priority': priority,
            'fileName': fileName,
            'manualTicketType': manualTicketType
        };
    } else if (manualTicketType == 'ta') {



        values = {
            'ticketMediaToSend': ticketMediaToSend,
            'ticket_admin_new': newTicketAdmin,
            'ticket_admin': ticketAdmin,
            'type': 'ad-hoc',
            'sps': assSps,
            'email': email,
            'accesstoken': accesstoken,
            'serial_number': sers,
            'description': dis,
            'images': images,
            'singleSerial': singleSerial,
            'priority': priority,
            'fileName': fileName,
            'manualTicketType': manualTicketType,
        };
    }
} else {
    if (manualTicketType == 'sp') {
        values = {
            'ticketMediaToSend': ticketMediaToSend,
            'type': 'standard',
            'sps': assSps,
            'email': email,
            'accesstoken': accesstoken,
            'serial_number': sers,
            'description': dis,
            'images': images,
            'singleSerial': singleSerial,
            'priority': priority,
            'fileName': fileName,
        };
    } else if (manualTicketType == 'ta') {
if(newTicketAdmin != ''){
var values = {
    'ticketMediaToSend': ticketMediaToSend,
            'ticket_admin_new' : newTicketAdmin,
            'type': 'internal',
            'sps': assSps,
            'email': email,
            'accesstoken': accesstoken,
            'serial_number': sers,
            'description': dis,
            'images': images,
            'singleSerial': singleSerial,
            'priority': priority,
            'fileName': fileName,
    };
}else{

    var values = {
        'ticketMediaToSend': ticketMediaToSend,
            'ticketAdmin': ticketAdmin,
            'type': 'internal',
            'sps': assSps,
            'email': email,
            'accesstoken': accesstoken,
            'serial_number': sers,
            'description': dis,
            'images': images,
            'singleSerial': singleSerial,
            'priority': priority,
            'fileName': fileName,
    };

}


    } else if (manualTicketType == 'int') {
        values = {
            'ticketMediaToSend': ticketMediaToSend,
            'caretaker': caretaker,
            'newCaretaker': newCaretaker,
            'type': 'internalOnly',
            'sps': assSps,
            'email': email,
            'accesstoken': accesstoken,
            'serial_number': sers,
            'description': dis,
            'images': images,
            'singleSerial': singleSerial,
            'priority': priority,
            'fileName': fileName,
        };
    }
}

function uploadWithProgressBar(values) {
    var serverUrl = host + '...submitTicket.php';
    var formData = new FormData();

    // Append the values to the formData
    for (var key in values) {
        if (values.hasOwnProperty(key)) {
            if (Array.isArray(values[key])) {
                values[key].forEach((value, index) => {
                    formData.append(`${key}[${index}]`, value);
                });
            } else {
                formData.append(key, values[key]);
            }
        }
    }

    // Show and reset progress bar
    $('.customProgreesBar').removeClass('customProgreesBarHidden');
    $('.customProgreesBar').addClass('customProgreesBarShown');
    $('.progress-percentage').text('0%').show();
    $('.liveProgress').show();

    $.ajax({
        url: serverUrl,
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        xhr: function() {
            var xhr = new window.XMLHttpRequest();

            // Handle progress events
            xhr.upload.addEventListener("progress", function(evt) {
                if (evt.lengthComputable) {
                    var percentComplete = Math.round((evt.loaded / evt.total) * 100);
                    console.log(`Progress: ${percentComplete}%`);  // Log progress
                    document.querySelector('.customProgreesBar').value = percentComplete;
                    document.querySelector('.progress-percentage').textContent = percentComplete + '%';

                    // Adjust the position of the percentage text
                    var progressBarWidth = document.querySelector('.customProgreesBar').offsetWidth;
                    var leftPosition = (progressBarWidth * (percentComplete / 100));
                    document.querySelector('.progress-percentage').style.left = leftPosition + 'px';
                } else {
                    console.log('Unable to compute progress information since the total size is unknown');
                }
            }, false);

            xhr.addEventListener('readystatechange', function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    console.log('Upload complete');
                }
            });

            return xhr;
        },
        success: function(data, textStatus, jQxhr) {
            console.log(data);

            var pmodal = document.getElementById('preloaderModal');
            pmodal.hide();
            var parsed_data = JSON.parse(data);

            if (parsed_data['status'] == 'OK') {
                asset_sps = [];
                descriptions = [];
                serial_numbers = [];

                $('.button').prop('disabled', false);
                $('.loaderIcon').hide();

                var hideAlertDialog = function() {
                    document.getElementById('my-alert-dialog').hide();
                };

                var lang = localStorage.getItem('lang');
                var successSentMessage = getSuccessMessage(lang);

                // Now you can use the variable successSentMessage in your code.
                navigator.notification.alert(successSentMessage, alertDismissed, 'Success', 'OK');

                newAddImgs = [];
            } else {
                navigator.notification.alert(
                    parsed_data['msg'],  // message
                    alertDismissed,      // callback
                    '',                  // title
                    'OK'                 // buttonName
                );
            }

            // Hide progress bar
            $('.customProgreesBar').addClass('customProgreesBarHidden');
            $('.progress-percentage').hide();
            $('.hide').show();
        },
        error: function(jqXhr, textStatus, errorThrown) {
            console.log(errorThrown);

            // Hide progress bar
            $('.customProgreesBar').addClass('customProgreesBarHidden');
            $('.progress-percentage').hide();
            $('.hide').show();
        }
    });
}

function getSuccessMessage(lang) {
    switch(lang) {
        case 'ge': return 'Ihr Ticket wurde erfolgreich versendet.';
        case 'po': return 'Seu novo ticket foi enviado com sucesso.';
        case 'sp': return 'Su nuevo ticket ha sido enviado con éxito.';
        case 'bul': return 'Вашият нов билет е изпратен успешно.';
        case 'it': return 'Il tuo nuovo ticket è stato inviato con successo.';
        case 'fr': return 'Votre nouveau ticket a été envoyé avec succès.';
        case 'ar': return 'تم إرسال التذكرة الجديدة بنجاح';
        case 'ja': return '新しいチケットが正常に送信されました';
        case 'tu': return 'Yeni bilet başarıyla gönderildi.';
        default: return 'Your new ticket has been sent.';
    }
}

function alertDismissed() {
    document.querySelector('#myNavigator').popPage();
}



uploadWithProgressBar(values);
//console.log(JSON.stringify(values));
//return;
//var pmodal = document.getElementById('preloaderModal');
//pmodal.show();


    //console.log(images);
//submit ticket here

/*$.ajax({
    url: ''+host+'...submitTicket.php',
     //dataType: 'text',
    data: values,
    type: 'POST',
    success: function( data, textStatus, jQxhr ){


        console.log(data);

var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
      var json = JSON.stringify(data);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);


if(parsed_data['status'] == 'OK'){



asset_sps = [];
descriptions = [];
serial_numbers = [];

      $('.button').prop('disabled', false);
      $('.loaderIcon').hide();

var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};


var lang = localStorage.getItem('lang');


function alertDismissed() {
    document.querySelector('#myNavigator').popPage();
}

var successSentMessage;

if (lang == 'ge') {
    successSentMessage = 'Ihr Ticket wurde erfolgreich versendet.';
} else if (lang == 'po') {
    successSentMessage = 'Seu novo ticket foi enviado com sucesso.';
} else if (lang == 'sp') {
    successSentMessage = 'Su nuevo ticket ha sido enviado con éxito.';
} else if (lang == 'bul') {
    successSentMessage = 'Вашият нов билет е изпратен успешно.';
} else if (lang == 'it') {
    successSentMessage = 'Il tuo nuovo ticket è stato inviato con successo.';
} else if (lang == 'fr') {
    successSentMessage = 'Votre nouveau ticket a été envoyé avec succès.';
}  else if (lang == 'ar') {
    successSentMessage = 'تم إرسال التذكرة الجديدة بنجاح'
} else if (lang == 'ja') {
    successSentMessage = '新しいチケットが正常に送信されました';
} else if (lang == 'tu') {
    successSentMessage = 'Yeni bilet başarıyla gönderildi.';

}else {
    // Default to the original text if the language code is not recognized
    successSentMessage = 'Your new ticket has been sent.';
}

// Now you can use the variable successSentMessage in your code.
navigator.notification.alert(successSentMessage, alertDismissed, 'Success', 'OK');

newAddImgs =[];


}else{




function alertDismissed() {

}

navigator.notification.alert(
    parsed_data['msg'],  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);

//newAddImgs =[];

}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});*/

});



function getPermissions(){

var username = localStorage.getItem('email');
var refresh_token = localStorage.getItem('refreshtoken');


$.ajax({
    url: host + 'refresh-token-new.php',
    type: 'POST',
    data: {
        refresh_token: refresh_token,
        email: username
    },
    success: function(data, textStatus, jQxhr) {
        var parsed_data = JSON.parse(data);

        if (parsed_data['status'] == 'OK') {
            var permissions = parsed_data['permissions'];
            console.log(JSON.stringify(permissions));

            var pr = JSON.stringify(permissions.raise_internal_ticket);
            var pr2 = JSON.stringify(permissions.raise_adhoc_ticket);
            var pr3 = JSON.stringify(permissions.manage_engineers);
            var pr4 = JSON.stringify(permissions.manage_caretakers);
            var pr5 = JSON.stringify(permissions.assign_caretakers);
            var pr6 = JSON.stringify(permissions.assign_ticket_admins);
            var pr7 = JSON.stringify(permissions.manage_ticket_admins);
            var pr8 = JSON.stringify(permissions.raise_ticket);
            var pr9 = JSON.stringify(permissions.manage_checklists);
            var force_ticket_media = JSON.stringify(permissions.force_ticket_media);
localStorage.setItem('permissions_force_ticket_media', force_ticket_media);

            localStorage.setItem('manage_checklists', pr9);
            localStorage.setItem('permissions_raise_ticket', pr8);
            localStorage.setItem('permissions_assign_ticket_admins', pr6);
            localStorage.setItem('permissions_manage_ticket_admins', pr7);
            localStorage.setItem('permissions_assign_caretakers', pr5);
            localStorage.setItem('permissions_manage_caretakers', pr4);
            localStorage.setItem('permissions_manage_engineers', pr3);
            localStorage.setItem('permissions_raise_internal_ticket', pr);
            localStorage.setItem('permissions_raise_adhoc_ticket', pr2);
        }
    },
    error: function(jqXhr, textStatus, errorThrown) {
        console.log(errorThrown);

        function alertDismissed() {
    // do something
}

navigator.notification.alert(
    JSON.stringify(errorThrown),  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);

    }
});

}



///faceID login
$(document).on('click', '.faceIDBtn', function(){ 


if(localStorage.getItem('faceid_username') != 'null'){

//you been here 
window.plugins.touchid.verifyFingerprint(
  'Scan fingerprint', // this will be shown in the native scanner popup
   function(msg) {
   

   
var lang = localStorage.getItem('lang');
if(lang == 'ge'){
lang = 'de'
}
   

   var username = localStorage.getItem('faceid_username');
   var password = localStorage.getItem('faceid_password');
   
   var data = { 
    language : lang,
    device_id: localStorage.getItem('device_id'),
    email: username,
    password: password,
};



$.ajax({
    url: ''+host+'login-new.php?language='+lang+'&device_id='+externalUserId+'&email='+username+'&password='+password+'',
    //dataType: 'text',
    crossDomain: true,
    crossOrigin: true,
    async: true,
    data: data,
    type: 'POST',
    //processData: false,
    success: function( data, textStatus, jQxhr ){
              console.log(data);
var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
      var json = JSON.stringify(data);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);
var company = parsed_data['company'];
var role = parsed_data['role'];
localStorage.setItem('role', role);


//var company = 'GymBox Test';

localStorage.setItem('company', company);


if(parsed_data['status'] == 'OK'){

        var refreshtoken = parsed_data['refreshtoken'];
        var accesstoken = parsed_data['accesstoken'];
        var expiry = parsed_data['expiry'];
        var usertype = parsed_data['type'];
        var permissions = parsed_data['permissions'];


        console.log(JSON.stringify(permissions));
if(usertype =='Gym Operator'){
        var pr = JSON.stringify(permissions.raise_internal_ticket);
      var pr2 = JSON.stringify(permissions.raise_adhoc_ticket);


localStorage.setItem('permissions_raise_internal_ticket', pr);
localStorage.setItem('permissions_raise_adhoc_ticket', pr2);



}


      localStorage.setItem('email', username);
      localStorage.setItem('password', password);
      localStorage.setItem('refreshtoken', refreshtoken);
      localStorage.setItem('accesstoken', accesstoken);
      localStorage.setItem('expiry', expiry);

console.log("my access token" +accesstoken);

localStorage.setItem('usertype', usertype);

getMyDetails();

getTotalUnred();

getMyContracts();

if(usertype == 'Gym Operator' ){

$('.go-el').show();
$('.sp-el').hide();
$('.ta-el').hide();

}else{

$('.go-el').hide();
$('.sp-el').show();
$('.ta-el').hide();

  }

if(role == 'ticket_admin'){

$('.ta-el').show();

}



var now = new Date();
now.setMinutes(now.getMinutes() + 20); // timestamp
now = new Date(now);

localStorage.setItem('loggedinTime', now);


var now = new Date();
var loggedinTime = localStorage.getItem('loggedinTime');


console.log(loggedinTime);

var date2 = new Date(loggedinTime);
if(now-date2 > 1*60*1000){
  logout();

}else{

 var minutes = date2.getMinutes();
var hours = date2.getHours();   
}

      localStorage.setItem('loggedin', 'yes');

      $('.button').prop('disabled', false);
      $('.loaderIcon').hide();

var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};




var modal = document.querySelector('ons-modal'); 
modal.hide({animation: 'lift'});

$('.loginHolder').addClass('animated zoomOut');

setTimeout(function() {

var modal = document.getElementById('loginmodal');
modal.hide();

$('.loginHolder').removeClass('animated zoomOut');

function OneSignalInit() {

  setTimeout(function(){ 

   //window.plugins.OneSignal.initialize(""+oneSignalId+"");
//window.plugins.OneSignal.User.pushSubscription.optIn();
 //window.plugins.OneSignal.login(''+externalUserId+''); 

    ///window.plugins.OneSignal.getIds(function(ids) {
               // alert("player id: " + ids.userId);
            //});

            window.plugins.OneSignal.setAppId(oneSignalId);
            window.plugins.OneSignal.setNotificationOpenedHandler(function(jsonData) {
                //alert('notificationOpenedCallback: ' + JSON.stringify(jsonData));
        
            });
        
        
          window.plugins.OneSignal.setExternalUserId(''+externalUserId+''); 
        
        
        
          window.plugins.OneSignal.promptForPushNotificationsWithUserResponse(function(accepted) {
                //alert("User accepted notifications: " + accepted);
        
                if( accepted == true){
        
                }else{
        
        
        
                }
        
            });
 }, 2000);

}

OneSignalInit();

  }, 1000);



}else{


      $('.button').prop('disabled', false);
      $('.loaderIcon').hide();

var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};




function alertDismissed() {
    // do something
}

navigator.notification.alert(
    JSON.stringify(parsed_data['msg']),  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);


}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});

   
   
   
   }, // success handler: fingerprint accepted
   function(msg) {/*alert('' + JSON.stringify(msg))*/} // error handler with errorcode and localised reason
);


}else{

// you have not been here



   
var lang = localStorage.getItem('lang');
if(lang == 'ge'){
lang = 'de'
}
   var username = $('.username').val();
   var password = $('.password').val();

   if(username != '' && password != ''){

   
   
   var data = { 
    language : lang,
    device_id: localStorage.getItem('device_id'),
    email: username,
    password: password,
};




$.ajax({
    url: ''+host+'login-new.php?language='+lang+'&device_id='+externalUserId+'&email='+username+'&password='+password+'',
    //dataType: 'text',
    crossDomain: true,
    crossOrigin: true,
    async: true,
    data: data,
    type: 'POST',
    //processData: false,
    success: function( data, textStatus, jQxhr ){
              console.log(data);
var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
      var json = JSON.stringify(data);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);
var company = parsed_data['company'];
var role = parsed_data['role'];
localStorage.setItem('role', role);


//var company = 'GymBox Test';

localStorage.setItem('company', company);


/*if(company == 'GymBox Test' || company == 'Gymbox' ){
Promise.all([
    loadStyle('../css/gymbox.css'),
    //loadStyle('/style2.css'),
    // ...
]).then(() => {


});



}else if(company == 'Bannatynes'){

Promise.all([
    loadStyle('../css/bannatynes.css'),
    //loadStyle('/style2.css'),
    // ...
]).then(() => {
    // do something

});

     }else if(company =='Third Space'){

Promise.all([
    loadStyle('../css/thirdSpace.css'),
    //loadStyle('/style2.css'),
    // ...
]).then(() => {
    // do something


});
     }else{
                 Promise.all([
    loadStyle('../css/style.css'),
    //loadStyle('/style2.css'),
    // ...
]).then(() => {
    // do something
});

     }*/



if(parsed_data['status'] == 'OK'){

        var refreshtoken = parsed_data['refreshtoken'];
        var accesstoken = parsed_data['accesstoken'];
        var expiry = parsed_data['expiry'];
        var usertype = parsed_data['type'];
        var permissions = parsed_data['permissions'];


        console.log(JSON.stringify(permissions));
if(usertype =='Gym Operator'){
        var pr = JSON.stringify(permissions.raise_internal_ticket);
      var pr2 = JSON.stringify(permissions.raise_adhoc_ticket);


localStorage.setItem('permissions_raise_internal_ticket', pr);
localStorage.setItem('permissions_raise_adhoc_ticket', pr2);



}


      localStorage.setItem('email', username);
      localStorage.setItem('password', password);
      localStorage.setItem('refreshtoken', refreshtoken);
      localStorage.setItem('accesstoken', accesstoken);
      localStorage.setItem('expiry', expiry);


///face id check here
      window.plugins.touchid.verifyFingerprint(
  'Scan fingerprint', // this will be shown in the native scanner popup
   function(msg) {

   
      localStorage.setItem('faceid_username', username);
      localStorage.setItem('faceid_password', password);
   

}, // success handler: fingerprint accepted
   function(msg) {/*alert('' + JSON.stringify(msg))*/} // error handler with errorcode and localised reason
);

console.log("my access token" +accesstoken);

localStorage.setItem('usertype', usertype);

getMyDetails();

getTotalUnred();

getMyContracts();

if(usertype == 'Gym Operator' ){

$('.go-el').show();
$('.sp-el').hide();
$('.ta-el').hide();

}else{

$('.go-el').hide();
$('.sp-el').show();
$('.ta-el').hide();

  }

if(role == 'ticket_admin'){

$('.ta-el').show();

}

var now = new Date();
now.setMinutes(now.getMinutes() + 20); // timestamp
now = new Date(now);

localStorage.setItem('loggedinTime', now);


var now = new Date();
var loggedinTime = localStorage.getItem('loggedinTime');


console.log(loggedinTime);

var date2 = new Date(loggedinTime);
if(now-date2 > 1*60*1000){
  logout();

}else{

 var minutes = date2.getMinutes();
var hours = date2.getHours();   
}

      localStorage.setItem('loggedin', 'yes');

      $('.button').prop('disabled', false);
      $('.loaderIcon').hide();

var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};




var modal = document.querySelector('ons-modal'); 
modal.hide({animation: 'lift'});

$('.loginHolder').addClass('animated zoomOut');

setTimeout(function() {

var modal = document.getElementById('loginmodal');
modal.hide();

$('.loginHolder').removeClass('animated zoomOut');

function OneSignalInit() {

  setTimeout(function(){ 

    //window.plugins.OneSignal.initialize(""+oneSignalId+"");
//window.plugins.OneSignal.User.pushSubscription.optIn();
 //window.plugins.OneSignal.login(''+externalUserId+''); 

    ///window.plugins.OneSignal.getIds(function(ids) {
               // alert("player id: " + ids.userId);
            //});

            window.plugins.OneSignal.setAppId(oneSignalId);
            window.plugins.OneSignal.setNotificationOpenedHandler(function(jsonData) {
                //alert('notificationOpenedCallback: ' + JSON.stringify(jsonData));
        
            });
        
        
          window.plugins.OneSignal.setExternalUserId(''+externalUserId+''); 
        
        
        
          window.plugins.OneSignal.promptForPushNotificationsWithUserResponse(function(accepted) {
                //alert("User accepted notifications: " + accepted);
        
                if( accepted == true){
        
                }else{
        
        
        
                }
        
            });
 }, 2000);

}

OneSignalInit();

  }, 1000);



}else{


      $('.button').prop('disabled', false);
      $('.loaderIcon').hide();

var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};




function alertDismissed() {
    // do something
}

navigator.notification.alert(
    JSON.stringify(parsed_data['msg']),  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);


}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});

}

}
});

///fingerPrint login
$(document).on('click', '.fingerPrintBtn', function(){ 

  if(localStorage.getItem('fingerPrintToken') != 'null'){

//you been here before
var password = '';

var decryptConfig = {
    clientId: appName,
    username: localStorage.getItem('fingerPrintUserName'),
    token: localStorage.getItem('fingerPrintToken')
};

FingerprintAuth.decrypt(decryptConfig, successCallback, errorCallback);

function successCallback(result) {
    //alert("successCallback(): " + JSON.stringify(result));
    if (result.withFingerprint) {
        //alert("Successful biometric authentication.");
        if (result.password) {
            //alert("Successfully decrypted credential token.");
            //alert("password: " + result.password); 
            
        }
    } else if (result.withBackup) {
        //alert("Authenticated with backup password");
    }

    password = result.password; 


//lets log the user in here
var lang = localStorage.getItem('lang');
if(lang == 'ge'){
lang = 'de'
}

var data = { 
    language : lang,
    device_id: localStorage.getItem('device_id'),
    email: localStorage.getItem('fingerPrintUserName'),
    password: password,
};


$.ajax({
    url: ''+host+'login-new.php?language='+lang+'&device_id='+externalUserId+'&email='+localStorage.getItem('fingerPrintUserName')+'&password='+password+'',
    //dataType: 'text',
    crossDomain: true,
    crossOrigin: true,
    async: true,
    data: data,
    type: 'POST',
    //processData: false,
    success: function( data, textStatus, jQxhr ){
              console.log(data);
var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
      var json = JSON.stringify(data);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);


var company = parsed_data['company'];

var role = parsed_data['role'];
localStorage.setItem('role', role);
//var company = 'GymBox Test';

localStorage.setItem('company', company);

if(parsed_data['status'] == 'OK'){

        var refreshtoken = parsed_data['refreshtoken'];
        var accesstoken = parsed_data['accesstoken'];
        var expiry = parsed_data['expiry'];
        var usertype = parsed_data['type'];
        var permissions = parsed_data['permissions'];


        console.log(JSON.stringify(permissions));
if(usertype =='Gym Operator'){
        var pr = JSON.stringify(permissions.raise_internal_ticket);
      var pr2 = JSON.stringify(permissions.raise_adhoc_ticket);


localStorage.setItem('permissions_raise_internal_ticket', pr);
localStorage.setItem('permissions_raise_adhoc_ticket', pr2);



}


      localStorage.setItem('email', localStorage.getItem('fingerPrintUserName'));
      localStorage.setItem('password', password);
      localStorage.setItem('refreshtoken', refreshtoken);
      localStorage.setItem('accesstoken', accesstoken);
      localStorage.setItem('expiry', expiry);


console.log("my access token" +accesstoken);

localStorage.setItem('usertype', usertype);

setTimeout(doSomething, 200);

function doSomething() {

getMyDetails();
getTotalUnred();
getMyContracts();
}



if(usertype == 'Gym Operator' ){

$('.go-el').show();
$('.sp-el').hide();
$('.ta-el').hide();

}else{

$('.go-el').hide();
$('.sp-el').show();
$('.ta-el').hide();

  }


if(role == 'ticket_admin'){

$('.ta-el').show();

}

    //show/hide checklist
if(localStorage.getItem('manage_checklists') == "true"){

$('.gotochecklists').removeClass('opchecks');

}else{
    $('.gotochecklists').addClass('opchecks');
}




var now = new Date();
now.setMinutes(now.getMinutes() + 20); // timestamp
now = new Date(now);

localStorage.setItem('loggedinTime', now);


var now = new Date();
var loggedinTime = localStorage.getItem('loggedinTime');


console.log(loggedinTime);

var date2 = new Date(loggedinTime);
if(now-date2 > 1*60*1000){
  logout();

}else{

 var minutes = date2.getMinutes();
var hours = date2.getHours();   
}

      localStorage.setItem('loggedin', 'yes');

      $('.button').prop('disabled', false);
      $('.loaderIcon').hide();

var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};




var modal = document.querySelector('ons-modal'); 
modal.hide({animation: 'lift'});

$('.loginHolder').addClass('animated zoomOut');

setTimeout(function() {

var modal = document.getElementById('loginmodal');
modal.hide();

$('.loginHolder').removeClass('animated zoomOut');

function OneSignalInit() {

  setTimeout(function(){ 

    //window.plugins.OneSignal.initialize(""+oneSignalId+"");
//window.plugins.OneSignal.User.pushSubscription.optIn();
 //window.plugins.OneSignal.login(''+externalUserId+''); 

    ///window.plugins.OneSignal.getIds(function(ids) {
               // alert("player id: " + ids.userId);
            //});

            window.plugins.OneSignal.setAppId(oneSignalId);
            window.plugins.OneSignal.setNotificationOpenedHandler(function(jsonData) {
                //alert('notificationOpenedCallback: ' + JSON.stringify(jsonData));
        
            });
        
        
          window.plugins.OneSignal.setExternalUserId(''+externalUserId+''); 
        
        
        
          window.plugins.OneSignal.promptForPushNotificationsWithUserResponse(function(accepted) {
                //alert("User accepted notifications: " + accepted);
        
                if( accepted == true){
        
                }else{
        
        
        
                }
        
            });
 }, 2000);

}

OneSignalInit();

  }, 1000);



}else{


      $('.button').prop('disabled', false);
      $('.loaderIcon').hide();

var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};




function alertDismissed() {
    // do something
}

navigator.notification.alert(
    JSON.stringify(parsed_data['msg']),  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);




}





    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});




}

function errorCallback(error) {
    if (error === FingerprintAuth.ERRORS.FINGERPRINT_CANCELLED) {
   
        navigator.notification.alert('FingerprintAuth Dialog Cancelled!');
    } else {
        
        navigator.notification.alert("FingerprintAuth Error: " + error);
    }
}

  }else{

          var username = $('.username').val();
  var password = $('.password').val();


//'You have not been here before'

if(password != '' && username !=''){

//lets log the user in here

var lang = localStorage.getItem('lang');
if(lang == 'ge'){
lang = 'de'
}


var data = { 
    language : lang,
    device_id: localStorage.getItem('device_id'),
    email: username,
    password: password,
};





$.ajax({
    url: ''+host+'login-new.php?language='+lang+'&device_id='+externalUserId+'&email='+username+'&password='+password+'',
    //dataType: 'text',
    crossDomain: true,
    crossOrigin: true,
    async: true,
    data: data,
    type: 'POST',
    //processData: false,
    success: function( data, textStatus, jQxhr ){
              console.log(data);
var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
      var json = JSON.stringify(data);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);
var company = parsed_data['company'];
var role = parsed_data['role'];
localStorage.setItem('role', role);
localStorage.setItem('company', company);


if(parsed_data['status'] == 'OK'){

FingerprintAuth.isAvailable(isAvailableSuccess, isAvailableError);

/**
 * @return {
 *      isAvailable:boolean,
 *      isHardwareDetected:boolean,
 *      hasEnrolledFingerprints:boolean
 *   }
 */
function isAvailableSuccess(result) {
    //console.log("FingerprintAuth available: " + JSON.stringify(result));


    if (result.isAvailable == true) {

        //we gonna SAVE the login details here

var encryptConfig = {
    clientId: ""+appName+"",
    username: username,
    password: password
};


FingerprintAuth.encrypt(encryptConfig, successCallback, errorCallback);

function successCallback(result) {
    //alert("successCallback(): " + JSON.stringify(result));
    if (result.withFingerprint) {
        //alert("Successfully encrypted credentials.");
        //alert("Encrypted credentials: " + result.token);  

        localStorage.setItem('fingerPrintToken', result.token);
        localStorage.setItem('fingerPrintUserName', username);


    } else if (result.withBackup) {
        //alert("Authenticated with backup password");
    }

}

function errorCallback(error) {
    if (error === FingerprintAuth.ERRORS.FINGERPRINT_CANCELLED) {
  
        navigator.notification.alert("FingerprintAuth Dialog Cancelled!");
    } else {
        navigator.notification.alert("FingerprintAuth Error: " + error);
    }
}




}
}

function isAvailableError(message) {

    navigator.notification.alert(message);
}

        var refreshtoken = parsed_data['refreshtoken'];
        var accesstoken = parsed_data['accesstoken'];
        var expiry = parsed_data['expiry'];
        var usertype = parsed_data['type'];
        var permissions = parsed_data['permissions'];


        console.log(JSON.stringify(permissions));
if(usertype =='Gym Operator'){
        var pr = JSON.stringify(permissions.raise_internal_ticket);
      var pr2 = JSON.stringify(permissions.raise_adhoc_ticket);


localStorage.setItem('permissions_raise_internal_ticket', pr);
localStorage.setItem('permissions_raise_adhoc_ticket', pr2);



}


      localStorage.setItem('email', username);
      localStorage.setItem('password', password);
      localStorage.setItem('refreshtoken', refreshtoken);
      localStorage.setItem('accesstoken', accesstoken);
      localStorage.setItem('expiry', expiry);

console.log("my access token" +accesstoken);

localStorage.setItem('usertype', usertype);

getMyDetails();

getTotalUnred();
getMyContracts();

if(usertype == 'Gym Operator' ){

$('.go-el').show();
$('.sp-el').hide();
$('.ta-el').hide();

}else{

$('.go-el').hide();
$('.sp-el').show();
$('.ta-el').hide();

  }


if(role == 'ticket_admin'){

$('.ta-el').show();

}
  //show/hide checklist
if(localStorage.getItem('manage_checklists') == "true"){

$('.gotochecklists').removeClass('opchecks');

}else{
    $('.gotochecklists').addClass('opchecks');
}


var now = new Date();
now.setMinutes(now.getMinutes() + 20); // timestamp
now = new Date(now);

localStorage.setItem('loggedinTime', now);


var now = new Date();
var loggedinTime = localStorage.getItem('loggedinTime');


console.log(loggedinTime);

var date2 = new Date(loggedinTime);
if(now-date2 > 1*60*1000){
  logout();

}else{

 var minutes = date2.getMinutes();
var hours = date2.getHours();   
}

      localStorage.setItem('loggedin', 'yes');

      $('.button').prop('disabled', false);
      $('.loaderIcon').hide();

var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};




var modal = document.querySelector('ons-modal'); 
modal.hide({animation: 'lift'});

$('.loginHolder').addClass('animated zoomOut');

setTimeout(function() {

var modal = document.getElementById('loginmodal');
modal.hide();

$('.loginHolder').removeClass('animated zoomOut');

function OneSignalInit() {

  setTimeout(function(){ 

   //window.plugins.OneSignal.initialize(""+oneSignalId+"");
//window.plugins.OneSignal.User.pushSubscription.optIn();
 //window.plugins.OneSignal.login(''+externalUserId+''); 

    ///window.plugins.OneSignal.getIds(function(ids) {
               // alert("player id: " + ids.userId);
            //});

            window.plugins.OneSignal.setAppId(oneSignalId);
            window.plugins.OneSignal.setNotificationOpenedHandler(function(jsonData) {
                //alert('notificationOpenedCallback: ' + JSON.stringify(jsonData));
        
            });
        
        
          window.plugins.OneSignal.setExternalUserId(''+externalUserId+''); 
        
        
        
          window.plugins.OneSignal.promptForPushNotificationsWithUserResponse(function(accepted) {
                //alert("User accepted notifications: " + accepted);
        
                if( accepted == true){
        
                }else{
        
        
        
                }
        
            });
 }, 2000);

}

OneSignalInit();

  }, 1000);







}else{


      $('.button').prop('disabled', false);
      $('.loaderIcon').hide();

var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};




function alertDismissed() {
    // do something
}

navigator.notification.alert(
    JSON.stringify(parsed_data['msg']),  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);


}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});

//////////////////////////


}else{
 navigator.notification.alert('Password and Email required!');
}

  }

});

$(document).on('click', '.back-button, .leaveDetailsPage', function(){ 
 bottomToolbar.style.transform = 'translateY(0)';
$('.sheet-modal').removeClass('sheet_modal_display');
$('.footerMsgHolder').remove();
});

///custom modal sheet///
$('.popup').each(function() {

  var mc = new Hammer(this);

  mc.get('swipe').set({
    direction: Hammer.DIRECTION_ALL
  });

  mc.on("swipedown", function(ev) {
    console.log('dragged');
    $('.page').removeClass('scaled');
$('.bottomToolbar').removeClass('scaled');
$('html').removeClass('blacked');
$('body').removeClass('blacked');
    $('.modal-in').css('bottom', '-3850px');
    $('.sheet-backdrop').removeClass('backdrop-in');
    $('.m_listitem').show();
    $('.searchAssetsInput').val('');


$('.popup').removeClass('popup-show');
            $('.popup').css('bottom', '');
        $('.popup').css('top', '');

    
  });
});


$(document).on('click', '.sheet-backdrop', function(){ 
 
$('.page').removeClass('scaled');
$('.bottomToolbar').removeClass('scaled');
$('html').removeClass('blacked');
$('body').removeClass('blacked');
      $('.modal-in').css('bottom', '-3850px');
    $('.sheet-backdrop').removeClass('backdrop-in');
    $('.m_listitem').show();
    $('.searchAssetsInput').val('');

$('.popup').removeClass('popup-show');
$('.popup').css('bottom', '');
$('.popup').css('top', '');
$('.modernpopup').css('transform', `translateY(10000px)`);
$('.modernpopup').remove();
     
});



///search in assets for manual tickets

$(document).on('mousedown', '.searchable', function(){
   
 $(this).text('');
$('.bottomToolbar').hide();

});

$(document).on('mouseout', '.searchable', function(){
   
$('.bottomToolbar').show();

});

    $(document).ready(function(e) {
        var timeout;
        var delay = 800;   // 2 seconds

        $(document).on('keyup', '.searchable', function(){
            //$('#status').html("User started typing!");

            
            if(timeout) {
                clearTimeout(timeout);
            }
            timeout = setTimeout(function() {
                myFunction();
            }, delay);
        });

        function myFunction() {
        $('.m_listitem').hide();
var v = $('.searchable').text();

$('.m_listitem:contains('+v+')').show();

        }
    });


//selected asset
$(document).on('click', '.m_listitem', function(){

    var v = $(this).attr('data-value');
var c = $(this).text();
    $('.assetsSelect').val(v).change();
$('.searchable').text(c);
 
$('.page').removeClass('scaled');
$('.bottomToolbar').removeClass('scaled');
$('html').removeClass('blacked');
$('body').removeClass('blacked');
      $('.modal-in').css('bottom', '-3850px');
    $('.sheet-backdrop').removeClass('backdrop-in');
    $('.m_listitem').show();
    $('.searchAssetsInput').val('');
    

$('.popup').removeClass('popup-show');
            $('.popup').css('bottom', '');
        $('.popup').css('top', '');
    $('.popup').scrollTop(0,0);
     $('.popup').remove();


     
});

//listen to TA invite input

 function validateEmail($email) {
  var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
  return emailReg.test( $email );
}



$(document).on('click', '.cover', function(e){ 
  e.stopPropagation();
});


$(document).on('click', '.themChanger', function(e){ 



$( this ).toggleClass("light");
jQuery.loadCSS = function(url) {
    if (!$('link[href="' + url + '"]').length)
        $('head').append('<link rel="stylesheet" type="text/css" href="' + url + '">');
}


 if ($(this).hasClass("light")) {

$('.fa-sun').hide();
$('.fa-moon').show();

$.loadCSS('css/light-style.css');


localStorage.setItem('theme', 'light');
        } else {

$('.fa-sun').show();
$('.fa-moon').hide();

            localStorage.removeItem('theme');

$("LINK[href*='css/light-style.css']").remove();


        }
 
});


//go to Add IMAGES TO Assets section
function goToAddImage(){

var lang = localStorage.getItem('lang');

    function alertDismissed() {
document.querySelector('#myNavigator').pushPage('add-img.html');
}

var qrScanMessage;
var ttle;
if (lang == 'ge') {
    qrScanMessage = 'Scannen Sie den QR-Code, um ein Standardbild für das Gerät hinzuzufügen.';
    ttle = 'Hinweis';
} else if (lang == 'po') {
    qrScanMessage = 'Use o scanner QR para digitalizar um código QR.';
    ttle = 'atenção';
} else if (lang == 'sp') {
    qrScanMessage = 'Utilice el escáner QR para escanear un código QR.';
    ttle = 'atención';
} else if (lang == 'bul') {
    qrScanMessage = 'Използвайте QR скенер, за да сканирате QR код.';
    ttle = 'внимание';
} else if (lang == 'it') {
    qrScanMessage = 'Utilizza lo scanner QR per scansionare un codice QR.';
    ttle = 'Attenzione.';
} else if (lang == 'fr') {
    qrScanMessage = 'Utilisez le scanner QR pour scanner un code QR.';
    ttle = 'Attention';
} else if (lang == 'ar') {
qrScanMessage = 'استخدم ماسح الباركود لمسح رمز الاستجابة السريعة';
ttle = 'تنبيه';
}else if (lang == 'ja') {
qrScanMessage = 'QRコードをスキャンするには、バーコードスキャナーを使用してください';
ttle = '警告';
}else if (lang == 'tu') {
var qrScanMessage = 'QR kodunu tarayabilmek için bir barkod tarayıcı kullanın.';
var title = 'Uyarı';

}else {
    // Default to the original text if the language code is not recognized
    qrScanMessage = 'Use QR scanner to scan a QR code.';
    ttle = 'Attention';
}

// Now you can use the variable qrScanMessage in your code.
navigator.notification.alert(qrScanMessage, alertDismissed, ttle, 'OK');

}




//Set Technician ID to deploy
$(document).on('click', '.enginnersListItem', function(e){ 

if(localStorage.getItem('permissions_manage_engineers') == 'true'){


techToDeploy = $(this).attr('data-id');

$(this).css('background', '#da116d');

    
}else{


    var lang = localStorage.getItem('lang');

function alertDismissed() {}

var permissionMessage;

if (lang == 'ge') {
    permissionMessage = 'Sie verfügen nicht über die Berechtigung „Ingenieure verwalten“.';
} else if (lang == 'po') {
    permissionMessage = 'Você não tem permissão para "Gerenciar Engenheiros".';
} else if (lang == 'sp') {
    permissionMessage = 'No tienes permiso para "Administrar Ingenieros".';
} else if (lang == 'bul') {
    permissionMessage = 'Нямате разрешение да "Управлявате инженери".';
} else if (lang == 'it') {
    permissionMessage = 'Non hai il permesso di "Gestire gli ingegneri".';
} else if (lang == 'fr') {
    permissionMessage = 'Vous n\'avez pas la permission de "Gérer les ingénieurs".';
} else if (lang == 'ar') {
    permissionMessage = 'ليس لديك إذن "إدارة المهندسين"';
} else if (lang == 'ja') {
    permissionMessage = '「エンジニアの管理」の許可がありません';
} else if (lang == 'tu') {
var permissionMessage = 'Mühendis Yönetimi iznine sahip değilsiniz.';

}else {
    // Default to the original text if the language code is not recognized
    permissionMessage = 'You do not have "Manage Engineers" permission.';
}

// Now you can use the variable permissionMessage in your code.
navigator.notification.alert(permissionMessage, alertDismissed, 'Attention', 'OK');


}



var scrollableElement = $('.popup-content');
var scrollHeight = scrollableElement.prop('scrollHeight');

      // Animate the scroll to the bottom over 800 milliseconds
      scrollableElement.animate({ scrollTop: scrollHeight }, 800);
});




///depoloy cartakers
$(document).on('click', '.finalDeployEngBtnInternal', function(e){ 



var pmodal = document.getElementById('preloaderModal');
pmodal.show();


var uuid = localStorage.getItem('uuid');
var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');
var id = $('.internalTechList').val();
var englineerEmailToInv = $('.englineerEmailToInv').val();


console.log(''+host+'postUpdateTicketDeployCaretaker.php?email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'&id='+id+'&englineerEmailToInv='+englineerEmailToInv+'');



$.ajax({
    url: ''+host+'postUpdateTicketDeployCaretaker.php?email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'&id='+id+'&englineerEmailToInv='+englineerEmailToInv+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){
              //alert(JSON.stringify(data));

var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

      var json = JSON.stringify(data);

console.log(json);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);

$('.button').prop('disabled', false);
$('.loaderIcon').hide();


if(parsed_data['status'] == 'OK'){



    $('.page').removeClass('scaled');
$('.bottomToolbar').removeClass('scaled');
$('html').removeClass('blacked');
$('body').removeClass('blacked');
$('.modal-in').css('bottom', '-3850px');
$('.sheet-backdrop').removeClass('backdrop-in');
$('.demo-sheet-swipe-to-close,.demo-sheet-swipe-to-step').scrollTop(0,0);

    $('.englineerEmailToInv').val('');

var notify = function() {
  //ons.notification.alert('You have successfully added a note.');
  var lang = localStorage.getItem('lang');

$('.popup').removeClass('popup-show');
            $('.popup').css('bottom', '');
        $('.popup').css('top', '');
    $('.popup').scrollTop(0,0);
     $('.popup').remove();


var confirmationMessage;

if (lang == 'ge') {
    confirmationMessage = 'Vielen Dank für die Bestätigung.';
} else if (lang == 'po') {
    confirmationMessage = 'Obrigado por confirmar.';
} else if (lang == 'sp') {
    confirmationMessage = 'Gracias por confirmar.';
} else if (lang == 'bul') {
    confirmationMessage = 'Благодаря за потвърждението.';
} else if (lang == 'it') {
    confirmationMessage = 'Grazie per la conferma.';
} else if (lang == 'fr') {
    confirmationMessage = 'Merci de confirmer.';
} else if (lang == 'ar') {
   confirmationMessage = 'شكراً للتأكيد'
} else if (lang == 'ja') {
  confirmationMessage = '確認していただき、ありがとうございます';

} else if (lang == 'tu') {
confirmationMessage = 'Onayladığınız için teşekkür ederiz.';


} else {
    // Default to the original text if the language code is not recognized
    confirmationMessage = 'Thank you for confirming.';
}

// Now you can use the variable confirmationMessage in your code.
ons.notification.toast(confirmationMessage, { timeout: 1500, animation: 'fall' });

};

notify();

document.querySelector('#myNavigator').popPage();


}else{

    function alertDismissed() {
    // do something
}

navigator.notification.alert(
    JSON.stringify(parsed_data['msg']),  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);


}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );

        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});


});




///New deploy Technician
$(document).on('click', '.finalDeployEngBtn', function(e){ 

var pmodal = document.getElementById('preloaderModal');
pmodal.show();
var uuid = localStorage.getItem('uuid');
var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');
var id = techToDeploy;
var englineerEmailToInv = $('.englineerEmailToInv').val();


$('.page').removeClass('scaled');
$('.bottomToolbar').removeClass('scaled');
$('html').removeClass('blacked');
$('body').removeClass('blacked');
$('.modal-in').css('bottom', '-3850px');
$('.sheet-backdrop').removeClass('backdrop-in');
$('.demo-sheet-swipe-to-close,.demo-sheet-swipe-to-step').scrollTop(0,0);


$.ajax({
    url: ''+host+'sp-postUpdateTicketDeploy-new.php?email='+email+'&accesstoken='+accesstoken+'&uuid='+uuid+'&id='+id+'&englineerEmailToInv='+englineerEmailToInv+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){
              //alert(JSON.stringify(data));

var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

      var json = JSON.stringify(data);

console.log(json);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);

$('.button').prop('disabled', false);
$('.loaderIcon').hide();


if(parsed_data['status'] == 'OK'){

    $('.englineerEmailToInv').val('');

var notify = function() {
  //ons.notification.alert('You have successfully added a note.');
  var lang = localStorage.getItem('lang');

$('.popup').removeClass('popup-show');
            $('.popup').css('bottom', '');
        $('.popup').css('top', '');
    $('.popup').scrollTop(0,0);
     $('.popup').remove();


var confirmationMessage;

if (lang == 'ge') {
    confirmationMessage = 'Vielen Dank für die Bestätigung.';
} else if (lang == 'po') {
    confirmationMessage = 'Obrigado por confirmar.';
} else if (lang == 'sp') {
    confirmationMessage = 'Gracias por confirmar.';
} else if (lang == 'bul') {
    confirmationMessage = 'Благодаря за потвърждението.';
} else if (lang == 'it') {
    confirmationMessage = 'Grazie per la conferma.';
} else if (lang == 'fr') {
    confirmationMessage = 'Merci de confirmer.';
} else if (lang == 'ar') {
   confirmationMessage = 'شكراً للتأكيد'
} else if (lang == 'ja') {
  confirmationMessage = '確認していただき、ありがとうございます';

} else if (lang == 'tu') {
confirmationMessage = 'Onayladığınız için teşekkür ederiz.';


} else {
    // Default to the original text if the language code is not recognized
    confirmationMessage = 'Thank you for confirming.';
}

// Now you can use the variable confirmationMessage in your code.
ons.notification.toast(confirmationMessage, { timeout: 1500, animation: 'fall' });

};

notify();

document.querySelector('#myNavigator').popPage();


}else{

    function alertDismissed() {
    // do something
}

navigator.notification.alert(
    JSON.stringify(parsed_data['msg']),  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);


}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );

        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});


});



//segments

$(document).on('change','input[name=four]:checked',function(){
    var value = $(this).val();
$('.segList').empty();

    var finalQuote = [];
var finalWorksheet = [];
var finalInvoices = [];
var uuid = localStorage.getItem('uuid');



if(value == 'quotesList'){

    var quotes = segQuote;

if(localStorage.getItem('usertype') == 'Service Provider'){

$('.segList').append('<ons-list-item class="uploadbtn" data-file="quote">'+
      '<div class="left" >'+
        '<ons-icon style="color:#da116d;font-size:30px;" icon="md-upload"></ons-icon>'+
      '</div>'+
      '<div class="center">Upload</div>'+
    '</ons-list-item>');

}



if (quotes != undefined || quotes.length != 0) {


$(quotes).each((index, element) => {
        //console.log(`current index : ${index} element : ${element}`)

        $('.segList').append('<ons-list-item class="downloadbtn" data-download="'+element.url+'">'+
      '<div class="left" >'+
        '<ons-icon style="color:#da116d;font-size:30px;" icon="md-download"></ons-icon>'+
      '</div>'+
      '<div class="center"><span class="list-item__title trn">Download</span><span class="list-item__subtitle">'+element.name+'</span></div>'+
    '</ons-list-item>');
    });
 
}

}else if(value == 'invoiceList'){


    if(localStorage.getItem('usertype') == 'Service Provider'){

$('.segList').append('<ons-list-item class="uploadbtn" data-file="invoice">'+
      '<div class="left" >'+
        '<ons-icon style="color:#da116d;font-size:30px;" icon="md-upload"></ons-icon>'+
      '</div>'+
      '<div class="center trn">Upload</div>'+
    '</ons-list-item>');

}


    var invoices = segInvoice;

if (invoices != undefined || invoices.length != 0) {


$(invoices).each((index, element) => {
        //console.log(`current index : ${index} element : ${element}`)

        $('.segList').append('<ons-list-item class="downloadbtn" data-download="'+element.url+'">'+
      '<div class="left" >'+
        '<ons-icon style="color:#da116d;font-size:30px;" icon="md-download"></ons-icon>'+
      '</div>'+
      '<div class="center"><span class="list-item__title trn">Download</span><span class="list-item__subtitle">'+element.name+'</span></div>'+
    '</ons-list-item>');
    });
 
}


}else if(value == 'worksheetList'){


    if(localStorage.getItem('usertype') == 'Service Provider'){

$('.segList').append('<ons-list-item class="uploadbtn" data-file="worksheet">'+
      '<div class="left" >'+
        '<ons-icon style="color:#da116d;font-size:30px;" icon="md-upload"></ons-icon>'+
      '</div>'+
      '<div class="center trn">Upload</div>'+
    '</ons-list-item>');

}

    var worksheet = segWorksheet;

if (worksheet != undefined || worksheet.length != 0) {


$(worksheet).each((index, element) => {
        //console.log(`current index : ${index} element : ${element}`)

        $('.segList').append('<ons-list-item class="downloadbtn" data-download="'+element.url+'">'+
      '<div class="left" >'+
        '<ons-icon style="color:#da116d;font-size:30px;" icon="md-download"></ons-icon>'+
      '</div>'+
      '<div class="center"><span class="list-item__title trn">Download</span><span class="list-item__subtitle">'+element.name+'</span></div>'+
    '</ons-list-item>');
    });
 
}

}else{


    if(localStorage.getItem('usertype') == 'Gym Operator'){

$('.segList').append('<ons-list-item class="uploadbtn" data-file="purchaseOrders">'+
      '<div class="left" >'+
        '<ons-icon style="color:#da116d;font-size:30px;" icon="md-upload"></ons-icon>'+
      '</div>'+
      '<div class="center trn">Upload</div>'+
    '</ons-list-item>');

}


    var purchaseOrders = segPurchaseOrders;


if (purchaseOrders != undefined || purchaseOrders.length != 0) {


$(purchaseOrders).each((index, element) => {
        //console.log(`current index : ${index} element : ${element}`)

        $('.segList').append('<ons-list-item class="downloadbtn" data-download="'+element.url+'">'+
      '<div class="left" >'+
        '<ons-icon style="color:#da116d;font-size:30px;" icon="md-download"></ons-icon>'+
      '</div>'+
      '<div class="center"><span class="list-item__title trn">Download</span><span class="list-item__subtitle">'+element.name+'</span></div>'+
    '</ons-list-item>');
    });
 
}



}
  var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);
});


//Download files
$(document).on('click', '.downloadbtn', function(e){ 
    var url = $(this).attr('data-download');

cordova.InAppBrowser.open(url, '_system', 'location=yes');

});


//upload files
$(document).on('click', '.uploadbtn', function(e){ 


    var fileType = $(this).attr('data-file');
    
$('#filePicker').focus().trigger('click');

//file on change function
var handleFileSelect = function(evt) {
    //var files = evt.target.files;
    var files = evt.target.files;
    var file = files[0];


for (var i = 0, f; f = files[i]; i++) {


    var fileName = this.files[0].name;
var extension = this.files[0].name.slice(this.files[0].name.lastIndexOf(".") + 1, this.files[0].name.length);
console.log(extension);
if(extension == 'pdf'){

    if (files && file) {
        var reader = new FileReader();

        reader.onload = function(readerEvt) {
            var binaryString = readerEvt.target.result;

            //we are uploading the file/base64 here
            //var base64 = 'data:application/pdf;base64,'+btoa(binaryString);
var base64 = btoa(binaryString);
            filesToUpload.push(base64);


            console.log(base64);

var assetSerial = localStorage.getItem('serial-inner');
var uuid = localStorage.getItem('uuid');
var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

var pmodal = document.getElementById('preloaderModal');
pmodal.show();

        var values = {
            'uuid': uuid,
            'base64File': base64,
            'assetSerial': assetSerial,
            'email': email,
            'accesstoken': accesstoken,
            'fileType': fileType,
            'fileName': fileName
    };


$.ajax({
    url: ''+host+'sp-postUpdateTicket-newer.php',
//dataType: 'text',
    data: values,
    type: 'POST',
    success: function( data, textStatus, jQxhr ){
              //alert(JSON.stringify(data));
              var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

      var json = JSON.stringify(data);

      console.log(json);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);

if(parsed_data['status'] == 'OK'){


   var values = {
            'uuid': uuid,
            'url': base64,
            'name': fileName,
    };

if(fileType == 'purchaseOrders'){


segPurchaseOrders.push(values);

}else if(fileType == 'quote'){

    segQuote.push(values);


}else if(fileType == 'invoice'){


segInvoice.push(values);


}else{

segWorksheet.push(values);


}




      $('.segList').append('<ons-list-item class="downloadbtn_added" data-download="'+base64+'">'+
      '<div class="left" >'+
        '<ons-icon style="color:#da116d;font-size:30px;" icon="md-download"></ons-icon>'+
      '</div>'+
      '<div class="center trn">Added</div>'+
    '</ons-list-item>');

      var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);



}

    }

    });

        };

        reader.readAsBinaryString(file);





    }
    
}else{

// other file formats
navigator.notification.alert('Only PDF files allowed.');

}
}
};


if (window.File && window.FileReader && window.FileList && window.Blob) {
    document.getElementById('filePicker').addEventListener('change', handleFileSelect, false);
} else {
   
    navigator.notification.alert('You cannot upload a file on this device. This is due to unsupported system. Please either upgrade your OS or use another device.');
}

  });



//var fingerPrintToken = localStorage.getItem('fingerPrintToken');
   //var fingerPrintUserName = localStorage.getItem('fingerPrintUserName');

   //localStorage.setItem('fingerPrintToken', fingerPrintToken);
        //localStorage.setItem('fingerPrintUserName', fingerPrintUserName);



function addSheetModal(options = {}){


 var defaultModalContent = '';


    // Use provided modal content or default content
  var modalContent = options.modalContent || defaultModalContent;



var modal = '<div class="popup assetListpopUp">'+
'<div class="swipe-handler-p"><div class="modalInfo"><ons-icon icon="ion-ios-information-circle-outline"></ons-icon></div><div class="modalClose"><ons-icon icon="ion-ios-close"></ons-icon></div></div>'+
'<div class="popup-content">'+modalContent+'</div>'+
'</div>';

$('body').append(modal);




setTimeout(doSomething, 100);

function doSomething() {
   //do whatever you want here


let scrollingTimeout;
const scrollingElement = $('.popup-content');
var isItsCROLLING = false;


// Attach a scroll event listener to the element
   scrollingElement.on("scroll", function() {
      // Clear any existing timeout
      clearTimeout(scrollingTimeout);

      // Log that scrolling has started
      console.log("Scrolling started");
isItsCROLLING = true;
      // Set a timeout to detect when scrolling stops (e.g., after 300 milliseconds)
      scrollingTimeout = setTimeout(function() {
        // Log that scrolling has stopped
        console.log("Scrolling stopped");
        isItsCROLLING = false;
      }, 300);
    });

var isDragging = false;
var startY;
var draggableModals = $('.popup');
var threshold = 400; // Adjust the threshold for sliding down
var key = $('.searchAssetsInput');

const startDrag = (e) => {

    if(!isItsCROLLING){


  isDragging = true;
  startY = e.originalEvent.touches ? e.originalEvent.touches[0].clientY : e.clientY;
}
};

const doDrag = (e) => {
    if(!isItsCROLLING){

  if (isDragging) {

    const clientY = e.originalEvent.touches ? e.originalEvent.touches[0].clientY : e.clientY;
    
    const deltaY = clientY - startY;

    draggableModals.each(function () {
      const newTop = $(this).offset().top + deltaY;


var top = $(this).css('top');
var numericValue = parseFloat(top);


 // Move each modal vertically only if it's not going beyond the bottom of the page
      if (newTop >= $(window).height() - $(this).outerHeight()) {
 if (deltaY > 0) {
      console.log('Dragging down');
    } else if (deltaY < 0) {
      console.log('Dragging up');
      return;

    }

        $(this).css('top', newTop + 'px');

      }
      // Move each modal vertically
      //$(this).css('top', newTop + 'px');
    });

    // Update the start position for the next move
    startY = clientY;
  }

}
};

   const stopDrag = () => {

       if(!isItsCROLLING){


      isDragging = false;

      const modalBottom = parseFloat(draggableModals.css('top'));
      
      
      if (modalBottom > threshold) {
          

          //$(draggableModals).addClass('animated slideOutDown faster');
       

draggableModals.css('top', '');
            $('.page').removeClass('scaled');
$('.bottomToolbar').removeClass('scaled');
$('html').removeClass('blacked');
$('body').removeClass('blacked');
    $('.modal-in').css('bottom', '-3850px');
    $('.sheet-backdrop').removeClass('backdrop-in');
    $('.m_listitem').show();
    $('.searchAssetsInput').val('');
$('.popup').removeClass('popup-show');
    draggableModals.css('bottom', '');

    $('.popup').remove();

      } else {
        ///draggableModals.css('bottom', '-100%');
      }

   }
    };


draggableModals.on('mousedown touchstart', startDrag);
$(document).on('mousemove touchmove', doDrag);
$(document).on('mouseup touchend', stopDrag);

$('.assetListpopUp').addClass('popup-show');
$('.sheet-backdrop').addClass('backdrop-in');
}

}


//selct who to send the ticket to

$(document).on('click', '.whoSend', function(){ 
var who = $(this).attr('data-type');
whoToSend = who;

var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');



$('.whoSend').eq(0).addClass('animated slideOutLeft');
$('.whoSend').eq(1).addClass('animated slideOutRight');


setTimeout(doSomething, 1500);

function doSomething() {
   //$('.btnsHolder').hide();
   //$('.spgoholder').show();
}



if(whoToSend == 'ta'){


var values = { 
    'email': email,
    'accesstoken': accesstoken,
};

    $.ajax({
    url: ''+host+'getTicketAdmins_new.php',
    //dataType: 'text',
     //dataType: 'text',
    data: values,
    type: 'POST',
    success: function( data, textStatus, jQxhr ){


 console.log(data);
    var json = JSON.stringify(data);

   

    $('.selectAdminDropDown').empty();
    $('.proceedBtnsHolder').hide();
tiAdmin = '';

  var parsed_data = JSON.parse(data);
if(parsed_data['status'] == 'OK'){
  for(i=0;i<parsed_data.ticket_admins.length;i++){
var full_name = parsed_data.ticket_admins[i].name;
var id = parsed_data.ticket_admins[i].id;
var email = parsed_data.ticket_admins[i].email;
var status = parsed_data.ticket_admins[i].status;


$('.qrTA').show();


if(status == 'pending'){

 $('.selectAdminDropDown').append('<ons-list-item class="taSelector" data-value="'+id+'" tappable>'+
      '<label class="floatingRadio" data-value="'+id+'">'+full_name+
        '<ons-radio style="display:none;width:100% !important;text-align:center;display:none;" name="ta" class="taRadio" input-id="radio-'+id+'" value="'+id+'">'+full_name+'</ons-radio>'+
      '</label>'+
'</ons-list-item>');

}else{


     $('.selectAdminDropDown').append('<ons-list-item class="taSelector" data-value="'+id+'" tappable>'+
      '<label class="floatingRadio" data-value="'+id+'">'+full_name+' - '+email+
        '<ons-radio style="display:none;width:100% !important;text-align:center;" name="ta" class="taRadio" input-id="radio-'+id+'" value="'+id+'">'+full_name+' - '+email+'</ons-radio>'+
      '</label>'+
'</ons-list-item>');

}



  }

}

    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
    }
});

$('.qrTA_card').show();

}else if(whoToSend == 'sp'){

$('.qrTA_card').hide();
    
     $('.selectAdminDropDown').empty();

    $('.whoSend').eq(0).addClass('animated slideOutLeft');
$('.whoSend').eq(1).addClass('animated slideOutRight');


setTimeout(doSomething, 1500);

function doSomething() {
   //$('.btnsHolder').hide();
   //$('.spgoholder').show();
}



var sel = localStorage.getItem('c_serial');


    $.ajax({
    url: ''+host+'getAsset.php?serial='+sel+'&email='+email+'&accesstoken='+accesstoken+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

    var json = JSON.stringify(data);

     //var obj = parseJSON(data);
  var parsed_data = JSON.parse(data);

  var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

if(parsed_data['status'] == 'OK'){

var serial = parsed_data.asset['serial_number'];

var active_seller_packages = parsed_data.asset['active_seller_packages'];

console.log(JSON.stringify(parsed_data.asset['active_seller_packages']));

count = _.countBy(active_seller_packages, obj => obj.lot_title !== '');

var lang = localStorage.getItem('lang');


if(count.true > 1){

   

}else{

localStorage.setItem('moreSp', 'no');

}


$('.addAassetBtn').attr('data-serial', serial);


var assetSerial = serial;

var max_spend_percentage = parsed_data.asset['max_spend_percentage'];

if (max_spend_percentage > 100){

$('.hiddenField').hide();



}else{

$('.hiddenField').show();
var pr = localStorage.getItem('permissions_raise_internal_ticket');
if(pr == 'false' || pr == false){
$('.chooseAdminTicketSection').hide();
}else{
$('.chooseAdminTicketSection').show();
}

var fullname = parsed_data.asset['full_name'];

var active_seller_packages = parsed_data.asset['active_seller_packages'];

for(i=0;i<parsed_data.asset.active_seller_packages.length;i++){

var cname= parsed_data.asset.active_seller_packages[i].buyer.buyer_profile.company_name;
var lot_title = parsed_data.asset.active_seller_packages[i].lot_title;

 $('.selectAdminDropDown').append('<ons-list-item class="spSelector" data-value="'+lot_title+'" tappable>'+
      '<label class="floatingRadio" data-value="'+lot_title+'">'+lot_title+' - '+cname+
        '<ons-radio style="display:none;width:100% !important;text-align:center;" name="sp" class="taRadio" input-id="radio-'+lot_title+'" value="'+lot_title+'">'+lot_title+' - '+cname+'</ons-radio>'+
      '</label>'+
'</ons-list-item>');

}

}


}else{

console.log(data);
var parsed_data = JSON.parse(data);

$('.hiddenField').hide();

function alertDismissed() {

}

navigator.notification.alert(
    parsed_data['msg'],  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);

}




    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});



}
/*if(whoToSend == 'ta'){

var pr = localStorage.getItem('permissions_raise_internal_ticket');

if(pr == 'false' || pr == false){

}else{

addSheetModal({
  modalContent: '<div class="ticketAdmin_st">'+
'<p class="trn">Please choose an option</p>'+
  '<ons-list class="selectAdminDropDown qrTA">'+
  '</ons-list>'+
'<div class="qrTA" style="text-align:center;width:100%;color:black; margin-botton:12px;padding:10px;">OR</div>'+

'<label class="qrTA ticketInviteSt_qr trn" for="name" style="color:black;">Invite a New Ticket Admin</label>'+
'<input type="email" class="ticketInviteSt_qr newTicketAdmin_QR inps qrTA" placeholder="tony@canfixit.com" value="" />'+
  '</div>'
});





}

}else if(whoToSend == 'sp'){


addSheetModal({
  modalContent: '<div class="ticketAdmin_st">'+
'<p class="trn">Please choose an option</p>'+
  '<ons-list class="selectSPDropDown qrTA">'+
  '</ons-list>'+
  '</div>'
});


    
var sel = localStorage.getItem('c_serial');


    $.ajax({
    url: ''+host+'getAsset.php?serial='+sel+'&email='+email+'&accesstoken='+accesstoken+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

    var json = JSON.stringify(data);

     //var obj = parseJSON(data);
  var parsed_data = JSON.parse(data);

  var pmodal = document.getElementById('preloaderModal');
pmodal.hide();

if(parsed_data['status'] == 'OK'){

var serial = parsed_data.asset['serial_number'];

var active_seller_packages = parsed_data.asset['active_seller_packages'];

console.log(JSON.stringify(parsed_data.asset['active_seller_packages']));

count = _.countBy(active_seller_packages, obj => obj.lot_title !== '');


if(count.true > 1){

var lang = localStorage.getItem('lang');

}else{

localStorage.setItem('moreSp', 'no');

}


if(count.true > 1){

}else{



$('.addAassetBtn').attr('data-serial', serial);


var assetSerial = serial;

var max_spend_percentage = parsed_data.asset['max_spend_percentage'];

if (max_spend_percentage > 100){

$('.hiddenField').hide();



}else{

$('.hiddenField').show();

var fullname = parsed_data.asset['full_name'];

var active_seller_packages = parsed_data.asset['active_seller_packages'];

for(i=0;i<parsed_data.asset.active_seller_packages.length;i++){

var cname= parsed_data.asset.active_seller_packages[i].buyer.buyer_profile.company_name;
var lot_title = parsed_data.asset.active_seller_packages[i].lot_title;




 $('.selectSPDropDown').append('<ons-list-item class="spSelector" data-value="'+lot_title+'" tappable>'+
      '<label class="floatingRadio">'+
        '<ons-radio style="width:100% !important;text-align:center;" name="sp" class="taRadio" input-id="radio-'+lot_title+'" value="'+lot_title+'">'+lot_title+' - '+cname+'</ons-radio>'+
      '</label>'+
'</ons-list-item>');




 

}

}
}

}else{

console.log(data);
var parsed_data = JSON.parse(data);

$('.hiddenField').hide();

function alertDismissed() {

}

navigator.notification.alert(
    parsed_data['msg'],  // message
    alertDismissed,         // callback
    'Attention',            // title
    'OK'                  // buttonName
);

}




    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});



}*/


$('.proceedbtns').show();

  var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);

});

//tapping on modal close
$(document).on('click', '.modalClose', function(){

    $('.popup').css('top', '');
            $('.page').removeClass('scaled');
$('.bottomToolbar').removeClass('scaled');
$('html').removeClass('blacked');
$('body').removeClass('blacked');
    $('.modal-in').css('bottom', '-3850px');
    $('.sheet-backdrop').removeClass('backdrop-in');
    $('.m_listitem').show();
    $('.searchAssetsInput').val('');
$('.popup').removeClass('popup-show');
    $('.popup').css('bottom', '');

    $('.popup').remove();

    $('.modernpopup').css('transform', `translateY(10000px)`);
$('.modernpopup').remove();
     

});
//tapping on modal Info
$(document).on('click', '.modalInfo', function(){

    

function alertDismissed() {
    // do something
}
var lang = localStorage.getItem('lang');
var offlineMessage;

if (lang == 'ge') {
    offlineMessage = 'Sie können diesen Bildschirm schließen, indem Sie ihn nach unten ziehen oder außerhalb davon tippen oder auf das X-Symbol oben links tippen.';
} else if (lang == 'po') {
    offlineMessage = 'Você pode fechar esta tela arrastando para baixo ou tocando fora dela ou no X no canto superior esquerdo.';
} else if (lang == 'sp') {
    offlineMessage = 'Puedes cerrar esta pantalla deslizándola hacia abajo o tocando fuera de ella o en la X en la esquina superior izquierda.';
} else if (lang == 'bul') {
    offlineMessage = 'Можете да затворите този екран, като го плъзгате надолу или като чукнете извън него или на X-знака отгоре вляво.';
} else if (lang == 'it') {
    offlineMessage = 'Puoi chiudere questa schermata trascinandola verso il basso o toccando all\'esterno o sull\'icona X in alto a sinistra.';
} else if (lang == 'fr') {
    offlineMessage = 'Vous pouvez fermer cet écran en le faisant glisser vers le bas ou en tapant à l\'extérieur ou sur le signe X en haut à gauche.';
} else if (lang == 'ar') {
  offlineMessage = 'يمكنك إغلاق هذه الشاشة عن طريق سحبها لأسفل أو النقر في الخارج أو على علامة "X" في الزاوية العلوية اليسرى.'
}else if (lang == 'ja') {
  offlineMessage = 'この画面を閉じるには、下にスワイプするか、外側をクリックするか、左上隅の「X」マークをクリックしてください。';
}else if (lang == 'tu') {
  offlineMessage = 'Bu ekranı kapatmak için aşağıya kaydırın, dışına tıklayın veya sol üst köşedeki "X" işaretine tıklayın.';

}else {
    // Default to the original text if the language code is not recognized
    offlineMessage = 'You can close this screen by dragging it down or by tapping on outside of it or on the X sign on the top left.';
}

// Now you can use the variable offlineMessage in your code.
navigator.notification.alert(offlineMessage, alertDismissed, '', 'OK');

});


//get newTicketAdmin_QR value 
$(document).on('keyup', '.newTicketAdmin_QR', function(){
    var v = $(this).val();
if( !validateEmail(v)) { $('.proceedBtnsHolder').hide(); }else{$('.proceedBtnsHolder').show();}

newTicketAdminQR = v;

    $('input[name=ta]').prop("checked", false);
    $('.floatingRadio').removeClass('tinted');

});



//select who to send ticket to in manual
$(document).on('click', '.whoSendm', function(){ 

if($(this).hasClass('spwhom')){
    manualTicketType = 'sp';
}else if($(this).hasClass('tawhom')){
manualTicketType = 'ta';
}else if($(this).hasClass('intwhom')){
manualTicketType = 'int';
}

var who = $(this).attr('data-type');
whoToSend = who;

var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

$('.tyselectedIndicator').fadeOut();
$(this).append('<div class="tyselectedIndicator"><ons-icon icon="fa-check"></ons-icon></div>');


var pr = localStorage.getItem('permissions_raise_internal_ticket');


if(whoToSend == 'ta'){

    $('.serviceContactHolder').hide();
    $('.chooseTechSection').hide();
    $('.chooseAdminTicketSection').show();

    //$('.ticketAdminSelect').removeAttr("disabled");
    //$('.newTicketAdmin').removeAttr("disabled");
    //$('.serviceConractSelect').prop("disabled", true);

}else if(whoToSend == 'sp'){

    $('.chooseAdminTicketSection').hide();
    $('.chooseTechSection').hide();
    $('.serviceContactHolder').show();

      //$('.serviceConractSelect').removeAttr("disabled");
    //$('.ticketAdminSelect').prop("disabled", true);
    //$('.newTicketAdmin').prop("disabled", true);

}else if(whoToSend == 'int'){

      $('.chooseAdminTicketSection').hide();
    $('.chooseTechSection').show();
    $('.serviceContactHolder').hide();

    //$('.ticketAdminSelect').prop("disabled", true);
    //$('.newTicketAdmin').prop("disabled", true);
    //$('.serviceConractSelect').prop("disabled", true);

}

});



//select who to send ticket to in manual
$(document).on('click', '.spgoholderClose', function(){ 


 $('.spgoholder').hide();



setTimeout(doSomething, 1000);

    
function doSomething() {

$('.whoSend').eq(0).removeClass('animated slideOutLeft');
$('.whoSend').eq(1).removeClass('animated slideOutRight');


$('.whoSend').eq(0).addClass('animated slideInLeft');
$('.whoSend').eq(1).addClass('animated slideInRight');


 //$('.btnsHolder').show();
  
}

});


//get selected SP or TA
$(document).on('click', '.floatingRadio', function(){ 

$('.proceedbtns').show();
$('.floatingRadio').removeClass('tinted');
$(this).addClass('tinted');

var v = $(this).attr('data-value');

newTicketAdminQR = '';

if(whoToSend == 'ta'){


     tiAdmin = v;
 $('.proceedBtnsHolder').show();
 $('.newTicketAdmin_QR').val('');


}else if(whoToSend == 'sp'){

    

    asset_sps = [];
 var selectedsp = v;
 asset_sps.push(selectedsp);

}

});


$(document).on('focus', '.wholeNote', function(){ 
$(this).val('');
});



$(document).on('click', '.c-note55', function(){ 

/*if (localStorage.getItem('inCall') != null){

}else{
var modal = document.getElementById('callModal');
modal.show({animation: 'lift'});
localStorage.setItem('inCall', 'yes');
}*/

var modal = document.getElementById('callModal');
modal.show({animation: 'lift'});
localStorage.setItem('inCall', 'yes');



const videos = document.getElementById('localVideo'); 
    const remoteVideo = document.getElementById('remoteVideo');
    const callButton = document.getElementById('callButton');
    const closeButton = document.getElementById('closeCall');
    let localStream;
    var localMediaStream;
    var mediaConnection;


var decodedStringBtoA = localStorage.getItem('email');

// Encode the email to turn it into a string ID
var encodedStringBtoA = btoa(decodedStringBtoA);
encodedStringBtoA = encodedStringBtoA.replace('=','');
console.log(encodedStringBtoA);



//Decode the email to turn it into a string ID
var encodedStringAtoB = "ZGFuaWVsQG9yYml0NC5vcmc";
// Decode the String
var decodedStringAtoB = atob(encodedStringAtoB);
console.log(decodedStringAtoB);


        // Create a unique peer ID
        var email = encodedStringBtoA;
	  const customPeerId = "Highup";
      //alert(customPeerId);
    const peer = new Peer(customPeerId,{
      debug: 3,
    });
const constraints = {
            audio: false,
            video: true
            }
navigator.mediaDevices.getUserMedia(constraints)
                .then(Stream => {
                    localMediaStream = Stream;
                    if ('srcObject' in videos) {
                        console.log("Stream");
                        videos.srcObject = Stream;


        // Event handling for incoming call
        peer.on('call', (call) => {
            mediaConnection = call;


                //play notification audio 
            var audio = new Audio('ringing-151670.mp3');
            audio.play();

navigator.vibrate(3000);

//notify the user of incoming call
setTimeout(noti, 1000);
function noti() {
            var acceptsCall = confirm("Videocall incoming, do you want to accept it ?");
          if (acceptsCall) {

if (localStorage.getItem('inCall') != null){

}else{
var modal = document.getElementById('callModal');
modal.show({animation: 'lift'});
localStorage.setItem('inCall', 'yes');
}


          // Answer the call and send our stream to the remote peer
          call.answer(localStream);
          $('.remotv').addClass('remoteVideo');
          // Event handling for receiving remote stream
          call.on('stream', (remoteStream) => {
            remoteVideo.srcObject = remoteStream;
          });

     
          }

        }

        });
                        
                    } else {
                        console.log("Stream Src");
                        videos.src = window.URL.createObjectURL(Stream);                     
                    }

                    videos.onloadedmetadata = function(e) {
                        videos.play();
                    };
                    
                    //video.play();

                    window.addEventListener("onbeforeunload", function(event) {     
                        //const tracks = Stream.getTracks();
                        const tracks = localMediaStream.getTracks();
                        tracks.forEach(function(track) {
                            track.stop();
                            console.log("Stop Track");
                        })
                        video.srcObject = null;
                        //Stream = null;
                        localMediaStream = null;
                    })


                })
                .catch(err => {
                    //alert("Camera Not Supported");
                    //alert(JSON.stringify(err));
                });


    // Event handling for opening a connection
    peer.on('open', (id) => {
      //alert('My peer ID is: ' + id);
    });

    // Event handling for errors
    peer.on('error', (err) => {
      //alert('PeerJS error:', err);
    });

    // Function to initiate a call to a remote peer
    function callPeer(peerId) {
      const call = peer.call(peerId, localMediaStream);

      // Event handling for receiving remote stream
      call.on('stream', (remoteStream) => {
         mediaConnection = call;
        remoteVideo.srcObject = remoteStream;
         
      });
    }

    // Event handling for the "Call" button click
callButton.addEventListener('click', () => {
$('.content-centerh').show();

setTimeout(doSomething, 5000);
function doSomething() {
   //do whatever you want here
   $('.remotv').addClass('remoteVideo');
        callPeer("Rooz54");
        $('.content-centerh').hide();
}
      //const peerToCall = prompt('enter ID:');
      //if (peerToCall) {
       //   $('.remotv').addClass('remoteVideo');
        //callPeer(peerToCall);
      //}
    });

    closeButton.addEventListener('click', () => {
        localStorage.removeItem('inCall');
    var modal = document.getElementById('callModal');modal.hide({animation: 'lift'});
mediaConnection.close();
    });

});


function callQRscannerUpholstery(){

      var lang = localStorage.getItem('lang');

      if (lang == 'ge') {
    notdetected = 'QR-Code nicht erkannt';
} else if (lang == 'po') {
    notdetected = 'Código QR não reconhecido';
} else if (lang == 'sp') {
    notdetected = 'Código QR no reconocido';
} else if (lang == 'bul') {
    notdetected = 'QR-кодът не е разпознат';
} else if (lang == 'it') {
    notdetected = 'Codice QR non riconosciuto';
} else if (lang == 'fr') {
    notdetected = 'Code QR non reconnu';
} else if (lang == 'ar') {
    notdetected = 'الرمز الشريطي QR غير معترف به';
} else if (lang == 'ja') {
   notdetected = 'QRコードが検出されませんでした';
} else if (lang == 'tu') {
notdetected = 'QR kodu algılanamadı';

} else {
    // Default to the original text if the language code is not recognized
    notdetected = 'QR Code not detected';
}

 //check the devce type here
//SpinnerDialog.show(null, "Please wait...");

//start of the scanner...

cordova.plugins.mlkit.barcodeScanner.scan(
  barCodeOptions,
  (result) => {

    //monaca.BarcodeScanner.scan((result) => {
    //if (result.cancelled) {
      // scan cancelled
    //} else {

//const serial = result.data.text;

var serial = result.text;

localStorage.setItem('c_serial', serial);
var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

//$(this).prop('disabled', true);
//$('.loaderIcon').show();

var pmodal = document.getElementById('preloaderModal');
pmodal.show();



//new edits here
//$('.proceedbtns').show();
$('.custom_card').show();
//$('.qrTA').hide();
//$('.ticketAdmin_QR').empty();
$('.selectAdminDropDown').empty();
tiAdmin = '';
whoToSend = 'sp';


$.ajax({
    url: ''+host+'getAsset.php?serial='+serial+'&email='+email+'&accesstoken='+accesstoken+'&force=1',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){

var pmodal = document.getElementById('preloaderModal');
pmodal.hide();


console.log(data);

    var json = JSON.stringify(data);

     //var obj = parseJSON(data);
  var parsed_data = JSON.parse(data);

if(parsed_data['status'] == 'OK'){

var active_seller_packages_array = parsed_data.asset['active_seller_packages'];

var pr = localStorage.getItem('permissions_raise_internal_ticket');

var max_spend_percentage = parsed_data.asset['max_spend_percentage'];

if (max_spend_percentage > 100){


var lang = localStorage.getItem('lang');
var alertTitle, alertMessage;

if (lang == 'ge') {
    alertTitle = 'Achtung';
    alertMessage = 'Das maximale Ausgabenbudget für Asset ' + serial + ' wurde erreicht. Bitte erhöhen Sie das maximale Ausgabenlimit für diesen Vermögenswert.';
} else if (lang == 'po') {
    alertTitle = 'Atenção';
    alertMessage = 'O orçamento máximo de gastos para o ativo ' + serial + ' foi atingido. Por favor, aumente o limite máximo de gastos para este ativo.';
} else if (lang == 'sp') {
    alertTitle = 'Atención';
    alertMessage = 'Se ha alcanzado el presupuesto máximo de gastos para el activo ' + serial + '. Por favor, aumente el límite máximo de gastos para este activo.';
} else if (lang == 'bul') {
    alertTitle = 'Внимание';
    alertMessage = 'Максималният бюджет за разходи за актива ' + serial + ' е достигнат. Моля, увеличете максималния лимит за разходи за този актив.';
} else if (lang == 'it') {
    alertTitle = 'Attenzione';
    alertMessage = 'Il budget massimo di spesa per l\'asset ' + serial + ' è stato raggiunto. Si prega di aumentare il limite massimo di spesa per questo asset.';
} else if (lang == 'fr') {
    alertTitle = 'Attention';
    alertMessage = 'Le budget maximal de dépenses pour l\'actif ' + serial + ' a été atteint. Veuillez augmenter la limite maximale de dépenses pour cet actif.';
} else if (lang == 'ar') {
  alertTitle = 'تنبيه';
alertMessage = 'تم الوصول إلى الحد الأقصى للميزانية المخصصة للنفقات للعنصر ' + serial + '. يرجى زيادة الحد الأقصى للنفقات لهذا العنصر';
}else if (lang == 'ja') {
alertTitle = '警告';
alertMessage = 'このアイテムの予算上限に達しました ' + serial + '。このアイテムの予算上限を増やしてください。';
}else if (lang == 'tu') {
var alertTitle = 'Uyarı';
var alertMessage = 'Bu öğenin bütçe sınırına ulaşıldı ' + serial + '. Lütfen bu öğenin bütçe sınırını artırın.';

}else {
    // Default to English if the language code is not recognized
    alertTitle = 'Attention';
    alertMessage = 'The maximum spend budget has been reached for asset ' + serial + '. Please raise the maximum spend limit for this asset.';
}

function alertDismissed() {
    // Do something when the alert is dismissed
}

navigator.notification.alert(
    alertMessage,  // message
    alertDismissed,         // callback
    alertTitle,            // title
    'OK'                  // buttonName
);

}//else{


//get the serial number of the scanned asset for upholstery
var serial = parsed_data.asset['serial_number'];
serial_numbers = [];
serial_numbers.push(serial);
var manufacturer_serial_number = parsed_data.asset['manufacturer_serial_number'];
var active_seller_packages = parsed_data.asset['active_seller_packages'];

var fullname = parsed_data.asset['full_name'];
$('.assetFullname').text(fullname);

if (parsed_data.asset['image'] == null) {
var pmodal = document.getElementById('preloaderModal');
pmodal.hide();



$('.assetImgShow').html("<ons-list-item ><div class='left' style='margin-right:10px;'><img class='list-item__thumbnail largeThumb' src='images/no_img.jpg'></div><div class='center'><span class='list-item__title smallerTitle'>"+fullname+"</span><span class='list-item__subtitle'><span class='trn'>Serial No':</span> "+manufacturer_serial_number+"</span><span class='list-item__subtitle'><span class='trn'>QR No':</span> "+serial+"</span></div></ons-list-item>");


}else{

var image = parsed_data.asset['image']['large'];


console.log('url(https://'+apiType+'.weservicegymequipment.com/'+image+') no-repeat center center');

$('.assetImgShow').html("<ons-list-item ><div class='left' style='margin-right:10px;'><img class='list-item__thumbnail largeThumb' src='https://"+apiType+".weservicegymequipment.com/"+image+"'></div><div class='center'><span class='list-item__title smallerTitle'>"+fullname+"</span><span class='list-item__subtitle'><span class='trn'>Serial No':</span> "+manufacturer_serial_number+"</span><span class='list-item__subtitle'><span class='trn'>QR No':</span> "+serial+"</span></div></ons-list-item>");

$('.addAassetBtn').attr('data-image', 'https://'+apiType+'.weservicegymequipment.com/'+image+'');

$('.imgRemover').attr('data-serial', serial);

}





localStorage.setItem('moreSp', 'yes');
$('.spList').html('');

var active_seller_packages = parsed_data.asset['active_seller_packages'];

var count = _.countBy(active_seller_packages, obj => obj.upholstery === 1);

console.log(JSON.stringify(count));


//check if the asset's in an upholstery service contract here
if (count.hasOwnProperty('true') && count.true >= 1) {



    for(i=0;i<parsed_data.asset.active_seller_packages.length;i++){

var active_seller_packages = parsed_data.asset.active_seller_packages;

//melllll

//count = count + hasUpholstryPermission;

var hid = 0;

   var currentPackage = parsed_data.asset.active_seller_packages[i];

    // Check if upholstery is equal to 1
    if (currentPackage.upholstery === 1) {

    
//bargard
var lot_title = parsed_data.asset.active_seller_packages[i].lot_title;
var company_name = parsed_data.asset.active_seller_packages[i].buyer.buyer_profile?.company_name;

 $('.selectAdminDropDown').append('<ons-list-item class="spSelector" data-value="'+lot_title+'" tappable>'+
      '<label class="floatingRadio" data-value="'+lot_title+'">'+lot_title+' - '+company_name+
        '<ons-radio style="display:none;width:100% !important;text-align:center;" name="sp" class="taRadio" input-id="radio-'+lot_title+'" value="'+lot_title+'">'+lot_title+' - '+company_name+'</ons-radio>'+
      '</label>'+
'</ons-list-item>');

hid = 1;

$('.custom_card').hide();
$('.qrTA_card').hide();
$('.qrTA').hide();
$('.floatingRadio').click();

    }else{

        hid = 0;

var lot_title = parsed_data.asset.active_seller_packages[i].lot_title;
var company_name = parsed_data.asset.active_seller_packages[i].buyer.buyer_profile?.company_name;

 $('.selectAdminDropDown').append('<ons-list-item class="spSelector" data-value="'+lot_title+'" tappable>'+
      '<label class="floatingRadio" data-value="'+lot_title+'">'+lot_title+' - '+company_name+
        '<ons-radio style="display:none;width:100% !important;text-align:center;" name="sp" class="taRadio" input-id="radio-'+lot_title+'" value="'+lot_title+'">'+lot_title+' - '+company_name+'</ons-radio>'+
      '</label>'+
'</ons-list-item>');
$('.custom_card').show();
$('.qrTA_card').hide();
$('.qrTA').show();
    }



}

$('.addAassetBtn').attr('data-serial', serial);

$('.upholstryCard').show();

$('.asset_note').remove();
$('<textarea class="uphasset_note asset_note trn" data-prev="" style="box-sizing: border-box; display: inline-block; min-height: 70px;  width: calc(100% - 18px);margin-left: 9px;margin-right: 9px;" placeholder="Please describe the pads you need replacing"></textarea>').insertAfter('.after');

$('.repBtn').click();
$('.priHolder').hide();
$('.large_repBtn').remove();

$('<div class="large_repBtn" style=""><ons-icon size="30px" icon="ion-ios-repeat"></ons-icon><br><span class="trn">Replacement - order new item</span><div class="selectedIndicatorUp"><ons-icon icon="fa-check"></ons-icon></div></div>').insertBefore('.priHolder');



  // Check if the element is hidden
  if (hid == 1) {


      
    $('.uphasset_note, .large_repBtn').css('margin-top', '50px');
    $('.uphasset_note').css('height', '120px');


  } else {
    console.log('The element is visible.');
  }

var lang = localStorage.getItem('lang');
var translator = $(document).translate({lang: "en", t: dict});
translator.lang(lang);


var modal = document.getElementById('assetmodal');
modal.show({animation: 'lift'});  
  

}else{



document.querySelector('#myNavigator').popPage();

var lang = localStorage.getItem('lang');
var msg = 'This asset is not in an upholstery service contract!';

if (lang == 'ge') {
    msg = 'Dieses Vermögen befindet sich nicht in einem Polsterungsdienstvertrag!';
} else if (lang == 'po') {
    msg = 'Este ativo não está em um contrato de serviço de estofamento!';
} else if (lang == 'sp') {
    msg = '¡Este activo no está en un contrato de servicio de tapicería!';
} else if (lang == 'bul') {
    msg = 'Този актив не е в договор за обзавеждане!';
} else if (lang == 'it') {
    msg = 'Questo asset non è in un contratto di servizio di tappezzeria!';
} else if (lang == 'fr') {
    msg = 'Cet actif n\'est pas dans un contrat de service de rembourrage!';
} else if (lang == 'ar') {
    msg = 'هذا العنصر ليس في عقد خدمة الحشو';
}else if (lang == 'ja') {
    msg = 'このアイテムは、クッションのサービス契約に含まれていません。';
}else if (lang == 'tu') {
    msg = 'Bu öğe yastık hizmet sözleşmesine dahil değil.';

}else {
    msg = 'This asset is not in an upholstery service contract!';
}

navigator.notification.alert(
    msg,  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);

function alertDismissed() {

}

return;

}



//}
//new code above

$('.note').val('');




}else{

console.log(data);
var parsed_data = JSON.parse(data);



function alertDismissed() {

}

navigator.notification.alert(
    parsed_data['msg'],  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);

}




    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
    }
});



      
//daniel is a cunt
    // }
  //}, (error) => {
     //permission error
    //const error_message = error;
  //}, {
    //"oneShot" : true,
    //"timeoutPrompt" : {
    // "show" : true,
    //"timeout" : 5,
     //"prompt" : "Not detected"
   // }
//}); 


    },
  (error) => {
    // Error handling
  },
);
//end of scanner

}

//function to get my contracts
function getMyContracts() {
    var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');

$.ajax({
    url: ''+host+'getMyContracts.php?email='+email+'&accesstoken='+accesstoken+'',
    //dataType: 'text',
    type: 'GET',
    processData: false,
    success: function( data, textStatus, jQxhr ){


      var json = JSON.stringify(data);

      console.log(data);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);

if (parsed_data && typeof parsed_data === 'object' && parsed_data.contracts) {
for(i=0;i<parsed_data.contracts.length;i++){

var upholstery = parsed_data.contracts[i].upholstery;

console.log("++++++++++++++++++++++++++++++++++++");
console.log(upholstery);

if(upholstery == 1 || upholstery == '1'){

//var someElements = document.querySelectorAll('.goToUh');
//$(someElements[1]).removeClass('.goToUpholsteryBtn');

$(".goToUh").attr("class", "go-el myColHolder goToUh");
}

}

    }

    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
    }
});

}


//submit upholstery ticket
$(document).on('click', '.submitUpholsterBtn', function(){ 


if(upholsteryImg == 0){
    
var lang = localStorage.getItem('lang');

var alertTitle, alertMessage;

if (lang == 'ge') {
    alertTitle = 'Achtung';
    alertMessage = 'Bitte fügen Sie vor dem Absenden dieses Tickets ein Bild hinzu!';
} else if (lang == 'po') {
    alertTitle = 'Atenção';
    alertMessage = 'Por favor, adicione uma imagem antes de enviar este ticket!';
} else if (lang == 'sp') {
    alertTitle = 'Atención';
    alertMessage = 'Por favor, añade una imagen antes de enviar este ticket.';
} else if (lang == 'bul') {
    alertTitle = 'Внимание';
    alertMessage = 'Моля, добавете изображение преди да изпратите този билет!';
} else if (lang == 'it') {
    alertTitle = 'Attenzione';
    alertMessage = 'Per favore, aggiungi un\'immagine prima di inviare questo ticket!';
} else if (lang == 'fr') {
    alertTitle = 'Attention';
    alertMessage = 'S\'il vous plaît, ajoutez une image avant de soumettre ce ticket !';
} else if (lang == 'ar') {
alertTitle = 'تنبيه';
alertMessage = 'يرجى إضافة صورة قبل تقديم هذه التذكرة';
}else if (lang == 'ja') {
alertTitle = '警告';
alertMessage = 'このチケットを提出する前に画像を追加してください。';
}else if (lang == 'tu') {
alertTitle = 'Uyarı';
alertMessage = 'Bu bileti göndermeden önce bir resim ekleyin lütfen.';

}else {
    // Default to English if the language code is not recognized
    alertTitle = 'Attention';
    alertMessage = 'Please add an image before submitting this ticket!';
}

Swal.fire({
    title: alertTitle,
    text: alertMessage,
    icon: 'warning',
    showCancelButton: false,
    confirmButtonColor: '#da116d',
    //cancelButtonColor: '#d33',
    confirmButtonText: 'OK'
});
    return;
}

var email = localStorage.getItem('email');
var accesstoken = localStorage.getItem('accesstoken');


// Assuming you have a canvas element with id 'myCanvas'
var canvas = document.getElementById('myCanvas');
var context = canvas.getContext('2d');


// Get the base64 encoded image data
var imageDataURL = canvas.toDataURL('image/png'); // You can also use 'image/jpeg' or 'image/webp'
newAddImgs.push(imageDataURL);

var note = $('.asset_note').val();
descriptions.push(note);

//shelli
console.log(JSON.stringify(descriptions));
//return;

var dis = JSON.stringify(descriptions);
var sers = JSON.stringify(serial_numbers);
var assSps = JSON.stringify(asset_sps);
var images = newAddImgs;
var singleSerial =serial_numbers[0];

var pmodal = document.getElementById('preloaderModal');
pmodal.show();

//this is what we send to the server
var values = {
    'type': 'standard',
            'sps': assSps,
            'email': email,
            'accesstoken': accesstoken,
            'serial_number': sers,
            'description': dis,
            'images': images,
            'singleSerial': singleSerial,
            'priority': 'Replacement',
    };

console.log(JSON.stringify(values));

//return;

$.ajax({
    url: ''+host+'...submitTicketQR.php',
     //dataType: 'text',
    data: values,
    type: 'POST',
    success: function( data, textStatus, jQxhr ){

var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
      var json = JSON.stringify(data);

      console.log(data);

     //var obj = parseJSON(data);
var parsed_data = JSON.parse(data);


if(parsed_data['status'] == 'OK'){

$('.newTicketAdmin_QR').val('');
asset_sps = [];
descriptions = [];
serial_numbers = [];

var hideAlertDialog = function() {
  document
    .getElementById('my-alert-dialog')
    .hide();
};


var lang = localStorage.getItem('lang');



function alertDismissed() {
    document.querySelector('#myNavigator').popPage();
}

if (lang == 'ge') {
    navigator.notification.alert(
        'Ihr Ticket wurde erfolgreich versendet.',  // message
        alertDismissed,         // callback
        'Bestätigung',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'po') {
    navigator.notification.alert(
        'Seu novo ticket foi enviado com sucesso.',  // message
        alertDismissed,         // callback
        'Sucesso',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'sp') {
    navigator.notification.alert(
        'Su nuevo ticket ha sido enviado con éxito.',  // message
        alertDismissed,         // callback
        'Éxito',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'bul') {
    navigator.notification.alert(
        'Новият ви билет беше изпратен успешно.',  // message
        alertDismissed,         // callback
        'Успех',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'it') {
    navigator.notification.alert(
        'Il tuo nuovo ticket è stato inviato con successo.',  // message
        alertDismissed,         // callback
        'Successo',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'fr') {
    navigator.notification.alert(
        'Votre nouveau ticket a été envoyé avec succès.',  // message
        alertDismissed,         // callback
        'Succès',            // title
        'OK'                  // buttonName
    );
}  else if (lang == 'ar') {
navigator.notification.alert(
    'تم إرسال التذكرة الجديدة بنجاح',  // message
    alertDismissed,         // callback
    'نجاح',            // title
    'حسنًا'                  // buttonName
);
} else if (lang == 'ja') {
navigator.notification.alert(
    '新しいチケットが正常に送信されました',  // メッセージ
    alertDismissed,         // コールバック
    '成功',            // タイトル
    '了解'                  // ボタン名
);
} else if (lang == 'tu') {
navigator.notification.alert(
    'Yeni bilet başarıyla gönderildi',  // Mesaj
    alertDismissed,         // Geri arama
    'Başarılı',            // Başlık
    'Anladım'                  // Düğme Adı
);

}else {
    // Default to the original text if the language code is not recognized
    navigator.notification.alert(
        'Your new ticket has been sent.',  // message
        alertDismissed,         // callback
        'Success',            // title
        'OK'                  // buttonName
    );
}


newAddImgs =[];


}else{




function alertDismissed() {

}

navigator.notification.alert(
    parsed_data['msg'],  // message
    alertDismissed,         // callback
    '',            // title
    'OK'                  // buttonName
);

newAddImgs =[];

}


    },
    error: function( jqXhr, textStatus, errorThrown ){
        console.log( errorThrown );
        var pmodal = document.getElementById('preloaderModal');
pmodal.hide();
    }
});


});

  
  
//add image to uphosltery ticket
$(document).on('click', '.addimgUpholsteryBtn', function(){ 


var numItems = $('.addedAsset').length; 

if(numItems == 0){

var lang = localStorage.getItem('lang');

var alertTitle, alertMessage;

if (lang == 'ge') {
    alertTitle = 'Achtung';
    alertMessage = 'Bitte fügen Sie diesem Ticket zuerst ein Asset hinzu, bevor Sie Bilder hinzufügen!';
} else if (lang == 'po') {
    alertTitle = 'Atenção';
    alertMessage = 'Por favor, adicione um ativo a este chamado antes de adicionar imagens!';
} else if (lang == 'sp') {
    alertTitle = 'Atención';
    alertMessage = 'Por favor, añada un activo a este ticket antes de agregar imágenes.';
} else if (lang == 'bul') {
    alertTitle = 'Внимание';
    alertMessage = 'Моля, добавете актив към този билет, преди да добавите изображения!';
} else if (lang == 'it') {
    alertTitle = 'Attenzione';
    alertMessage = 'Si prega di aggiungere un asset a questo ticket prima di aggiungere immagini!';
} else if (lang == 'fr') {
    alertTitle = 'Attention';
    alertMessage = 'Veuillez ajouter un actif à ce ticket avant d\'ajouter des images !';
} else if (lang == 'ar') {
alertTitle = 'تنبيه';
alertMessage = 'يرجى إضافة عنصر إلى هذه التذكرة قبل إضافة الصور';
}else if (lang == 'ja') {
alertTitle = '警告';
alertMessage = '画像を追加する前に、このチケットにアイテムを追加してください';
}else if (lang == 'tu') {
alertTitle = 'Uyarı';
alertMessage = 'Bu bilet için öğe eklemek gerekiyor önce resim ekleyin.';

}else {
    // Default to English if the language code is not recognized
    alertTitle = 'Attention';
    alertMessage = 'Please add an asset to this ticket first before adding images!';
}

Swal.fire({
    title: alertTitle,
    text: alertMessage,
    icon: 'warning',
    showCancelButton: false,
    confirmButtonColor: '#da116d',
    //cancelButtonColor: '#d33',
    confirmButtonText: 'OK'
});


return;
}

 var elementHeight = $(".canvas-container").height();

  navigator.camera.getPicture(onSuccess, onFail, { 
    quality: 100,
    destinationType: Camera.DestinationType.DATA_URL,
    sourceType: Camera.PictureSourceType.CAMERA,
    encodingType: Camera.EncodingType.JPEG,
   targetWidth: screen.width,
    targetHeight: elementHeight,
    correctOrientation: true
});

function onSuccess(imageData) {

Swal.close();

        const canvas = document.getElementById("myCanvas");
    const ctx = canvas.getContext("2d");
    upholsteryImg = 1;
    
        canvas.addEventListener("mouseover", function() {
      canvas.style.cursor = "crosshair";
    });

    // Handle mouseout event to reset the cursor
    canvas.addEventListener("mouseout", function() {
      canvas.style.cursor = "url('https://image.similarpng.com/very-thumbnail/2021/06/Design-of-click-icon-with-hand-cursor.-Hand-is-pushing-the-button.png'), auto;'), auto";
    });

    // Set canvas size
    const canvasSize = Math.min(window.innerWidth, window.innerHeight);
    canvas.width = canvasSize;
    canvas.height = canvasSize;

    // Load base64 image
    const base64Image = "data:image/jpeg;base64,"+imageData;
  const img = new Image();
    img.src = base64Image;
$('.canvas-container').show();
$('.tapinfo').show();

    img.onload = function () {
        // Draw the image on the canvas
        ctx.drawImage(img, 0, 0, canvasSize, canvasSize);
    };

    // Array to store information about circles
    const circles = [];

    // Handle click/tap events
    canvas.addEventListener("click", function (event) {
        const rect = canvas.getBoundingClientRect();
        const x = (event.clientX - rect.left) / (rect.width / canvas.width);
        const y = (event.clientY - rect.top) / (rect.height / canvas.height);

        // Add information about the clicked circle to the array
        circles.push({ x, y, number: circles.length + 1 });

        // Start the animation
        animateCircles(ctx, circles, img);
    });


    function animateCircles(ctx, circles, img) {
    const animationDuration = 1000; // in milliseconds
    const startRadius = 0;
    const endRadius = 10;
    const fillColor = "yellow";
    const borderColor = "black";
    const textColor = "black";
    const startTime = Date.now();

    function drawFrame() {
        const elapsed = Date.now() - startTime;
        const progress = Math.min(elapsed / animationDuration, 1);

        // Clear the canvas
        ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);

        // Redraw the image on the canvas
        ctx.drawImage(img, 0, 0, ctx.canvas.width, ctx.canvas.height);

        circles.forEach(circle => {
            const currentRadius = startRadius + progress * (endRadius - startRadius);

            // Draw a circle with a border
            ctx.beginPath();
            ctx.arc(circle.x, circle.y, currentRadius, 0, 20 * Math.PI);
            ctx.fillStyle = fillColor;
            ctx.fill();
            ctx.strokeStyle = borderColor;
            ctx.lineWidth = 2;
            ctx.stroke();
            ctx.closePath();

            // Draw the number in the center of the circle
            ctx.fillStyle = textColor;
            ctx.font = "bold 14px Arial";
            const textWidth = ctx.measureText(circle.number).width;
            ctx.fillText(circle.number, circle.x - textWidth / 2, circle.y + 5);
        });

        if (progress < 1) {
            requestAnimationFrame(drawFrame);
        }

        $('.upholstryCard').show();
    }

    requestAnimationFrame(drawFrame);
}


}


function onFail(error) {


}


});


    /*window.addEventListener('deviceorientation', handleOrientation);

    function handleOrientation(event) {
        const beta = event.beta; // Use beta for tilt along the device's front-to-back axis
        const gamma = event.gamma; // Use gamma for tilt along the device's left-to-right axis

        // Adjust the rotation of the buttons based on the device orientation
        const buttons = document.querySelectorAll('.langHolderInner');
        buttons.forEach(button => {
            button.style.transform = `rotateY(${gamma}deg)`;
        });
    }*/



function checkMicrophonePermission() {
    cordova.plugins.diagnostic.getMicrophoneAuthorizationStatus(function(status){
        if (status === cordova.plugins.diagnostic.permissionStatus.GRANTED) {
            // Permission granted, do nothing
            console.log("Microphone permission granted");
        } else {
            // Request permission



            
        }
    }, function(error){
        console.error("Error checking microphone permission: " + error);
    });
}


//speech recognition 
$(document).on('click', '.requestMicPermissionBtn', function(e){
requestMicrophonePermission();

});


function requestMicrophonePermission() {
    cordova.plugins.diagnostic.requestMicrophoneAuthorization(function(status){
        if (status === cordova.plugins.diagnostic.permissionStatus.GRANTED) {
            // Permission granted, do nothing
            console.log("Microphone permission granted");


        } else {


            console.error("Microphone permission denied");
        }
    }, function(error){
        console.error("Error requesting microphone permission: " + error);
    });
}



/*function downloadFile() {
    var fileTransfer = new FileTransfer();
    var uri = encodeURI("https://rooz-dev.co.uk/remote_files/myrecording.mp3");
    var fileURL = cordova.file.dataDirectory + "myrecording.mp3"; // Change the file name as needed

    fileTransfer.download(
        uri,
        fileURL,
        function(entry) {
            alert("Download complete: " + entry.toURL());
            // Handle the downloaded file here, e.g., play it, display it, etc.
        },
        function(error) {
            alert("Download error: " + JSON.stringify(error));
        },
        false, // Optional, set to true to get a progress callback
        {} // Optional, headers to send with the request
    );
}*/



// Initial alignment
function alignBorders() {

    setTimeout(doSomething, 3000);

function doSomething() {


   
  var elements = document.querySelectorAll('.footerMsgHolder');
  var element1 = elements[elements.length - 1];
  var element2 = document.querySelector('.soundWaveCanvas');
  
  // Get the bounding rectangles of both elements
  var element1Rect = element1.getBoundingClientRect();
  var element2Rect = element2.getBoundingClientRect();
  
  // Calculate the offset needed for element2
  var offset = element1Rect.height;


  
  // Apply the offset to element2
  element2.style.bottom = offset + 'px';
}
 
}


//circle page transition
function circleTransition(toPage) {
  const circle = document.createElement('div');
  circle.classList.add('circle-transition');

  document.body.appendChild(circle);

  setTimeout(() => {
    // Wait for the circle to finish growing
    document.querySelector('#myNavigator').pushPage(toPage, {animation: 'none'}); // Change pages without animation
  }, 300); // This timing should match when the circle is fully grown

  setTimeout(() => {
    // Remove the circle from the DOM after the transition
    document.body.removeChild(circle);
  }, 600); // This should match the total animation duration
}


//speech recognition 
$(document).on('click', '.startSpeech', function(e){
    e.preventDefault();

var lang = localStorage.getItem('lang');
var main_language = "en-GB";
if (lang == 'ge') {

    main_language = "de-DE";

} else if (lang == 'po') {

    main_language = "pt-PT";

} else if (lang == 'sp') {

    main_language = "es-ES";

} else if (lang == 'bul') {

    main_language = "bg-BG";

} else if (lang == 'it') {

    main_language = "it-IT";

} else if (lang == 'fr') {

    main_language = "fr-FR";

} else if (lang == 'ar') {

    main_language = "ar-AE";

}else if (lang == 'ja') {

    main_language = "ja-JP";

}else if (lang == 'tu') {

    main_language = "tr-TR";

}


           function capitalizeFirstLetter(string) {
    if (!string) return ''; // Return an empty string if input is falsy
    return string.charAt(0).toUpperCase() + string.slice(1);
}
window.plugins.speechRecognition.isRecognitionAvailable(function(available) {
        if (available) {
window.plugins.speechRecognition.hasPermission(function(hasPermission) {
                if (!hasPermission) {
                    window.plugins.speechRecognition.requestPermission(function() {
                        // Permission granted, now start recognition
             $('.startSpeech').hide();
     $('.stopSpeech').show();
           window.plugins.speechRecognition.startListening(function(result) {
        //alert('Recognition result: ' + result.join(', '));


    var firstResult = result[0]; // Take the first item from the result array

    // Capitalize the first letter of the first result
    var capitalizedFirstResult = capitalizeFirstLetter(firstResult);

    // Set the text of the element to the capitalized first result
    $('.searchable').text(capitalizedFirstResult);

// Set the text of the element
$('.searchable').text(capitalizedResult);
$('.searchable').keyup();
        $('.startSpeech').show();
     $('.stopSpeech').hide();
    
    }, function(err) {
        //alert('Error in recognition: ' + err);
    }, {
        language: main_language,
        showPopup: false
    });
                    }, function() {
                        // Permission denied
                        //alert("Speech recognition permission was denied");
                    });
                } else {
                    // Permission was already granted
 $('.startSpeech').hide();
     $('.stopSpeech').show();
           window.plugins.speechRecognition.startListening(function(result) {
        //alert('Recognition result: ' + result.join(', '));

    var firstResult = result[0]; // Take the first item from the result array

    // Capitalize the first letter of the first result
    var capitalizedFirstResult = capitalizeFirstLetter(firstResult);

    // Set the text of the element to the capitalized first result
    $('.searchable').text(capitalizedFirstResult);


$('.searchable').keyup();
        $('.startSpeech').show();
     $('.stopSpeech').hide();
    
    }, function(err) {
        //alert('Error in recognition: ' + err);
    }, {
        language: main_language,
        showPopup: false
    });
                }
            }, function(error) {
                //alert("Error checking speech recognition permission" + error);
            });
} else {
            //alert("Speech recognition is not available");
        }
    }, function(error) {
        //alert("Error checking speech recognition availability" + error);
    });

 
    });

$(document).on('click', '.stopSpeech', function(e){
     e.preventDefault();
        stopSpeechRecognition();
        $('.startSpeech').show();
                     $('.stopSpeech').hide();
                         window.plugins.speechRecognition.stopListening(function() {
        //alert('Stopped listening successfully');
        
    }, function(err) {
       //alert('Error stopping listening: ' + err);
    });
    });


function handleSpeechStart() {
    // First, check and request permission
    window.plugins.speechRecognition.isRecognitionAvailable(function(available) {
        if (available) {
            window.plugins.speechRecognition.hasPermission(function(hasPermission) {
                if (!hasPermission) {
                    window.plugins.speechRecognition.requestPermission(function() {
                        // Permission granted, now start recognition
                        startSpeechRecognition();
                               $('.startSpeech').hide();
                               $('.stopSpeech').show();
                    }, function() {
                        // Permission denied
                        //alert("Speech recognition permission was denied");
                    });
                } else {
                    // Permission was already granted

                     $('.startSpeech').hide();
                     $('.stopSpeech').show();
                    startSpeechRecognition();
                }
            }, function(error) {
                //alert("Error checking speech recognition permission" + error);
            });
        } else {
            //alert("Speech recognition is not available");
        }
    }, function(error) {
        //alert("Error checking speech recognition availability" + error);
    });
}

function startSpeechRecognition() {
    //alert('Starting speech recognition...');
    // Start listening
    window.plugins.speechRecognition.startListening(function(result) {
        alert('Recognition result: ' + result.join(', '));
        $('.searchable').text(result.join(' '));
    }, function(err) {
        //alert('Error in recognition: ' + err);
    }, {
        language: "en-US",
        showPopup: false
    });
}

function stopSpeechRecognition() {
    //alert('Stopping speech recognition...');
    window.plugins.speechRecognition.stopListening(function() {
        //alert('Stopped listening successfully');
        
    }, function(err) {
       //alert('Error stopping listening: ' + err);
    });
}



function initializeAudioPlayer(element) {
    // Check if this element has already been initialized
    if ($(element).hasClass('initialized')) {
        return;
    }

    // Mark this element as initialized to avoid re-initialization
    $(element).addClass('initialized');

    const $player = $(element).closest('.custom-audio-player');
    const $playPauseBtn = $player.find('.playPauseBtn');
    const $muteBtn = $player.find('.muteBtn');
    const $progress = $player.find('.progress');
    const $playIcon = $player.find('.play-icon');
    const $pauseIcon = $player.find('.pause-icon');
    const $soundWave = $player.find('.sound-wave');

    // Play/Pause Button Click
    $playPauseBtn.off('click').on('click', function() {
        if (element.paused) {
            element.play();
            $playIcon.hide();
            $pauseIcon.show();
            $soundWave.show();
        } else {
            element.pause();
            $playIcon.show();
            $pauseIcon.hide();
            $soundWave.hide();
        }
        //$(this).toggleClass('active');
    });

    // Ended event for resetting UI when audio finishes
    $(element).off('ended').on('ended', function() {
        $playIcon.show();
        $pauseIcon.hide();
        $soundWave.hide();
        $progress.width('0%');
    });

    // Mute Button Click
    $muteBtn.off('click').on('click', function() {
        element.muted = !element.muted;
        $(this).text(element.muted ? 'Unmute' : 'Mute');
    });

    // Time Update for Progress Bar
    $(element).off('timeupdate').on('timeupdate', function() {
        const percentage = (element.currentTime / element.duration) * 100;
        $progress.width(percentage + '%');
    });
}


$(document).ready(function() {
    $('.audioPlayer').each(function() {
        initializeAudioPlayer(this);
    });
});



document.addEventListener('DOMContentLoaded', function() {
    const buttons = document.querySelectorAll('.tabbar__button');

    buttons.forEach(button => {
        button.addEventListener('click', function() {
            this.classList.add('clicked');
            setTimeout(() => {
                this.classList.remove('clicked');
            }, 300); // This timeout should match the CSS transition time
        });
    });
});


   $(document).on('click', '.play-pause-button', function() {
        var video = $(this).siblings('.custom-video')[0];

        if (video.paused) {
            video.play();
            video.classList.add('playing');
        } else {
            video.pause();
            video.classList.remove('playing');
        }
    });

    $('.custom-video').on('play', function() {
        $(this).siblings('.play-pause-button').hide();
    });

    $('.custom-video').on('pause', function() {
        $(this).siblings('.play-pause-button').show();
    });

    $(document).on('click', '.play-pause-button', function() {
        var video = $(this).siblings('.custom-video')[0];

        if (!document.fullscreenElement) {
            if (video.requestFullscreen) {
                video.requestFullscreen();
            }
        } else {
            if (document.exitFullscreen) {
                document.exitFullscreen();
            }
        }
    });






// Function to animate the progress text from 0 up to the final value
function animateProgressText($progressBar, finalValue) {
    $progressBar.find('.countervalue').prop('Counter', 0).animate({
        Counter: finalValue
    }, {
        duration: 2800,
        easing: 'swing',
        step: function(now) {
            // Update the text content with the current animated value
            $(this).text(Math.ceil(now) + '%');
        }
    });
}

// Function to animate a single radial progress bar
function animateRadialProgressBar($progressBar) {
    var $animatedCircle = $progressBar.find('.bar--animated');
    var percent = $progressBar.data('countervalue');
    var radius = $animatedCircle.attr('r');
    var circumference = 2 * Math.PI * radius;
    var strokeDashOffset = circumference - ((percent * circumference) / 100);

    // Animate progress bar
    $animatedCircle.animate({'stroke-dashoffset': strokeDashOffset}, 2800);

    // Animate progress text from 0 up to the final value
    animateProgressText($progressBar, percent);

    // Update background gradient based on progress value
    updateRadialProgressBackground($progressBar);
}

// Function to update background gradient of radial progress
function updateRadialProgressBackground($progressBar) {
    var percent = $progressBar.data('countervalue');
    var $svg = $progressBar.closest('svg.radial-progress');

    if (percent === 100) {
        // Apply green gradient for 100% progress
        $svg.css('background-image', 'linear-gradient(-225deg, #00FF00 0%, #008000 100%)');
    } else {
        // Apply default gradient for other progress values
        $svg.css('background-image', 'linear-gradient(-225deg, #FF057C 0%, #8D0B93 50%, #321575 100%)');
    }
}

// Function to check if elements are in viewport and trigger animations
function checkViewportAndAnimate() {
    $('.radial-progress').each(function() {
        var $progressBar = $(this);

        // Check if element is in viewport
        var elementTop = $progressBar.offset().top;
        var elementBottom = elementTop + $progressBar.outerHeight();
        var containerTop = $('.page__content:last').offset().top;
        var containerBottom = containerTop + $('.page__content:last').outerHeight();
        var containerScrollTop = $('.page__content:last').scrollTop();

        if (elementBottom > containerTop && elementTop < containerBottom) {
            // Check if progress bar is within container's visible area
            var visibleTop = elementTop < containerTop ? containerTop : elementTop;
            var visibleBottom = elementBottom > containerBottom ? containerBottom : elementBottom;
            var visibleHeight = visibleBottom - visibleTop;

            // Check if progress bar is fully visible
            if (visibleHeight >= $progressBar.outerHeight()) {
                animateRadialProgressBar($progressBar);
            } else {
                // Calculate percentage of visibility
                var percentVisible = (visibleHeight / $progressBar.outerHeight()) * 100;
                // Animate only if progress bar is at least 50% visible
                if (percentVisible >= 50) {
                    animateRadialProgressBar($progressBar);
                }
            }
        }
    });
}


//go to checklist view
$(document).on('click', '.viewChecklistBtn', function(e){

var id = $(this).attr('data-id');
var options = {
  data: {
    id: id
  }
};

//$('.form-container').empty();




    //var pmodal = document.getElementById('formModal');
//pmodal.show({animation: 'fade'});
document.querySelector('#myNavigator').pushPage('form.html', options);

});


// Handle click event on .fff elements
$(document).on('click', '.fff', function() {
    // Find the next sibling .fff_div element and toggle its height

        $(this).parent().next('.fff_div').toggle();

        
    
});












function gatherFormData() {
    function convertDateFormat(dateString) {
        var [year, month, day] = dateString.split('-');
        return `${day}/${month}/${year}`;
    }

    var id = localStorage.getItem('currentFormId');

    var formData = {
        club_form_id: id,
        answers: []
    };

    $('.form-container .gatherFormData').each(function() {
        // Process checkbox inputs
        $(this).find('input[type="checkbox"].formCheck').each(function() {
            var currentField = {
                value: '',
                reason: '',
                checked: '',
                ticket: '',
                key: ''
            };
            var name = $(this).attr('name');
            var isChecked = $(this).is(':checked');
            var reasonInputId = name + '_reason';
            var reason = $(this).closest('.gatherFormData').find('#' + reasonInputId).val() || '';

            currentField.key = name;
            currentField.checked = isChecked ? '1' : '';
            currentField.value = isChecked ? '1' : '0'; // Set value to '1' if checked, otherwise '0'
            currentField.reason = reason;

            // Check if the ticketCheck is checked and set ticket to '1'
            var ticketCheck = $(this).closest('.gatherFormData').find('input[type="checkbox"][name="' + name + '_ticketCheck"]').is(':checked');
            currentField.ticket = ticketCheck ? '1' : '';

            formData.answers.push(currentField);
        });

        // Process radio inputs
        $(this).find('input[type="radio"]:checked').each(function() {
            var currentField = {
                value: '',
                reason: '',
                checked: '',
                ticket: '',
                key: ''
            };
            var name = $(this).attr('name');
            var value = $(this).val();
            var reasonInputId = name + '_reason';
            var reason = $(this).closest('.gatherFormData').find('#' + reasonInputId).val() || '';

            currentField.key = name;
            currentField.value = value;
            currentField.reason = reason;

            // Check if the ticketCheck is checked and set ticket to '1'
            var ticketCheck = $(this).closest('.gatherFormData').find('input[type="checkbox"][name="' + name + '_ticketCheck"]').is(':checked');
            currentField.ticket = ticketCheck ? '1' : '';

            formData.answers.push(currentField);
        });

        // Process other input types (text, date, number, select)
        $(this).find('input[type="text"], input[type="date"], input[type="number"], input[type="time"], select, textarea').each(function() {
            var currentField = {
                value: '',
                reason: '',
                checked: '',
                ticket: '',
                key: ''
            };
            var name = $(this).attr('name');
            var value = $(this).val();
            var reasonInputId = name + '_reason';
            var reason = $(this).closest('.gatherFormData').find('#' + reasonInputId).val() || '';

            currentField.key = name;
            currentField.value = value;
            currentField.reason = reason;

            // Check if the ticketCheck is checked and set ticket to '1'
            var ticketCheck = $(this).closest('.gatherFormData').find('input[type="checkbox"][name="' + name + '_ticketCheck"]').is(':checked');
            currentField.ticket = ticketCheck ? '1' : '';

            // Convert date format if it's a date input
            if ($(this).attr('type') === 'date' && value) {
                currentField.value = convertDateFormat(value);
            }

            formData.answers.push(currentField);
        });
    });

    // Remove any objects that have key = "reason"
    formData.answers = formData.answers.filter(function(item) {
        return item.key !== 'reason';
    });

    return formData;
}



// Helper function to convert date format to dd/mm/yyyy
function convertDateFormatToSend(dateString) {
    var [year, month, day] = dateString.split('-');
    return `${day}/${month}/${year}`;
}



function sendFormData() {
    var formData = gatherFormData();

var formDataJson = JSON.stringify(formData);
    // Create a map of key to index from originalFormData
var keyToIndexMap = {};
originalFormData.forEach(function(item, index) {
    keyToIndexMap[item.key] = index;
});

// Sort formData.answers based on the originalFormData order
formData.answers.sort(function(a, b) {
    return keyToIndexMap[a.key] - keyToIndexMap[b.key];
});

    console.log(JSON.stringify(formData));
    //return;
    var email = localStorage.getItem('email');
    var accessToken = localStorage.getItem('accesstoken');
$.ajax({
    url: host + 'postFormUpdate.php', // Replace with your PHP page URL
    type: 'POST',
    data: {
        formData: JSON.stringify(formData),
        email: email,
        accessToken: accessToken
    },
    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
    success: function(response) {
        console.log('Form data submitted successfully');
        console.log(response); // Handle the response from the PHP page
       if (typeof response === 'string') {
            response = JSON.parse(response);
        }

        // Access the status from the response
        var status = response.status;

        if (status === 'OK') {
            ons.notification.toast('Form updated successfully.', { timeout: 1500, animation: 'fall' });
        } else {
            ons.notification.toast('Form update failed.', { timeout: 1500, animation: 'fall' });
        }
    },
    error: function(jqXhr, textStatus, errorThrown) {
        console.error('Error submitting form data:', errorThrown);
    }
});
}





$(document).on('click', '.formUpdateBtn', function(e) {
    e.preventDefault();
sendFormData();
});

//call Video Recorder
$(document).on('click', '.callVidRec', function(e){ 
e.preventDefault();
var lang = localStorage.getItem('lang');
if($('.video-container').length > 0 || $('.videoPrev img').length > 0){
if (lang == 'ge') {
    navigator.notification.alert(
        "Bitte fügen Sie nur 1 Medium des Fehlers hinzu, wenn Sie ein Ticket erstellen. Sie können weitere Medien hinzufügen, sobald Sie das Ticket erstellt haben.",  // message
        alertDismissed,         // callback
        'Achtung',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'po') {
    navigator.notification.alert(
        "Proszę dodawać tylko 1 medium błędu podczas zgłaszania zlecenia. Możesz dodać więcej mediów po zgłoszeniu zlecenia.",  // message
        alertDismissed,         // callback
        'Uwaga',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'sp') {
    navigator.notification.alert(
        "Por favor, añade solo 1 medio del fallo al crear un ticket. Puedes añadir más medios una vez hayas creado el ticket.",  // message
        alertDismissed,         // callback
        'Atención',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'bul') {
    navigator.notification.alert(
        "Моля, добавете само 1 медия на грешката при подаване на билет. Можете да добавите повече медии, след като сте подали билета.",  // message
        alertDismissed,         // callback
        'Внимание',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'it') {
    navigator.notification.alert(
        "Si prega di aggiungere solo 1 media del difetto quando si apre un ticket. È possibile aggiungere ulteriori media una volta aperto il ticket.",  // message
        alertDismissed,         // callback
        'Attenzione',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'fr') {
    navigator.notification.alert(
        "Veuillez ajouter seulement 1 média du défaut lors de l'ouverture d'un ticket. Vous pouvez ajouter plus de médias une fois le ticket ouvert.",  // message
        alertDismissed,         // callback
        'Attention',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'ar') {
    navigator.notification.alert(
        "يرجى إضافة ميديا واحدة فقط للخلل عند رفع تذكرة. يمكنك إضافة مزيد من الميديا بمجرد رفع التذكرة.",  // message
        alertDismissed,         // callback
        'تنبيه',            // title
        'موافق'                  // buttonName
    );
} else if (lang == 'ja') {
    navigator.notification.alert(
        "チケットを作成する際には、不具合のメディアを1つだけ追加してください。チケットを作成した後は、複数のメディアを追加できます。",  // message
        alertDismissed,         // callback
        '注意',            // title
        'OK'                  // buttonName
    );
}else if (lang == 'tu') {
navigator.notification.alert(
    "Bir bilet oluştururken, yalnızca bir medya ekleyin. Bilet oluşturulduktan sonra, birden fazla medya ekleyebilirsiniz.",
    alertDismissed,
    'Dikkat',
    'OK'
);

} else {
    navigator.notification.alert(
        "Please only add 1 media of the fault when raising a ticket. You can add more media once you have raised the ticket.",  // message
        alertDismissed,         // callback
        'Attention',            // title
        'OK'                  // buttonName
    );
}


function alertDismissed() {}

return;
}

recordVideo();
});


//call Image picker or take photo
$(document).on('click', '.callPhotoTaker', function(e){ 
e.preventDefault();
var lang = localStorage.getItem('lang');
if($('.video-container').length > 0 || $('.videoPrev img').length > 0){
if (lang == 'ge') {
    navigator.notification.alert(
        "Bitte fügen Sie nur 1 Medium des Fehlers hinzu, wenn Sie ein Ticket erstellen. Sie können weitere Medien hinzufügen, sobald Sie das Ticket erstellt haben.",  // message
        alertDismissed,         // callback
        'Achtung',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'po') {
    navigator.notification.alert(
        "Proszę dodawać tylko 1 medium błędu podczas zgłaszania zlecenia. Możesz dodać więcej mediów po zgłoszeniu zlecenia.",  // message
        alertDismissed,         // callback
        'Uwaga',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'sp') {
    navigator.notification.alert(
        "Por favor, añade solo 1 medio del fallo al crear un ticket. Puedes añadir más medios una vez hayas creado el ticket.",  // message
        alertDismissed,         // callback
        'Atención',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'bul') {
    navigator.notification.alert(
        "Моля, добавете само 1 медия на грешката при подаване на билет. Можете да добавите повече медии, след като сте подали билета.",  // message
        alertDismissed,         // callback
        'Внимание',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'it') {
    navigator.notification.alert(
        "Si prega di aggiungere solo 1 media del difetto quando si apre un ticket. È possibile aggiungere ulteriori media una volta aperto il ticket.",  // message
        alertDismissed,         // callback
        'Attenzione',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'fr') {
    navigator.notification.alert(
        "Veuillez ajouter seulement 1 média du défaut lors de l'ouverture d'un ticket. Vous pouvez ajouter plus de médias une fois le ticket ouvert.",  // message
        alertDismissed,         // callback
        'Attention',            // title
        'OK'                  // buttonName
    );
} else if (lang == 'ar') {
    navigator.notification.alert(
        "يرجى إضافة ميديا واحدة فقط للخلل عند رفع تذكرة. يمكنك إضافة مزيد من الميديا بمجرد رفع التذكرة.",  // message
        alertDismissed,         // callback
        'تنبيه',            // title
        'موافق'                  // buttonName
    );
} else if (lang == 'ja') {
    navigator.notification.alert(
        "チケットを作成する際には、不具合のメディアを1つだけ追加してください。チケットを作成した後は、複数のメディアを追加できます。",  // message
        alertDismissed,         // callback
        '注意',            // title
        'OK'                  // buttonName
    );
}else if (lang == 'tu') {
navigator.notification.alert(
    "Bir bilet oluştururken, yalnızca bir medya ekleyin. Bilet oluşturulduktan sonra, birden fazla medya ekleyebilirsiniz.",
    alertDismissed,
    'Dikkat',
    'OK'
);

} else {
    navigator.notification.alert(
        "Please only add 1 media of the fault when raising a ticket. You can add more media once you have raised the ticket.",  // message
        alertDismissed,         // callback
        'Attention',            // title
        'OK'                  // buttonName
    );
}


function alertDismissed() {}

return;
}

var useCameratext = 'Use Camera';
var selectGaltxt = 'Use Gallery';
var cl = 'Cancel';
var ttle = '';

if (lang == 'ge') {
    useCameratext = 'Kamera verwenden';
    selectGaltxt = 'Galerie verwenden';
    cl = 'Abbrechen';
    ttle = '';
} else if (lang == 'po') {
    useCameratext = 'Usar câmera';
    selectGaltxt = 'Usar galeria';
    cl = 'Cancelar';
    ttle = '';
} else if (lang == 'sp') {
    useCameratext = 'Usar cámara';
    selectGaltxt = 'Usar galería';
    cl = 'Cancelar';
    titleText = '';
} else if (lang == 'bul') {
    useCameratext = 'Използване на камера';
    selectGaltxt = 'Използване на галерия';
    cl = 'Отказ';
    ttle = '';
} else if (lang == 'it') {
    useCameratext= 'Usa fotocamera';
    selectGaltxt = 'Usa galleria';
    cl = 'Annulla';
    ttle = '';
} else if (lang == 'fr') {
    useCameratext = 'Utiliser l\'appareil photo';
    selectGaltxt = 'Utiliser la galerie';
    cl = 'Annuler';
    ttle = '';
}
else if (lang == 'ar') {
useCameratext = 'استخدام الكاميرا';
selectGaltxt = 'استخدام المعرض';
cl = 'إلغاء';
    ttle = '';
}else if (lang == 'ja') {
useCameratext = 'カメラを使用する';
selectGaltxt = 'ギャラリーを選択する';
cl = 'キャンセル';
ttle = '';
}else if (lang == 'tu') {
var useCameratext = 'Kamerayı kullan';
var selectGaltxt = 'Galeriyi seç';
var cl = 'İptal';
var ttle = '';

}

app.showFromObject = function () {
  ons.openActionSheet({
    title: ttle,
    cancelable: true,
    buttons: [
      selectGaltxt,
      useCameratext,
      {
        label: cl,
        icon: 'md-close',
        modifier: 'destructive'
      }
    ]
  }).then(function (index) { 

if (index == 0){


    navigator.camera.getPicture(onSuccess, onFail, { 
    quality: 100,
    destinationType: Camera.DestinationType.DATA_URL,
    sourceType: Camera.PictureSourceType.PHOTOLIBRARY,
    encodingType: Camera.EncodingType.JPEG,
       targetWidth: screen.width,
    targetHeight: screen.height,
    correctOrientation: true
});

function onSuccess(imageData) {

newTicketImgs.push("data:image/jpeg;base64,"+imageData+"");


$('.imgPreview').append("<img class='imgPrevi' src='data:image/jpeg;base64,"+imageData+"' />");
newAddImgs.push('data:image/jpeg;base64,'+imageData);
$('.TicketImgRaise').show();

}

function onFail(message) {

}




}

if (index == 1){

    navigator.camera.getPicture(onSuccess, onFail, { 
    quality: 100,
    destinationType: Camera.DestinationType.DATA_URL,
    sourceType: Camera.PictureSourceType.CAMERA,
    encodingType: Camera.EncodingType.JPEG,
       targetWidth: screen.width,
    targetHeight: screen.height,
    correctOrientation: true
});

function onSuccess(imageData) {

newTicketImgs.push("data:image/jpeg;base64,"+imageData+"");


$('.imgPreview').append("<img src='data:image/jpeg;base64,"+imageData+"' />");
newAddImgs.push('data:image/jpeg;base64,'+imageData);
$('.TicketImgRaise').show();

}

function onFail(message) {

}

  

}



   });
};


app.showFromObject();
});

function clubQRcodeScanner (){



/*cordova.plugins.mlkit.barcodeScanner.scan(
  barCodeOptions,
  (result) => {

      var url = result.text;*/

monaca.BarcodeScanner.scan((result) => {
  if (result.cancelled) {
      // scan cancelled
   } else {

const url = result.data.text;


cordova.InAppBrowser.open(url, '_system', 'location=yes');


////////////////
}
  }, (error) => {
     //permission error
    const error_message = error;
  }, {
    "oneShot" : true,
    "timeoutPrompt" : {
     "show" : true,
    "timeout" : 5,
     "prompt" : "Not detected"
    }
});


   /* },
  (error) => {
    // Error handling
  },
);*/

}