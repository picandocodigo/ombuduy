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
