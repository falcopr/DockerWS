import { Component } from '@angular/core';
import { PersonService } from './person.service'

import 'zone.js';
import 'reflect-metadata';

@Component({
  selector: 'my-app',
  template: `<h1>Persondata: {{ data }}</h1>`
})
export class AppComponent 
{ 
  public data: String = 'Loading data...';

  constructor(private personService: PersonService) {
    console.log(personService.getPersons())
    personService.getPersons().subscribe(data => this.data = JSON.stringify(data));
  }
}