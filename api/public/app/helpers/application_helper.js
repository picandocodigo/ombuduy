/**
 * Loads a template if the object hasnt
 * loaded it before, and then runs the 
 * callback
 *
 * @params o
 * @params callback
 */
$.loadTemplate = function (o, callback) {
  if (o.htmlTemplate) {
    $.get(o.template, function (res) {
      o.htmlTemplate = res;
      callback(res);
    });
  }
  else {
    callback(o.htmlTemplate);
  }
};
