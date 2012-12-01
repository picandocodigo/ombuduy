/**
 * Gives the object a method getInstance
 * to manage the instance and get a
 * singleton.
 */
$.makeSingleton = function(o) {
  o.liveInstance = null;
  o.getInstance = function (params) {
    if (o.liveInstance === null) {
      o.liveInstance = new o(params);
    }
    return o.liveInstance;
  };
};

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
