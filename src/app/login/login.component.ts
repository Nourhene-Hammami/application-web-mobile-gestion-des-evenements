import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { UtilisateurserviceService } from '../utilisateurservice.service';
import { FormArrayName,FormControl,FormGroup,Validators } from '@angular/forms';
import{ Utilisateurs }from '../utilisateurs'
import { LocalStorageService } from 'angular-web-storage';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

      model :any={}
      res!:boolean;
user =new Utilisateurs();
      formIsValid = false;
  constructor(private router: Router , //construteur a un parameter router de type Router //
    private userservice :UtilisateurserviceService,private localStorage: LocalStorageService){}
  ngOnInit(): void {
}

//validation du mail et password par creation de group form
loginForm= new FormGroup({
  mail:new FormControl(" ",[Validators.required,Validators.email, ]),
  password:new FormControl(" ",[Validators.required, Validators.minLength(4),  Validators.maxLength(10), ]),
});
//getter de email et password
get Mail():FormControl{
  return this.loginForm.get("mail") as FormControl;           }
  
get Password():FormControl{
return this.loginForm.get("password") as FormControl;           }






//fonction qui permet de passer a la page catalogue//
/*goToCatalogue(){ 
  if (this.loginForm.valid) {
    //valider le formulaire 
     this.formIsValid = true;
  var mail =this.model.mail;
  var password =this.model.password;
  console.log(this.model);
console.log(this.loginForm.value)
// this.userservice.getUtilisateurData(mail,password).subscribe(res=>{
 //  console.log(res)
   



   this.userservice.getUtilisateurData(mail, password).subscribe(res => {
    console.log(res);
    if (res === 1) {
      this.userservice.registerUserFromRemote(this.user).subscribe(
        (data )=>{
       
    
        this.localStorage.set('user', this.user);
       
  
     
      this.userservice.getUserRole(mail).subscribe(role => {
        console.log(role)
        if (role === 'user') {
          alert("Login successful");
          this.router.navigate(['/catag']);
        } else if (role === 'admin') {
          alert("Login successful");
          this.router.navigate(['/admin/list']);
        } 
        
        else {
          alert("Invalid role");
        }
      });       })
    } else {
      alert("Invalid email or password");
    }
  }); 
  
    
  








  };
}*/







/*goToCatalogue() {
  if (this.loginForm.valid) {
    var mail = this.model.mail;
    var password = this.model.password;
    console.log(this.model);
    console.log(this.loginForm.value)

    this.userservice.getUtilisateurData(mail, password).subscribe(res => {
      console.log(res);
      if (res === 1) {
        const user = this.localStorage.get('user');
        if (user) {
          this.userservice.getUserRole(mail).subscribe(role => {
            console.log(role)
            if (role === 'user') {
              alert("Login successful");
              this.router.navigate(['/catag']);
            } else if (role === 'admin') {
              alert("Login successful");
              this.router.navigate(['/admin/list']);
            } else {
              alert("Invalid role");
            }
          });
        } else {
          alert("User not found");
        }
      } else {
        alert("Invalid email or password");
      }
    });
  }
}
*/



goToCatalogue() {
  if (this.loginForm.valid) {
    const mail = this.model.mail;
    const password = this.model.password;
    console.log(this.model);
    console.log(this.loginForm.value)

    this.userservice.getUtilisateurData(mail, password).subscribe(res => {
      console.log(res);
      if (res === 1) {
        this.userservice.getUserByMail(mail).subscribe(user => {
          console.log(user);
          if (user) {
            this.userservice.getUserRole(mail).subscribe(role => {
              console.log(role);
              if (role === 'user') {
                alert("Login successful");
                //stockez les données d'utilisateur saisies par l'utilisateur dans le stockage local
                this.localStorage.set('user', user); // save user data to local storage
              
                this.router.navigate(['/catag']);
              } else if (role === 'admin') {
                alert("Login successful");
                this.localStorage.set('user', user); // save user data to local storage
                this.router.navigate(['/admin/list']);
              } 
            });
          } 
          /*else {
            alert("User not found");
          }*/
        });
      } else {
        alert("Invalid email or password");
      }
    });
  }
}







}





