var LOAD_WITH_GUI_LOADER = true;

var qq = setInterval(function(){window.scrollTo(0,0);}, 10);

console.log("HELLO");

var loader = $(".webpage-loader");
window.loader = loader;
window.loaderStatus = 0;

window.loaderUpd = function(descr) {
  if(window.loaderStatus > 100) {
    clearInterval(qq);
    setTimeout(function(){
      $("html,body").removeClass("overflow-hidden");
      loader.detach();
      $(".webpage-content").css('opacity', 1);
    }, 2000);
    return;
  }
}

window.loaderSet = function(value, descr) {
  window.loaderStatus = value;
  window.loaderUpd(descr);
}

window.loaderIncr = function(value, descr) {
  if(parseInt(window.loaderStatus)!=parseInt(window.loaderStatus+value)) {
    window.loaderStatus += value;
    window.loaderUpd(descr);
  } else {
    window.loaderStatus += value;
  }
};

window.loaderAddReadyWrappers = function() {
  var els = $("body, head, .card-pane, .boxy, .splash, .content, .card-img-src, .card-image, .content-wrapper");
  var len = els.length;
  els.each(function(){
    var thiz = $(this);
    thiz.ready(function(){
      window.loaderIncr(71/len, "Content loaded.");
    });
  });
};

$("content").ready(function(){
  window.loaderIncr(10, "Content loaded.");
});

$(document).ready(function(){
  window.loaderIncr(10, "Page loaded.");
});

function animLoader(ID, dur, shift) {
  setTimeout(function(){
    var fnanim = function() {
      $("#loader-box-"+ID).animate({opacity: 1}, dur, function(){
         $("#loader-box-"+ID).animate({opacity: 0}, dur, fnanim);
      });
    };
    fnanim();
  }, shift);
};

if(!LOAD_WITH_GUI_LOADER) {
  window.loaderStatus = 999;
  window.loaderUpd();
};
