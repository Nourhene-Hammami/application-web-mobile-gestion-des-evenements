import { HttpClient, HttpInterceptor } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { FormGroup } from '@angular/forms';
import { BehaviorSubject, Observable } from 'rxjs';
import { Lpanier } from './lpanier';
import { LocalStorageService } from 'angular-web-storage';
import { Utilisateurs } from './utilisateurs';

@Injectable({
  providedIn: 'root'
})
export class PanierserviceService {
  user=new Utilisateurs();
  private baseUrl = 'http://localhost:9000/paniers';
public cartItemlist:any=[]
public  _eventlist= new BehaviorSubject<any>([]);
public totalItem: number=0;
 item!:any;
  

  constructor(private http:HttpClient, private localStorage: LocalStorageService  ) { }

  getCartData(event:any) {
   
      let cartItemsFromStorage = localStorage.getItem('cartItems');
    if(cartItemsFromStorage !== null) {
      this.cartItemlist = JSON.parse(cartItemsFromStorage);
    }
    
      // Rechercher l'article dans le panier
      const itemIndex = this.cartItemlist.findIndex((item:any) => item.id === event.id);
      if (itemIndex !== -1) {
       
        

        // L'article existe déjà dans le panier, augmenter la quantité
        console.log(this.cartItemlist[itemIndex].qte);
        this.cartItemlist[itemIndex].qte++;
        console.log(this.cartItemlist[itemIndex].qte);
  
        this.cartItemlist[itemIndex].total = this.cartItemlist[itemIndex].qte * event.price;
  
  
  
  
      }
      // Stocker la liste des articles dans le panier dans le stockage local
    localStorage.setItem('cartItems', JSON.stringify(this.cartItemlist));
    
      
      this._eventlist.next(this.cartItemlist);
      this.getTotalPrice();
    
    

   }
  isLoggedIn(): boolean {
   const token = this.localStorage.get('user');
  return !!token;
  }
  

getData(id:number):Observable<Object>{
    return this.http.get('${this.baseUrl}/${id}');}


saveorupdate(info: Object): Observable<number> {
      return this.http.post<number>(`${this.baseUrl}`, info);
    }
   /* addtolpanier(lpanier: Lpanier): Observable<Lpanier> {
      return this.http.post<Lpanier>(`http://localhost:9000/lpanier`, lpanier);
    }*/
    addtolpanier(lpanier: Lpanier, panierId: number,userId :number): Observable<Lpanier> {
    panierId=(this.localStorage.get('panier'));
    userId =( this.localStorage.get('user')).id;
      return this.http.post<Lpanier>('http://localhost:9000/lpanier/' + panierId +'/'+userId, lpanier);
    }
    
    
updatedata(id:number,value:number){
return this.http.put('${this.baseUrl}/${id}',value);
}
public deleteData(id:number):Observable<Object>{
  return this.http.delete('${this.baseUrl}/${id}',{responseType:'text'});
}

getAll():Observable<Object>{
  return this.http.get('${this.baseUrl}');
}

get_eventlist(){
  return this._eventlist.asObservable();
 
}

set_eventlist(event:any)
{this.cartItemlist.push(...event);
this._eventlist.next(event);
}





getTotalPrice(){
  let grandtotal=0;
  this.cartItemlist.map((event:any)=>{
    grandtotal+=event.total;
  }) 
  return grandtotal
}

addtoCart(event:any) {
  let cartItemsFromStorage = localStorage.getItem('cartItems');
if(cartItemsFromStorage !== null) {
  this.cartItemlist = JSON.parse(cartItemsFromStorage);
}

  // Rechercher l'article dans le panier
  const itemIndex = this.cartItemlist.findIndex((item:any) => item.id === event.id);
  if (itemIndex !== -1) {

      // Vérifier si la quantité est déjà 5
      if (this.cartItemlist[itemIndex].qte >= event.stoke) {
       
        console.log('Stock epuise ');
         alert(" Stock sold out  ")    
      return;
    }

        else{
    // L'article existe déjà dans le panier, augmenter la quantité
    console.log(this.cartItemlist[itemIndex].qte);
    this.cartItemlist[itemIndex].qte++;
    console.log(this.cartItemlist[itemIndex].qte);



    this.cartItemlist[itemIndex].total = this.cartItemlist[itemIndex].qte * event.priceForStudent;
        }

}else {
    // Ajouter l'article au panier
    Object.assign(event, {qte: 1, total: event.price * 1});
    this.cartItemlist.push(event);
  }
  // Stocker la liste des articles dans le panier dans le stockage local
localStorage.setItem('cartItems', JSON.stringify(this.cartItemlist));

  
  this._eventlist.next(this.cartItemlist);
  this.getTotalPrice();
  alert('Event added to cart successfully'); 
}




 public removeCartItem(event:any){
this.cartItemlist.map((a:any,index:any)=>{
if(event.id==a.id)
this.cartItemlist.splice(index,1)
  // Remove cart items from localStorage
  localStorage.setItem('cartItems', JSON.stringify(this.cartItemlist));
});

this._eventlist.next(this.cartItemlist);


  }







removeAllCart(){
  this.cartItemlist=[]
  this._eventlist.next(this.cartItemlist);
  
  // Remove cart items from localStorage
  localStorage.setItem('cartItems', JSON.stringify([]));
}
}













