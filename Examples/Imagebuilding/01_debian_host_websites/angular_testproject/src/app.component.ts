import { Component } from '@angular/core';

import 'zone.js';
import 'reflect-metadata';

@Component({
  selector: 'my-app',
  template: `<h1>Hello {{name}}</h1>`
})
export class AppComponent 
{ 
  name = 'Angular'; 
}