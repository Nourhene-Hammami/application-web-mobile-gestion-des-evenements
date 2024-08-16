import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { CrudserviceeventService } from 'src/app/crudserviceevent.service';
import { Event }from 'src/app/event';
@Component({
  selector: 'app-viewevent',
  templateUrl: './viewevent.component.html',
  styleUrls: ['./viewevent.component.css']
})
export class VieweventComponent implements OnInit {
  event =new Event();
  _eventlist: Array<Event>=[];
  
  constructor(private router:Router,public service:CrudserviceeventService   ,private activateRouter:ActivatedRoute){}
  ngOnInit(){ 


    let id = null;
    const idParam = this.activateRouter.snapshot.paramMap.get('id');
    if (idParam !== null) {
      id = parseInt(idParam);
        this.service.fetcheventbyIdFromRemote(id).subscribe(
      data=>{
        console.log("Data received");
        this.event=data;}
        ,
        error=>console.log("error")
    )}
  }
 

  gotolist(){
    console.log("go back")
    this.router.navigate(['/admin/list']);}




}
