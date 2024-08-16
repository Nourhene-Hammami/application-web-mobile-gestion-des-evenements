import { DatePipe } from '@angular/common';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { CrudserviceeventService } from '../../crudserviceevent.service';
import { PanierserviceService } from '../../panierservice.service';
import { Event }from 'src/app/event';
import { Panier } from '../../panier';
import { Lpanier } from '../../lpanier';
import { LocalStorageService } from 'angular-web-storage';
import { DataserviceService } from 'src/app/dataservice.service';


@Component({
  selector: 'app-payement',
  templateUrl: './payement.component.html',
  styleUrls: ['./payement.component.css']
})
export class PayementComponent  implements OnInit{

  [x: string]: any;
  panier =new Panier();
  event =new Event();
  public petittotal: number=0;
  public totalItem: number=0;
  public grandTotal: number=0;
  public _eventlist!: any[];
  annee!:number;
  formIsValid = false;
compteur:any=[];

  constructor(private panierservice:PanierserviceService, public service:CrudserviceeventService  
    ,private router:Router  ,private activateRouter:ActivatedRoute,private localStorage: LocalStorageService, public dataservice:DataserviceService){}


  ngOnInit(): void {
 

    //recuperer l'event par son id 
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
    this.getData();
    this.panierservice.get_eventlist()
    .subscribe(res=>{
      this._eventlist=res;
      this.grandTotal=this.panierservice.getTotalPrice()
  
  })
  }

valider() {
  if (this.registerForm.valid) {
    // valider le formulaire 
    this.formIsValid = true;
   // let panierId: number =0;
   let panierId: number ;
   let userId: number ;
    const info : Panier = {
      //id: 0,
      nom: this.Nom.value,
    
      adresse: this.Adresse.value,
      ville: this.Ville.value,
      tel: this.Tel.value,
      codep: this.Codep.value,
      id: 0
      
    };
    this.dataservice.setNom(this.Nom.value),
    this.dataservice.setAdress(this.Adresse.value), 
    this.dataservice.setVille(this.Ville.value), 
    this.dataservice.setTel(this.Tel.value),
    this.dataservice.setCodep(this.Codep.value),

//const headers = new HttpHeaders().set('Content-Type', 'application/json');
this.panierservice.saveorupdate(info).subscribe(
  (data ) => {
    panierId = data;
    console.log(panierId); 
    this.localStorage.set('panier', panierId);
    panierId = this.localStorage.get('panier');
    console.log('Event added to  panier database successfully');
    for (let currentEvent of this._eventlist) {
      panierId = this.localStorage.get('panier');
      userId = (this.localStorage.get('user')).id;
      const libelle = currentEvent.name; // define libelle here
      const qte = currentEvent.qte;
      const eventToAdd: Lpanier = {
        libelle: currentEvent.name,
        //price: currentEvent.priceForStudent,
        price: currentEvent.ticketType === 'student' ? currentEvent.priceForStudent : currentEvent.priceForNoStudent,

        qte: currentEvent.qte,
        total: currentEvent.total,
        ticketType:currentEvent.ticketType,
       
        panier_id: panierId,
        id: 0,
      };
      console.log(currentEvent.TicketType),  
      this.dataservice.setNameEvent(libelle), 
      this.dataservice.setQteEvent(qte), 
 
      console.log(panierId);
      console.log(userId);
      
      
      this.panierservice.addtolpanier(eventToAdd, panierId,userId).subscribe(
        (data) => {
          console.log('Event added  lpanier to database successfully');
        },
        (error) => {
          console.log('Error adding event to  lpanier database', error);
        }
      );
    }
    alert('Payment made successfully .Can now consult your attestation & your badger.');
  },
  (error) => {
    console.log('Error adding event to database', error);
    alert('Error');
  }
  )}}



 /*transformData(date){
  return this.datePipe.transform(date,'yyyy-MM-dd')
 }*/


 gotohome (){
  this.panierservice.removeAllCart();
this.router.navigate(['']);
}
getData(){
  this.panierservice.get_eventlist().subscribe(
    res =>{this._eventlist=res;
 this._eventlist.forEach((a:any) =>{
 this.totalItem=res.length; }
        )
  
    }
  )}


  registerForm= new FormGroup({

    nom:new FormControl('',[Validators.required,Validators.minLength(2), Validators.pattern('[a-zA-Z].*'),]),
    adresse:new FormControl('',[Validators.required,Validators.minLength(8), ]),
    ville:new FormControl('',[Validators.required,Validators.minLength(4), ]),
tel:new FormControl('',[Validators.required,Validators.minLength(8), Validators.maxLength(8),Validators.pattern('[0-9]*')]),
codep:new FormControl('',[Validators.required,Validators.minLength(4), Validators.maxLength(4),Validators.pattern('[0-9]*')]),
  });





  get Nom():FormControl{return this.registerForm.get("nom") as FormControl; }
  get Adresse():FormControl{return this.registerForm.get("adresse") as FormControl;  }
  get Ville():FormControl{return this.registerForm.get("ville") as FormControl;  }
  get Tel():FormControl{return this.registerForm.get("tel") as FormControl; }
  get Codep():FormControl{return this.registerForm.get("codep") as FormControl; }






}
