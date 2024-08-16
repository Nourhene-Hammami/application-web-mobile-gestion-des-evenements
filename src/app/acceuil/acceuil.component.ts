import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-acceuil',
  templateUrl: './acceuil.component.html',
  styleUrls: ['./acceuil.component.css']
})
export class AcceuilComponent implements OnInit {
  ngOnInit(): void {}

   
  constructor(private router:Router){}  //constructeur
  goToLogin(){this.router.navigate(["/login"])}
  
  goToRegister(){this.router.navigate(["/register"])}
 
  

}
