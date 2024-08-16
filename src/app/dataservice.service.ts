import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class DataserviceService {
  nomevent!: string;


  

  constructor() { }
  private nom!: string;
  private address!: string;
  qte!: string;
  tel!: string;
  codep!: string;
  ville!: string;
  setNom(nom: string) {
    this.nom = nom;
  }

  getNom(): string {
    return this.nom;
  }
  setAdress(address: string) {
    this.address= address;
  }

  getAdress(): string {
    return this.address;
  }
  setVille(ville: string) {
    this.ville = ville;
  }

  getVille(): string {
    return this.ville;
  }
  setTel(tel: string) {
    this.tel = tel;
  }

  getTel(): string {
    return this.tel;
  }
  setCodep(codep: string) {
    this.codep = codep;
  }

  getCodep(): string {
    return this.codep;
  }
  setNameEvent(nom: string) {
    this.nomevent = nom;
  }

  getNameEvent(): string {
    return this.nomevent;
  }
  setQteEvent(qte: string) {
    this.qte = qte;
  }

  getQteEvent(): string {
    return this.qte;
  }

}
