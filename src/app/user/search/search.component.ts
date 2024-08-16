import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { CrudserviceeventService } from '../../crudserviceevent.service';
import { Event }from 'src/app/event';
import { PanierserviceService } from 'src/app/panierservice.service';
import { LocalStorageService } from 'angular-web-storage';

@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css']
})

export class SearchComponent implements OnInit {
  _eventlist: Array<Event>=[];
  public totalItem: number=0;
  public cartItemlist:any=[]
  event =new Event();
  public petittotal: number=0;
  public grandTotal: number=0;
  
  constructor(private service:CrudserviceeventService,private router:Router, private activateRouter:ActivatedRoute,private service2:PanierserviceService,private localStorage: LocalStorageService){}
 //liste= this.localStorage.get('res');
  ngOnInit(): void {
   
   /* const data = this.service2.getCartData();
  this._eventlist = data;
  this.totalItem = data.length;*/
  this.grandTotal = this.service2.getTotalPrice();



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


    this.service.fetchEventListFromRemote().subscribe(
      data=>{
      
        console.log("reponse reseived");
        this._eventlist=data;},
      error=>console.log("exception occured")
    );
   
   }
  getData(){
   
    this.service2.get_eventlist().subscribe(
      data=>{this._eventlist=data;
     this._eventlist.forEach((a:any) =>{
    this.totalItem=data.length;  } )}   )}


  
    
   cart(){
    // Check if user is logged in
    if (!this.service2.isLoggedIn()) {
      // Navigate to login page if user is not logged in
      this.router.navigate(['/login']);
      return;
    } else {
      this.service2.getCartData(this.event);
      this.router.navigate(['/cart']);

  
  }
  }
  gotohome (){
    this.service2.removeAllCart();
  this.router.navigate(['']);
  }
myFunction1(){
  /* When the user clicks on the button toggle between hiding and showing the dropdown content */
document.getElementById("myDropdown")?.classList.toggle("show");
}
  myFunction() { 
    // Declare variables
    var input:any|null, filter, table:any|null, tr, td, i, txtValue;
    input = document.getElementById("myInput");
    filter = input.value.toUpperCase();
    table = document.getElementById("myTable");
   tr = table.getElementsByTagName("tr");
    // Loop through all table rows, and hide those who don't match the search query//
    for(i=0; i< (tr.length); i++){
      td = tr[i].getElementsByTagName("td")[0];
      if (td) {
        txtValue = td.textContent || td.innerText;
         if(txtValue.toUpperCase().indexOf(filter) > -1){
          tr[i].style.display = "";
        } else {
          tr[i].style.display = "none";
        }
      } }}
 
     filterFunction() {
        var input:any|null, filter, div:any|null, a, i;
        input = document.getElementById("myInput1");
        filter = input.value.toUpperCase();
        div = document.getElementById("myDropdown");
        a = div.getElementsByTagName("a");
        for (i = 0; i < a.length; i++) {
          var txtValue = a[i].textContent || a[i].innerText;
          if (txtValue.toUpperCase().indexOf(filter) > -1) {
            a[i].style.display = "";
          } else {
            a[i].style.display = "none";
          }}} 
      



          get_eventlist() {
            this.service.fetchEventListFromRemote().subscribe(
              data=>this._eventlist=data,
              error=> console.log("error"),
            )
            }




            gotoevent(id:number){
              console.log("id"+id);
               this.router.navigate(['/eventdescption',id]);
             }
    }
  