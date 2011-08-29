// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function micropost_textcounter(maxlen) {
  oFormObject = document.forms['microposts']
  oTextarea = oFormObject.elements["micropost[content]"]
  oCounter  = oFormObject.elements["counter"]      
  oCounter.value = (maxlen - oTextarea.value.length)
}       
   