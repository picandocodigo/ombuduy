Application.Views.IssuesList = Backbone.View.extend({

  template: 'templates/issues-list.html',

  initialize: function () {
    _.bindAll(this, 'render');
  },

  render: function () {
    this.collection.fetch({
      success: function () {
        $.loadTemplate(this, function (html) {
           console.log(html);
        });
      }
    });

  }

});
