import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Utilisateurs } from 'src/app/utilisateurs';
import { UtilisateurserviceService } from 'src/app/utilisateurservice.service';

@Component({
  selector: 'app-adduser',
  templateUrl: './adduser.component.html',
  styleUrls: ['./adduser.component.css']
})


export class AdduserComponent implements OnInit {
  user=new Utilisateurs();
  public _userlist: Array<Utilisateurs>=[];
  formIsValid = false;
  



  constructor(private router:Router,private service:UtilisateurserviceService){}
  ngOnInit(): void {


  }
 
  
  adduserfromsubmit() {
    if (this.registerForm.valid) {
        //valider le formulaire 
        this.formIsValid = true;
        // récupérer l'id de l'utilisateur que l'on souhaite mettre à jour
        const id = this.user.id;

        // vérifier si l'adresse e-mail est unique, en excluant l'adresse e-mail de l'utilisateur que l'on met à jour
        this.service.getUsers().subscribe(users => {
            const isEmailUnique = users.every((user: { mail: string; id: number; }) => user.mail !== this.user.mail || user.id === id);
            if (isEmailUnique) {
                this.service.addUser(this.user).subscribe(
                    data => { 
                        console.log('data',data)
                        console.log("user added successfully");
                        alert("user added successfully")
                        this.router.navigate(['/admin/userlist']);
                    },
                    error => {
                        console.log("error:", error);
                    }
                );
            } else {
                console.log("pas d'inscription  mail alredy exist");
                alert("mail  alerady exist");
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


      
  gotolist(){
    console.log("go back")
    this.router.navigate(['/admin/userlist']);}

}
