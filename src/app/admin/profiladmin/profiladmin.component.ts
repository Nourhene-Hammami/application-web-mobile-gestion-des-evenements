import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { LocalStorageService } from 'angular-web-storage';
import { PanierserviceService } from 'src/app/panierservice.service';
import { Utilisateurs } from 'src/app/utilisateurs';
import { UtilisateurserviceService } from 'src/app/utilisateurservice.service';

@Component({
  selector: 'app-profiladmin',
  templateUrl: './profiladmin.component.html',
  styleUrls: ['./profiladmin.component.css']
})
export class ProfiladminComponent  implements OnInit{

  user =new Utilisateurs();
 formIsValid = false;
  constructor(private localStorage: LocalStorageService  
    ,private userservice:UtilisateurserviceService,private router:Router,public service2 :PanierserviceService)  {}

  ngOnInit() {
 
    const user = this.localStorage.get('user');
    if (user) {
     this.user = user;
    
  }
}




updateuserfromsubmit() {
  if (this.registerForm.valid) {
    // valider le formulaire
    this.formIsValid = true;

    // récupérer l'id de l'utilisateur que l'on souhaite mettre à jour
    const id = this.user.id;

    // vérifier si l'adresse e-mail est unique, en excluant l'adresse e-mail de l'utilisateur que l'on met à jour
    this.userservice.getUsers().subscribe(users => {
      const isEmailUnique = users.every((user: { mail: string; id: number; }) => user.mail !== this.user.mail || user.id === id);
      if (isEmailUnique) {
        // si l'adresse e-mail est unique, enregistrer les modifications
        this.userservice.addUser(this.user).subscribe(() => {
          // fetch the updated user information from the server
          this.userservice.getUser(id).subscribe(user => {
            // update the user object in the component with the updated user object from the server
            this.user = user;

            // update the user object in the local storage
            this.localStorage.set('user', this.user);

            // update the values displayed in the form with the updated user information
            this.registerForm.patchValue({
              name: user.name,
              mail: user.mail,
              password: user.password
            });

            alert('User updated successfully');
            this.router.navigate(['admin/list']);
          });
        });
      } else {
        // si l'adresse e-mail n'est pas unique, afficher une alerte
        alert('Email already exists');
       
      }
    });
  }
}
/*  updateuserfromsubmit() {
    if (this.registerForm.valid) {
      // valider le formulaire
      this.formIsValid = true;
  
      // récupérer l'id de l'utilisateur que l'on souhaite mettre à jour
      const id = this.user.id;
  
      // vérifier si l'adresse e-mail est unique, en excluant l'adresse e-mail de l'utilisateur que l'on met à jour
      this.userservice.getUsers().subscribe(users => {
        const isEmailUnique = users.every((user: { mail: string; id: number; }) => user.mail !== this.user.mail || user.id === id);
        if (isEmailUnique) {
          // si l'adresse e-mail est unique, enregistrer les modifications
          this.userservice.addUser(this.user).subscribe(() => {
            // fetch the updated user information from the server
            this.userservice.getUser(id).subscribe(user => {
               user = this.localStorage.get('user');
              this.user = user;
             
           
            alert('User updated successfully');
            this.router.navigate(['/catag']);
          });  });
        } else {
          // si l'adresse e-mail n'est pas unique, afficher une alerte
          console.log('Email already exists');
          alert('Email already exists');
        }
      });
    }
  } */       

 
  
  
  

  registerForm= new FormGroup({
    name:new FormControl('',[
      Validators.required,Validators.minLength(2), Validators.pattern('[a-zA-Z].*'),
    ]),
    mail:new FormControl('',[ Validators.required,Validators.email
    ]),
    password:new FormControl('',[
      Validators.required, Validators.minLength(4), Validators.maxLength(10),
    ]),
   } )
  get UserName():FormControl{
    return this.registerForm.get("name") as FormControl;           }
    get Mail():FormControl{
      return this.registerForm.get("mail") as FormControl;           }
 
      get Password():FormControl{
        return this.registerForm.get("password") as FormControl;           }


        gotolist(){
          console.log("go back")
          this.router.navigate(['/admin/list']);}


}


