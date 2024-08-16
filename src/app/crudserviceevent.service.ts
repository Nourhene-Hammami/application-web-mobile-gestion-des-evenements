import { HttpClient, HttpEvent, HttpRequest } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { map, Observable, pipe } from 'rxjs';

//import { Event }from 'src/app/event';
class Event{

}
@Injectable({
  providedIn: 'root'
})
export class CrudserviceeventService {
  listData !:Event[];
  host:string="http://localhost:9000";

  
//event =new Event();
  constructor( private http:HttpClient) { }

fetchEventListFromRemote():Observable<any>{
  return this.http.get<any>("http://localhost:9000/geteventlist")
 
}

addEventToRemote(event:FormData):Observable<any>{
  return this.http.post<any>("http://localhost:9000/addevent/",event);
}


fetcheventbyIdFromRemote(id:number):Observable<any>{
  return this.http.get<any>("http://localhost:9000/geteventbyid/"+id);
}

deleteeventbyIdFromRemote(id:number):Observable<any>{
  return this.http.delete<any>("http://localhost:9000/deleteventbyid/"+id);
}


















}
