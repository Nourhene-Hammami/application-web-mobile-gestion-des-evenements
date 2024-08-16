import { NgModule } from '@angular/core';

import { BrowserModule } from '@angular/platform-browser';
import{ HttpClientModule} from '@angular/common/http';
//import{MatDialogModule}from '@angular/material';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { LoginComponent } from './login/login.component';
import { RegisterComponent } from './register/register.component';
import { AcceuilComponent } from './acceuil/acceuil.component';
import { CatagComponent } from './user/catag/catag.component';

import { FormsModule,ReactiveFormsModule } from '@angular/forms';
import { UtilisateurserviceService } from './utilisateurservice.service';
import { SearchComponent } from './user/search/search.component';

import { ProfilComponent } from './user/profil/profil.component';


//import { AddeventComponent } from './admin/addevent/addevent.component';

//import { EditeventComponent } from './admin/editevent/editevent.component';
//import { EventlistComponent } from './admin/eventlist/eventlist.component';
//import { VieweventComponent } from './admin/viewevent/viewevent.component';
import { CrudserviceeventService } from './crudserviceevent.service';
import { PanierserviceService } from './panierservice.service';
import { EventdescptionComponent } from './user/eventdescption/eventdescption.component';
import { CartComponent } from './user/cart/cart.component';

import { PayementComponent } from './user/payement/payement.component';
import { SearchadminComponent } from './admin/searchadmin/searchadmin.component';
import { ChatbotComponent } from './user/chatbot/chatbot.component';
import { AdduserComponent } from './admin/adduser/adduser.component';
import { UserlistComponent } from './admin/userlist/userlist.component';
import { ViewuserComponent } from './admin/viewuser/viewuser.component';
import { EdituserComponent } from './admin/edituser/edituser.component';
import { AdminComponent } from './admin/admin.component';
import { AdminModule } from './admin/admin.module';
import { AttestationComponent } from './user/attestation/attestation.component';
@NgModule({
  declarations: [
    AppComponent,





   //AdminModule,


    LoginComponent,
    RegisterComponent,
    AcceuilComponent,
    CatagComponent,
    SearchComponent,
    ProfilComponent,
  //  AddeventComponent,
   // EditeventComponent,
   // EventlistComponent,
    //VieweventComponent,
    EventdescptionComponent,
    CartComponent,
   
    PayementComponent,
    SearchadminComponent,
   
    ChatbotComponent,
    AttestationComponent,
 //  AdduserComponent,
 // UserlistComponent,
 //   ViewuserComponent,
//    EdituserComponent,
   
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule, 
    FormsModule,
    ReactiveFormsModule,
    AdminModule,
 
  
   
  ],
  providers: [
   
    

  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
