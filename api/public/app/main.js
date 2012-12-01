for (i in Application.Routers) {
  if (Application.Routers.hasOwnProperty(i)) {
    Application.Routers[i]();
  }
}

Backbone.history.start();
