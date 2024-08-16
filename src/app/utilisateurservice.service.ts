import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, tap } from 'rxjs';
import { Utilisateurs } from './utilisateurs';
import { LocalStorageService } from 'angular-web-storage';

@Injectable({
  providedIn: 'root'
})

export class UtilisateurserviceService {
 
  constructor(private http:HttpClient) { }//3

  public getUtilisateurData(mail: string,password: string){    
    console.log(mail,password)
    return this.http.get('http://localhost:9000/utilisateur/'+mail+'/'+password) ;
   
  }

  public registerUserFromRemote(user:Utilisateurs):Observable<any>{
  //  console.log(user)
    return this.http.post<any>("http://localhost:9000/registeruser",user);
  }



  public getUserRole(mail: string) {
    return this.http.get('http://localhost:9000/utilisateur/role/' + mail, {responseType: 'text'});
  }

// Get all users
getUsers(): Observable<any> {
  return this.http.get<any>(`http://localhost:9000/getusers/`) ;
}

// Get a user by id
getUser(id: number): Observable<any> {
  return this.http.get<any>('http://localhost:9000/getuser/'+id);
}


// Add a new user
addUser(user: Utilisateurs): Observable<any> {
  return this.http.post<any>(`http://localhost:9000/adduser/`, user);
}  

// Update an existing user
updateUser(id: number, user: Utilisateurs): Observable<any> {
  return this.http.put<any>('http://localhost:9000/updateuser/'+id,+user);
}

// Delete a user by id
deleteUser(id: number): Observable<any> {
  return this.http.delete<any>("http://localhost:9000/deleteuser/"+id);
}
getUserByMail(mail: string): Observable<Utilisateurs> {
  return this.http.get<Utilisateurs>(`http://localhost:9000/utilisateur/${mail}`);
}










  

}


