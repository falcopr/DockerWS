let express = require('express'),
    app = express(),
    defaultPort = 8080;

class WebAPI {
    constructor(port) {
        this.port = port || defaultPort;
        this.app = app;
        this.express = express;
        this.webApiRouter = this.express.Router();
    }

    configure() {
        this.webApiRouter.get('/helloworld', (req, res) => {
            res.setHeader('Content-Type', 'application/json');
            res.send({
                message: 'Hello World with Docker & Express',
                querystring: req.query
            })
        });

        this.webApiRouter.get('/', (req, res) => {
            res.setHeader('Content-Type', 'text/plain');
            res.send('WebAPI Router works!');
        })

        this.app.get('/', (req, res) => {
            res.setHeader('Content-Type', 'text/plain');
            res.send('Express works!')
        })

        this.app.use('/api', this.webApiRouter);
    }

    start() {
        this.app.listen(this.port, () => {
            console.log(`Rest API listening on port ${this.port}!`);
        });
    }
}

module.exports = WebAPI;