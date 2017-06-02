import { Http } from '@angular/http';
import { Injectable } from '@angular/core';

import 'reflect-metadata';

@Injectable()
export class PersonService {
    private url: string = "http://192.168.0.147:8081/api/person";

    constructor(private http: Http) {
    }

    getPersons() {
        return this.http.get(this.url);
    }
}