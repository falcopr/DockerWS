let express = require('express'),
    app = express(),
    defaultPort = 8080,
    PersonRepository = require('./personRepository');

class WebAPI {
    constructor(port) {
        this.port = port || defaultPort;
        this.app = app;
        this.express = express;
        this.webApiRouter = this.express.Router();
        this.personRepository = new PersonRepository()
    }

    configure() {
        // Routing: GET /api/helloworld
        this.webApiRouter.get('/helloworld', (req, res) => {
            res.setHeader('Content-Type', 'application/json');
            res.send({
                message: 'Hello World with Docker & Express',
                querystring: req.query
            })
        });

        this.webApiRouter.get('/person', (req, res) => {
            res.setHeader('Content-Type', 'application/json');
            
            this.personRepository.get()
                .then(persons => res.send(persons))
                .catch(err => console.log(err));
        });

        // Routing: GET /api
        this.webApiRouter.get('/', (req, res) => {
            res.setHeader('Content-Type', 'text/plain');
            res.send('WebAPI Router works!');
        })

        // Routing: GET /
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