Application.Views.IssuesList = Backbone.View.extend({

  template: 'templates/issues-list.html',

  initialize: function () {
    _.bindAll(this, 'render');
  },

  render: function () {
    var that = this;
    $.loadTemplate(this, function (html) {
      var template = _.template(html, {
        issues: that.collection.models
      });
      that.$el.html(template).show();
    });
  },

  setCollection: function (collection) {
    this.collection = collection;
    this.collection.fetch({
      success: this.render
    });
  }

});
