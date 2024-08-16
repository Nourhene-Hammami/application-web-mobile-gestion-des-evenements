import { Component, OnInit } from '@angular/core';
import { Router,ActivatedRoute } from '@angular/router';
import { CrudserviceeventService } from '../../crudserviceevent.service';
import { PanierserviceService } from 'src/app/panierservice.service';
import { Event }from 'src/app/event';
import { Lpanier } from '../../lpanier';
import { LocalStorageService } from 'angular-web-storage';
//import { MatDialogConfig } from '@angular/material/dialog';

@Component({
  selector: 'app-eventdescption',
  templateUrl: './eventdescption.component.html',
  styleUrls: ['./eventdescption.component.css']
})
export class EventdescptionComponent implements OnInit{

  public cartItemlist:any=[]
  event =new Event();
  _eventlist: Array<Event>=[];
 public totalItem: number=0;
  //matDialog: any;
  public grandTotal: number=0;
 
  constructor(public service:CrudserviceeventService,private router:Router,private activateRouter:ActivatedRoute,private localStorage: LocalStorageService
 ,   public service2: PanierserviceService){}
  ngOnInit( ){
    this.getData();
 
    this.service2.get_eventlist()
    .subscribe(res=>{
      //this.localStorage.set('res', res);
      this._eventlist=res;
      this.grandTotal=this.service2.getTotalPrice()
    })

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
    )}}


  get_eventlist() {
    this.service.fetchEventListFromRemote().subscribe(
      data=>this._eventlist=data,
      error=> console.log("error"),
    )

}





addtocart(event: any) {
    // Check if user is logged in
    if (!this.service2.isLoggedIn()) {
      // Navigate to login page if user is not logged in
      this.router.navigate(['/login']);
      return;
    } 
else {
this.service2.addtoCart(event);
return;
 }
}


 cart(){
    // Check if user is logged in
    if (!this.service2.isLoggedIn()) {
      // Navigate to login page if user is not logged in
      this.router.navigate(['/login']);
      return;
    } else {
      this.router.navigate(['/cart']);

 }
 }




getData(){
this.service2.get_eventlist().subscribe(
  res =>{
  this._eventlist=res;
  this._eventlist.forEach((a:any) =>{
  this.totalItem=res.length;  } )}   )}
     
  
  gotohome (){
    this.service2.removeAllCart();
  this.router.navigate(['']);
  }





}