import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AcceuilComponent } from './acceuil/acceuil.component';
import { CatagComponent } from './user/catag/catag.component';
import { LoginComponent } from './login/login.component';

import { RegisterComponent } from './register/register.component';
import { SearchComponent } from './user/search/search.component';
import { ProfilComponent } from './user/profil/profil.component';


import { AdduserComponent } from './admin/adduser/adduser.component';
import { UserlistComponent } from './admin/userlist/userlist.component';
import { ViewuserComponent } from './admin/viewuser/viewuser.component';
import { EdituserComponent } from './admin/edituser/edituser.component';


import { AddeventComponent } from './admin/addevent/addevent.component';
import { EditeventComponent } from './admin/editevent/editevent.component';
import { EventlistComponent } from './admin/eventlist/eventlist.component';
import { VieweventComponent } from './admin/viewevent/viewevent.component';
import { CartComponent } from './user/cart/cart.component';
import{EventdescptionComponent} from './user/eventdescption/eventdescption.component';

import { PayementComponent } from './user/payement/payement.component';
import { SearchadminComponent } from './admin/searchadmin/searchadmin.component';
import { ChatbotComponent } from './user/chatbot/chatbot.component';
import { AttestationComponent } from './user/attestation/attestation.component';
const routes: Routes = [
{path :"admin", redirectTo :'/admin',pathMatch:'full'},

  {path :"" ,component:AcceuilComponent},
  {path :"login" ,component:LoginComponent},
  {path :"register" ,component:RegisterComponent},






  {path :"catag" ,component:CatagComponent},
{path :"search" ,component:SearchComponent},
  {path :"profil" ,component:ProfilComponent},
  
  {path :"list" ,component:EventlistComponent},
  {path :"edit" ,component:EditeventComponent},
  {path :"edit/:id" ,component:EditeventComponent},
  {path :"add" ,component:AddeventComponent},
  {path :"view" ,component:VieweventComponent},
  {path :"view/:id" ,component:VieweventComponent},
   {path :"search2" ,component:SearchadminComponent},
  



  {path :"eventdescption" ,component:EventdescptionComponent},
  {path :"eventdescption/:id" ,component:EventdescptionComponent},
  {path :"cart" ,component:CartComponent},
  {path :"cart/:id" ,component:CartComponent},
  {path :"payer" ,component:PayementComponent},
  {path :"chatbot" ,component:ChatbotComponent},
  {path :"userlist" ,component:UserlistComponent},
  {path :"adduser" ,component:AdduserComponent},
  {path :"edituser" ,component:EdituserComponent },
  {path :"viewuser" ,component:ViewuserComponent},
  {path :"attestation" ,component:AttestationComponent},







];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
