import { HttpClient } from '@angular/common/http';
import { Component } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { DomSanitizer } from '@angular/platform-browser';
import { ActivatedRoute, Router } from '@angular/router';
import { CrudserviceeventService } from 'src/app/crudserviceevent.service';
import { Event }from 'src/app/event';
import { Utilisateurs } from 'src/app/utilisateurs';
import { UtilisateurserviceService } from 'src/app/utilisateurservice.service';

@Component({
  selector: 'app-edituser',
  templateUrl: './edituser.component.html',
  styleUrls: ['./edituser.component.css']
})
export class EdituserComponent {
  userToUpdate=new Utilisateurs();
public _userlist: Array<Utilisateurs>=[];
formIsValid = false;
 


  constructor(private router:Router
    ,private activateRouter:ActivatedRoute,private sanit:DomSanitizer,private http: HttpClient
    ,private userservice:UtilisateurserviceService){}
  ngOnInit(){


   

    let id = null;
const idParam = this.activateRouter.snapshot.paramMap.get('id');
if (idParam !== null) {
  id = parseInt(idParam);


this.userservice.getUser(id).subscribe(
  (data:Utilisateurs)=>{
    console.log("Data feteched successfully");
    this.userToUpdate=data;}
    ,
    error=>console.log("error")
)}

}

/*updateuserfromsubmit() {
  if (this.registerForm.valid) {
      //valider le formulaire 
      this.formIsValid = true;
      this.userservice.registerUserFromRemote(this.userToUpdate).subscribe(
       
        (data )=>{
          console.log("Your registration is successful");


  this.userservice.addUser(this.userToUpdate).subscribe(
     data => { 
      console.log('data',data)
       console.log("user added successfully");
       this.router.navigate(['/admin/userlist']);
     },
     error => {
       console.log("error:", error);
     }
   )
   
   ;}    ,error =>{   console.log("pas d'inscription  mail alredy exist");
   alert("mail  alerady exist") ; })}
 }*/
 updateuserfromsubmit() {
  if (this.registerForm.valid) {
    // valider le formulaire
    this.formIsValid = true;

    // récupérer l'id de l'utilisateur que l'on souhaite mettre à jour
    const id = this.userToUpdate.id;

    // vérifier si l'adresse e-mail est unique, en excluant l'adresse e-mail de l'utilisateur que l'on met à jour
    this.userservice.getUsers().subscribe(users => {
      const isEmailUnique = users.every((user: { mail: string; id: number; }) => user.mail !== this.userToUpdate.mail || user.id === id);
      if (isEmailUnique) {
        // si l'adresse e-mail est unique, enregistrer les modifications
        this.userservice.addUser(this.userToUpdate).subscribe(() => {
          alert('User updated successfully');
          this.router.navigate(['/admin/userlist']);
        });
      } else {
        // si l'adresse e-mail n'est pas unique, afficher une alerte
        console.log('Email already exists');
        alert('Email already exists');
      }
    });
  }
}




 registerForm= new FormGroup({
  name:new FormControl('',[
    Validators.required,Validators.minLength(2), Validators.pattern('[a-zA-Z].*'),
  ]),
  mail:new FormControl('',[ Validators.required,Validators.email
  ]),
  role: new FormControl('', [ Validators.required ]),
  password:new FormControl('',[
    Validators.required, Validators.minLength(4), Validators.maxLength(10),
  ]),
 } )



 get UserName():FormControl{
  return this.registerForm.get("name") as FormControl;           }
  get Mail():FormControl{
    return this.registerForm.get("mail") as FormControl;           }

    get Role():FormControl{
    return this.registerForm.get("role") as FormControl;           }
    get Password():FormControl{
      return this.registerForm.get("password") as FormControl;           }



get_eventlist() {
  this.userservice.getUsers().subscribe(
    data=>this._userlist=data,
    error=> console.log("error"),
  )
  }



  gotolist(){
    console.log("go back")
    this.router.navigate(['/admin/userlist']);}

}
