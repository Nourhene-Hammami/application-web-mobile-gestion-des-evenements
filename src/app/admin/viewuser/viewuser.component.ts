import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { CrudserviceeventService } from 'src/app/crudserviceevent.service';
import { Event }from 'src/app/event';
import { Utilisateurs } from 'src/app/utilisateurs';
import { UtilisateurserviceService } from 'src/app/utilisateurservice.service';

@Component({
  selector: 'app-viewuser',
  templateUrl: './viewuser.component.html',
  styleUrls: ['./viewuser.component.css']
})
export class ViewuserComponent  implements OnInit{

 user =new Utilisateurs();
  _userlist: Array<Utilisateurs>=[];
  
  constructor(private router:Router,public service:UtilisateurserviceService  ,
    private activateRouter:ActivatedRoute){}
  ngOnInit(){ 


    let id = null;
    const idParam = this.activateRouter.snapshot.paramMap.get('id');
    if (idParam !== null) {
      id = parseInt(idParam);
        this.service.getUser(id).subscribe(
      data=>{
        console.log("Data received");
        this.user=data;}
        ,
        error=>console.log("error")
    )}
  }







  gotolist(){
    console.log("go back")
    this.router.navigate(['/admin/userlist']);}
}
