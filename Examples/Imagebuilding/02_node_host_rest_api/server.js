const WebApi = require('./app/webapi.js');
const webApiServer = new WebApi(8081);
webApiServer.configure();
webApiServer.start();