import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { CrudserviceeventService } from '../../crudserviceevent.service';
import { Event }from 'src/app/event';
@Component({
  selector: 'app-searchadmin',
  templateUrl: './searchadmin.component.html',
  styleUrls: ['./searchadmin.component.css']
})
export class SearchadminComponent {
  constructor(private service:CrudserviceeventService,private router:Router){}
  _eventlist: Array<Event>=[];
  ngOnInit(): void {
    this.service.fetchEventListFromRemote().subscribe(
      data=>{
      
        console.log("reponse reseived");
        this._eventlist=data;},
      error=>console.log("exception occured")
    )
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
 



          get_eventlist() {
            this.service.fetchEventListFromRemote().subscribe(
              data=>this._eventlist=data,
              error=> console.log("error"),
            )
            }




    }
  


