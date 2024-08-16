import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import{ HttpClientModule} from '@angular/common/http';
//import{MatDialogModule}from '@angular/material';

//import { AComponent } from './app.component';


import { FormsModule,ReactiveFormsModule } from '@angular/forms';



import { AddeventComponent } from './addevent/addevent.component';

import { EditeventComponent } from './editevent/editevent.component';
import { EventlistComponent } from './eventlist/eventlist.component';
import { VieweventComponent } from './viewevent/viewevent.component';
import { ViewuserComponent } from './viewuser/viewuser.component';
import { AdduserComponent } from './adduser/adduser.component';
import { EdituserComponent } from './edituser/edituser.component';
import { UserlistComponent } from './userlist/userlist.component';
import { AppRoutingModule } from '../app-routing.module';
import { AdminComponent } from './admin.component';
import { AdminRoutingModule } from './admin-routing.module';
import { SearchuserComponent } from './searchuser/searchuser.component';
import { ProfiladminComponent } from './profiladmin/profiladmin.component';


@NgModule({
  declarations: [
 // AdminModule,
    AdminComponent,
    AddeventComponent,
    EditeventComponent,
    EventlistComponent,
    VieweventComponent,
    UserlistComponent,
    ViewuserComponent,
    EdituserComponent,
    AdduserComponent,
    SearchuserComponent,
    ProfiladminComponent,
   
   
   
    
   
  ],
  imports: [
    BrowserModule,
    AdminRoutingModule,
    HttpClientModule, 
    FormsModule,
    ReactiveFormsModule,
   // MatDialogModule,
   
  ],
  providers: [
   
    

  ],

})
export class AdminModule { }
