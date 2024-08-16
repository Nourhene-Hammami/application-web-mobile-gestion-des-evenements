import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { Utilisateurs } from 'src/app/utilisateurs';
import { UtilisateurserviceService } from 'src/app/utilisateurservice.service';

@Component({
  selector: 'app-searchuser',
  templateUrl: './searchuser.component.html',
  styleUrls: ['./searchuser.component.css']
})
export class SearchuserComponent {
  constructor(private service:UtilisateurserviceService,private router:Router){}
  _userlist: Array<Utilisateurs>=[];
  ngOnInit(): void {



    this.service.getUsers().subscribe(
      data=>{
      
        console.log("reponse reseived");
        this._userlist=data;},
      error=>console.log("exception occured")
    )
   }

  

/* myFunction1(){
  /* When the user clicks on the button toggle between hiding and showing the dropdown content */
  //document.getElementById("myDropdown")?.classList.toggle("show"); //
//}// 


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
 
 /*    filterFunction() {
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
          }}}  */
      



          get_userlist() {
            this.service.getUsers().subscribe(
              data=>this._userlist=data,
              error=> console.log("error"),
            )
            }




            gotouser(id:number){
              console.log("id"+id);
               this.router.navigate(['/admin/viewuser',id]);
             }






















}
