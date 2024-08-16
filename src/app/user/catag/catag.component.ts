import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Event }from 'src/app/event';
import { CrudserviceeventService } from '../../crudserviceevent.service';
import { PanierserviceService } from 'src/app/panierservice.service';
import { LocalStorageService } from 'angular-web-storage';

@Component({
  selector: 'app-catag',
  templateUrl: './catag.component.html',
  styleUrls: ['./catag.component.css']
})
export class CatagComponent  implements OnInit{
  
  favoirs!: number[];
  private favoris: number[] = [];
  id !:number;
 monevent_id!:number;
 event =new Event();
  _eventlist: Array<Event>=[];
 public totalItem: number=0;

 public grandTotal: number=0;

  constructor(public service:CrudserviceeventService,private router:Router,
   public service2:PanierserviceService,private localStorage: LocalStorageService
    ){}
  ngOnInit( ){
    this.favoirs = [];
    this.service.fetchEventListFromRemote().subscribe(
    data=>{
    console.log("reponse reseived");
      this._eventlist=data;},
    error=>console.log("exception occured"));

    this.getData();
 
    this.service2.get_eventlist()
    .subscribe(res=>{
      this._eventlist=res;
      this.grandTotal=this.service2.getTotalPrice()
    })
  }

getData(){
  this.service2.get_eventlist().subscribe(
    res =>{this._eventlist=res;
   this._eventlist.forEach((a:any) =>{
  this.totalItem=res.length;  } )}   )}


  
  get_eventlist() {
    this.service.fetchEventListFromRemote().subscribe(
      data=>this._eventlist=data,
      error=> console.log("error"),
    )
    }
    gotoevent(id:number){
      console.log("id"+id);
       this.router.navigate(['/eventdescption',id]);      }
   
       cart(){
        // Check if user is logged in
        if (!this.service2.isLoggedIn()) {
          // Navigate to login page if user is not logged in
          this.router.navigate(['/login']);
          return;
        } else {
          this.service2.getCartData(this.event);
          this.router.navigate(['/cart']);
    
      
      }
      }

      gotohome (){
        this.service2.removeAllCart();
      this.router.navigate(['']);
      }



    
/*toggleFavoris(id: number): void {
  const index = this.favoirs.indexOf(id);
  let found = false;
console.log(id)

  if (index !== id) {
 // Si l'événement est déjà présent dans la liste des favoris, le supprimer
    this.favorisService.retirerFavoris(id).subscribe(data => {
      // Retirer l'événement de la liste des favoris
      this.favoirs.splice(index, 1);
      console.log("favoris supprimé");
    });
  } else {
    this.favorisService.ajouterFavoris(id).subscribe(data => {
      // Ajouter l'événement à la liste des favoris
      this.favoirs.push(id);
      console.log("favoris ajouté");
    });
  }
}*/


/*toggleFavoris(id: number): void {
 
  const foundFavori = this.favoris.find(favori => 
    favori=== id);
  
 //const index = this.favoirs.indexOf(id);
  this.favorisService.getFavoris().subscribe(
    data => {
      this.favoris = data;
      if (foundFavori) {
        // Si l'événement est déjà présent dans la liste des favoris, le supprimer
        this.favorisService.retirerFavoris(id).subscribe(data => {
          // Retirer l'événement de la liste des favoris
          const index = this.favoris.indexOf(foundFavori);
          this.favoris.splice(index, 1);
          console.log("favoris supprimé");
        });
      } else {
        this.favorisService.ajouterFavoris(id).subscribe(data => {
          // Ajouter l'événement à la liste des favoris
          //const newFavori = {id: data.id, event: id};
          this.favoris.push(id);
          console.log("favoris ajouté");
        });
      }
    }
  );
}
*/





/*cart(){
  // Check if user is logged in
  if (!this.service2.isLoggedIn()) {
    // Navigate to login page if user is not logged in
    this.router.navigate(['/login']);
    return;
  } else {
    this.router.navigate(['/cart']);

}
}*/


/*toggleFavoris(id: number): void {
  const index = this.favoirs.findIndex(favoir => favoir=== id);
  console.log (id)
  if (index !== -1) {
    // Si l'événement est déjà présent dans la liste des favoris, le supprimer
    this.favorisService.retirerFavoris(id).subscribe(data => {
      // Retirer l'événement de la liste des favoris
      this.favoirs.splice(index, 1);
      console.log("favoris supprimé");
    });
  } else {
    this.favorisService.ajouterFavoris(id).subscribe(data => {
      // Ajouter l'événement à la liste des favoris
      this.favoirs.push(id );
      console.log("favoris ajouté");
    });
  }
}*/


































/*toggleFavoris(id: number): void {
  let found = false;
  this.favoirs.forEach((favoir) => {
   
    if (favoir=== id) {
      found = true;
      // Si l'événement est déjà présent dans la liste des favoris, le supprimer
      this.favorisService.retirerFavoris(id).subscribe(() => {
        // Retirer l'événement de la liste des favoris
        this.favoirs.splice(this.favoirs.indexOf(favoir), 1);
        console.log("favoris supprimé");
      });
    }
  });
  if (!found) {
    this.favorisService.ajouterFavoris(id).subscribe((favori) => {
      // Ajouter l'événement à la liste des favoris
      this.favoirs.push(favori);
      console.log("favoris ajouté");
    });
  }
}*/








      
      isFavoris(id: number): boolean {
        return this.favoirs && this.favoirs.includes(id);
      }
      
 



    
 
     

      


      }

