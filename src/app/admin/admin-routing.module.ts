import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import{ AdminComponent} from './admin.component'

import { EventlistComponent } from './eventlist/eventlist.component';
import { VieweventComponent } from './viewevent/viewevent.component';
import { AddeventComponent } from './addevent/addevent.component';
import { EditeventComponent } from './editevent/editevent.component';
import { SearchadminComponent } from './searchadmin/searchadmin.component';
import { ViewuserComponent } from './viewuser/viewuser.component';
import { AdduserComponent } from './adduser/adduser.component';
import { EdituserComponent } from './edituser/edituser.component';
import { UserlistComponent } from './userlist/userlist.component';
import { SearchuserComponent } from './searchuser/searchuser.component';
import {ProfiladminComponent}from './profiladmin/profiladmin.component';

const routes: Routes = [
  {path :"admin",
  component:AdminComponent,
  children:[

    {path :"profil" ,component:ProfiladminComponent},
    {path :"userlist" ,component:UserlistComponent},
    {path :"adduser" ,component:AdduserComponent},
    {path :"edituser" ,component:EdituserComponent },
    {path :"edituser/:id" ,component:EdituserComponent },
    {path :"viewuser" ,component:ViewuserComponent},
    {path :"viewuser/:id" ,component:ViewuserComponent},
    {path :"list" ,component:EventlistComponent},
    {path :"edit" ,component:EditeventComponent},
    {path :"edit/:id" ,component:EditeventComponent},
    {path :"add" ,component:AddeventComponent},
    {path :"view" ,component:VieweventComponent},
    {path :"view/:id" ,component:VieweventComponent},
    {path :"search2" ,component:SearchadminComponent},
    {path :"searchuser" ,component:SearchuserComponent},

  ]




},

 
 
 
 
  









];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AdminRoutingModule { }
