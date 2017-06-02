import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpModule } from '@angular/http';

import { PersonService } from './person.service';
import { AppComponent }  from './app.component';

@NgModule({
  imports:      [ BrowserModule, HttpModule ],
  declarations: [ AppComponent ],
  providers: [ PersonService ],
  bootstrap:    [ AppComponent ]
})
export class AppModule { }
