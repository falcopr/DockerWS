let express = require('express'),
    path = require('path'),
    app = express(),
    port = 3000;

app.use(express.static(path.join(__dirname, 'wwwroot')))
app.listen(port, function () {
  console.log(`Angular Testproject listening on port ${port}!`);
});

