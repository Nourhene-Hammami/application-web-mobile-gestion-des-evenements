import { Component, OnInit } from '@angular/core';
import { DataserviceService } from 'src/app/dataservice.service';
import { PanierserviceService } from 'src/app/panierservice.service';

@Component({
  selector: 'app-attestation',
  templateUrl: './attestation.component.html',
  styleUrls: ['./attestation.component.css']
})
export class AttestationComponent  implements OnInit{
  NomClt!: string;
  Adress!: string;
  Ville!: string;
  tel!: string;
  Codep!: string;
  qte!: string;
  public _eventlist!: any[];

  NomEvent!: string;
  constructor(  public dataservice:DataserviceService,private panierservice:PanierserviceService){}
  ngOnInit(): void {
    this.NomClt = this.dataservice.getNom();
    this.Adress = this.dataservice.getAdress();
    this.Ville = this.dataservice.getVille();
    this.tel = this.dataservice.getTel();
    this.Codep = this.dataservice.getCodep();
    this.NomEvent = this.dataservice.getNameEvent();
    this.qte = this.dataservice.getQteEvent();
    this.panierservice.get_eventlist()
    .subscribe(res=>{
      this._eventlist=res;
    //  this.grandTotal=this.panierservice.getTotalPrice()
  
  })
  }
  printthispage(){
window.print();
location.reload();


  }

}
