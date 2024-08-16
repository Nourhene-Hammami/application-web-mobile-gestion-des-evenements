import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { CrudserviceeventService } from 'src/app/crudserviceevent.service';
import { Event }from 'src/app/event';

import { DomSanitizer,SafeUrl } from '@angular/platform-browser';
import { HttpClient } from '@angular/common/http';
@Component({
  selector: 'app-eventlist',
  templateUrl: './eventlist.component.html',
  styleUrls: ['./eventlist.component.css']
})
export class EventlistComponent implements OnInit{



  public _eventlist: Array<Event>=[];
event =new Event();
 


  constructor(public service:CrudserviceeventService,private router:Router
    ,private sanit:DomSanitizer, private http: HttpClient){}
  ngOnInit( ){
   

 // const eventFormData =this.prepareFormData(this.event);
    this.service.fetchEventListFromRemote().subscribe(
    data=>{
      console.log(data)
    
      console.log("reponse reseived");
      this._eventlist=data;},
    error=>console.log("exception occured")
  )}



  get_eventlist() {
    this.service.fetchEventListFromRemote().subscribe(
      data=>this._eventlist=data,
      error=> console.log("error"),
    )
    }

  gotoaddevent(){
    this.router.navigate(['/admin/add']);}

  gotoeditevent(id:number){
    console.log("id"+id);
    this.router.navigate(['/admin/edit',id]);
  }

  gotoviewevent(id:number){
   console.log("id"+id);
    this.router.navigate(['/admin/view',id]);
  }

 deleteevent(id:number){
   if(confirm("Are You Sure  ?"))
 this.service.deleteeventbyIdFromRemote(id).subscribe(
    data =>{
       ("event deleted succesfully");
     }, error=>{
       console.log("error")
       this.get_eventlist();
     }
   )
 }













}
