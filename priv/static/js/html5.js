// Create new HTML5 elements ===================================================
// -----------------------------------------------------------------------------
// This script should load before any others. We want the new elements to be
// parsed before pretty much anything happens.
// Plus, IE does not behave otherwise. The cost of being progressive...
// -----------------------------------------------------------------------------

document.createElement("article");
document.createElement("aside");
document.createElement("audio");
document.createElement("canvas");
document.createElement("command");
document.createElement("datalist");
document.createElement("details");
document.createElement("embed");
document.createElement("figcaption");
document.createElement("figure");
document.createElement("footer");
document.createElement("header");
document.createElement("hgroup");
document.createElement("keygen");
document.createElement("mark");
document.createElement("meter");
document.createElement("nav");
document.createElement("output");
document.createElement("progress");
document.createElement("rp");
document.createElement("rt");
document.createElement("ruby");
document.createElement("section");
document.createElement("source");
document.createElement("summary");
document.createElement("time");
document.createElement("video");

//getting current time
   function startTime() { 
      var today=new Date();
      var h=today.getHours();
      var m=today.getMinutes();
      var s=today.getSeconds();
      m = checkTime(m);
      s = checkTime(s);
      currentTime = h+" : "+m+" : "+s;
      $('#showtimehms').html(currentTime);
      var t = setTimeout(function(){startTime()},500);
    }

  function checkTime(i) {
      if (i<10) {i = "0" + i};  // add zero in front of numbers < 10
      return i;
  }