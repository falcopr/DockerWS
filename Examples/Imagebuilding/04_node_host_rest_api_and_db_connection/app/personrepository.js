let couchDBCredentials = 'hallo123:hallo123'
    couchDbServer = `http://${couchDBCredentials}@192.168.0.147:8082`,
    nano = require('nano')(couchDbServer);

class PersonRepository {
    constructor() {
        this.nano = nano;
        this.testDb = nano.db.use('test');   
    }
    
    get() {
        return new Promise((resolve, reject) => {
            this.testDb.view('person', 'person', (err, res) => {
                if (err) {
                    reject(err);
                } else {
                    resolve(res);
                }
            })
        })
    } 
}

module.exports = PersonRepository;