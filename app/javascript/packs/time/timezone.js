// Autoditect Timezone
import jstz from 'jstz';


// Time zone seettings
function setCookie(name, value) {
  var expires = new Date();
  expires.setTime(expires.getTime() * (24 * 60 * 60 * 1000));
  document.cookie = name + '=' + value + ';expires=' + expires.toUTCString();
}

const timezone = jstz.determine();
setCookie("timezone", timezone.name());
// console.log(timezone.name());