import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { FormArrayName,FormControl,FormGroup,Validators } from '@angular/forms';
import { Utilisateurs } from '../utilisateurs';
import { UtilisateurserviceService } from '../utilisateurservice.service';
import { LocalStorageService } from 'angular-web-storage'; //stoker les info localement
@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit{
 
user=new Utilisateurs();
msg="";
formIsValid = false;
  
  constructor(private router:Router, private userservice :UtilisateurserviceService,private localStorage: LocalStorageService){}  //constructeur

  ngOnInit(): void {}
//validation du username et  mail et password
registerForm= new FormGroup({
  username:new FormControl('',[
    Validators.required,Validators.minLength(2), Validators.pattern('[a-zA-Z].*'),
  ]),
  mail:new FormControl('',[ Validators.required,Validators.email
  ]),
  password:new FormControl('',[
    Validators.required, Validators.minLength(4), Validators.maxLength(10),
  ]),
});
//
get UserName():FormControl{
  return this.registerForm.get("username") as FormControl;           }
  get Mail():FormControl{
    return this.registerForm.get("mail") as FormControl;           }
    
get Password():FormControl{
  return this.registerForm.get("password") as FormControl;           }


  goToLogin(){
    if (this.registerForm.valid) {
      //valider le formulaire 
       this.formIsValid = true;

    this.userservice.registerUserFromRemote(this.user).subscribe(
      (data )=>{
       // console.log("data");
      alert("Your registration is successful");
      this.localStorage.set('user', this.user);
        this.router.navigate(["/login"])//boutton register va a la page login

      }
     ,error =>{   console.log("pas d'inscription  mail alredy exist");
      alert("Email  alerady exist") ; }
   
    )}}
    
    
  






}
