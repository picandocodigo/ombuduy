Application.Views.IssuesShow = Backbone.View.extend({
  
  template: 'templates/issues-show.html',

  initialize: function () {
    _.bindAll(this, 'render');
  },
  
  render: function () {
    var that = this;
    $.loadTemplate(this, function (html) {
      var template = _.template(html, {
        issue: that.model
      });
      that.$el.html(template).show();
    });
  },

  setModel: function (model) {
    this.model = model;
    this.model.fetch({
      success: this.render
    });
  }

});
