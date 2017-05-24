let express = require('express'),
    path = require('path'),
    app = express(),
    port = 8080;

app.use(express.static(path.join(__dirname, 'wwwroot')))
app.listen(port, () => {
  console.log(`Rest API listening on port ${port}!`);
});
