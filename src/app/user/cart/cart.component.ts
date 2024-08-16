
import { ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { PanierserviceService } from '../../panierservice.service';
import { Event }from 'src/app/event';
import { ActivatedRoute, Router } from '@angular/router';
import { CrudserviceeventService } from '../../crudserviceevent.service';
import { BehaviorSubject } from 'rxjs';
import { LocalStorageService } from 'angular-web-storage';
@Component({
  selector: 'app-cart',
  templateUrl: './cart.component.html',
  styleUrls: ['./cart.component.css']
})
export class CartComponent  implements OnInit{
 
  public petittotal: number=0;
  public totalItem: number=0;
  event =new Event();
  public grandTotal: number=0;
  public _eventlist!: any[];
  showDeleteMessage :boolean= false;


  constructor(public panierservice:PanierserviceService, private service:CrudserviceeventService  
    ,private router:Router   ,private activateRouter:ActivatedRoute,private cdRef: ChangeDetectorRef,private localStorage: LocalStorageService){}
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

    this.getData();
    this.panierservice.get_eventlist()
    .subscribe(res=>{


  //    this.localStorage.set('res', res);

      this._eventlist=res;
      this.grandTotal=this.panierservice.getTotalPrice()
 
    })
  }
 

  removeItem(event:any){
    if(confirm('are you sure to delete?')){
    this.panierservice.removeCartItem(event)
  
    alert("event deleted sucessfully")
   }
  }

emptycart(){

this.panierservice.removeAllCart();
}



gotohome (){
    this.panierservice.removeAllCart();
  this.router.navigate(['']);
  }




updateEventTotal(event: any) {
  if (event.ticketType === 'student') {
    event.total = event.qte * event.priceForStudent;
  } else if (event.ticketType === 'non-student') {
    event.total = event.qte * event.priceForNoStudent;
  }
  this.grandTotal = this.panierservice.getTotalPrice();
}


getData(){

  this.panierservice.get_eventlist().subscribe(
  
    res =>{
      this._eventlist=res;
   
      this._eventlist.forEach((a:any) =>{
   
        this.totalItem=res.length;
      });
      this.grandTotal = this.panierservice.getTotalPrice();
      
  
    });}

  




}



