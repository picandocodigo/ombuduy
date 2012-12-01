Application.Views.TagList = Backbone.View.extend({

  template: 'templates/tag-list.html',

  initialize: function () {
    _.bindAll(this, 'render');
    this.collection.bind('reset', this.render);
    this.collection.fetch();
  },

  render: function () {
    var that = this;
    $.loadTemplate(this, function (html) {
      var template = _.template(html, {
        tags: that.collection.models
      });
      that.$el.html(template).show();
    });
  }

});
