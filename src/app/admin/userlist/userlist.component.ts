import { Component, OnInit } from '@angular/core';

import { Router } from '@angular/router';
import { CrudserviceeventService } from 'src/app/crudserviceevent.service';
import { Event }from 'src/app/event';

import { DomSanitizer,SafeUrl } from '@angular/platform-browser';
import { HttpClient } from '@angular/common/http';
import { UtilisateurserviceService } from 'src/app/utilisateurservice.service';
import { Utilisateurs } from 'src/app/utilisateurs';

@Component({
  selector: 'app-userlist',
  templateUrl: './userlist.component.html',
  styleUrls: ['./userlist.component.css']
})
export class UserlistComponent implements OnInit {
  
  public _userlist: Array<Utilisateurs>=[];
//event =new Event();
user =new Utilisateurs();
 


  constructor(public service:UtilisateurserviceService,private router:Router
    ,private sanit:DomSanitizer, private http: HttpClient){}
  ngOnInit( ){
   

 // const eventFormData =this.prepareFormData(this.event);
    this.service.getUsers().subscribe(data=>{
      console.log(data)
    
      console.log("reponse reseived");
      this._userlist=data;},
    error=>console.log("exception occured")
  )}



get_userlist() {
    this.service.getUsers().subscribe(
      data=>this._userlist=data,
      error=> console.log("error"),
    )
    }
  
  gotoadduser(){
    this.router.navigate(['/admin/adduser']);
 //   this.router.navigate(['/admin/add']);
  }

  gotoedituser(id:number){
    console.log("id"+id);
    this.router.navigate(['/admin/edituser',id]);
  }

  gotoviewuser(id:number){
   console.log("id"+id);
    this.router.navigate(['/admin/viewuser',id]);
  }


 deleteuser(id:number){
  console.log(id)
  if(confirm("Are You Sure ?"))
 this.service.deleteUser(id).subscribe(
    data =>{
     console.log("event deleted succesfully");

       
     }, error=>{
       console.log("error")
       this.get_userlist();
     }
   )
 }














}
