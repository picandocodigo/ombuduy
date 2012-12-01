Application.Routers.IssuesRouter = Backbone.Router.extend({

  initialize: function () {
    this.tagsList = new Application.Views.TagList({
      el: $('#tag-list'),
      collection: new Application.Collections.Tags()
    });
    this.notFixedIssuesList = new Application.Views.NotFixedIssuesList({
      el: $('#not_fixed-list'),
      collection: new Application.Collections.NotFixedIssues()
    });
    this.issuesList = new Application.Views.IssuesList({
      el: $('#issues-list'),
    });
    this.issuesShow = new Application.Views.IssuesShow({
      el: $('#issues-show')
    });
  },

  routes: {
    '': 'list',
    'issue/:id': 'show'
  },

  list: function () {
    this.issuesShow.$el.hide();
    this.issuesList.setCollection(new Application.Collections.Issues());
  },

  show: function (id) {
    this.issuesList.$el.hide();
    this.issuesShow.setModel(new Application.Models.Issue({ id: id }));
  }

});
