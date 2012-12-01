Application.Routers.IssuesRouter = Backbone.Router.extend({

  initialize: function () {
    this.tagsList = new Application.Views.TagList({
      el: $('#tags-list'),
      collection: new Application.Collections.Tags()
    });
    this.notFixedIssuesList = new Application.Views.NotFixedIssuesList({
      el: $('#not_fixed-list'),
      collection: new Application.Collections.NotFixedIssues()
    });
    this.issuesList = new Application.Views.IssuesList({
      el: $('#issues-list'),
      collection: new Application.Collections.Issues()
    });
    this.issuesShow = new Application.Views.IssuesShow({
      el: $('#issues-show')
    });
  },

  routes: {
    '': 'list'
  },

  list: function () {
    this.issuesList.$el.show();
    this.issuesShow.$el.hide();
  }

});
