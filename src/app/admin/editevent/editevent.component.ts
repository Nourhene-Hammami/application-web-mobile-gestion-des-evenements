import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { DomSanitizer } from '@angular/platform-browser';
import { ActivatedRoute, Router } from '@angular/router';
import { CrudserviceeventService } from 'src/app/crudserviceevent.service';
import { Event }from 'src/app/event';


@Component({
  selector: 'app-editevent',
  templateUrl: './editevent.component.html',
  styleUrls: ['./editevent.component.css']
})
export class EditeventComponent  implements OnInit{

eventToUpdate=new Event();
url:any;
imgURL:any
userFile:any;
public imagePath :any;
public _eventlist: Array<Event>=[];
 
formIsValid = false;

  constructor(private router:Router,private service:CrudserviceeventService
    ,private activateRouter:ActivatedRoute,private sanit:DomSanitizer,private http: HttpClient
    ){}
  ngOnInit(){
    let id = null;
const idParam = this.activateRouter.snapshot.paramMap.get('id');
if (idParam !== null) {
  id = parseInt(idParam);


this.service.fetcheventbyIdFromRemote(id).subscribe(
  (data:Event)=>{
    console.log("Data feteched successfully");
    this.eventToUpdate=data;}
    ,
    error=>console.log("error")
)}
}
get_eventlist() {
  this.service.fetchEventListFromRemote().subscribe(
    data=>this._eventlist=data,
    error=> console.log("error"),
  )
  }

  prepareFormData(eventToUpdate:Event):FormData{
    const formData= new FormData();
    formData.append('event',JSON.stringify(eventToUpdate));
   
    formData.append('file',this.userFile);
  
    if(eventToUpdate && eventToUpdate.filenameimg) {
      formData.append('file', eventToUpdate.filenameimg);}
    return formData;
  }
  



onFileSelected(item :any) {
  if(item.target.files.length  > 0){

    const file=item.target.files[0];
    this.userFile=file;
    var reader =new FileReader();
    this.imagePath=file
reader.readAsDataURL(file)
reader.onload=(item) =>{
  this.imgURL=reader.result;
  this.eventToUpdate.filenameimg = file.name;
    }
 

  
  }
  }


   //event de typeformDta c'est a dire event +image
 

 updateeventfromsubmit() {
  if (this.registerForm.valid) {
    //valider le formulaire 
    this.formIsValid = true;
  const eventFormData = this.prepareFormData(this.eventToUpdate);
  this.service.addEventToRemote(eventFormData).subscribe(
    data => { 
      alert("event updated successfully");
      this.router.navigate(['/admin/list']);
    },
    error => {
      console.log("error:", error.error);
    }
  );

}}

  gotolist(){
    console.log("go back")
    this.router.navigate(['/admin/list']);}


    
registerForm= new FormGroup({
  name:new FormControl('',[
    Validators.required,Validators.minLength(2),
  ]),
 lieu:new FormControl('',[ Validators.required,Validators.minLength(1), Validators.pattern('[a-zA-Z].*'),
  ]),
  city: new FormControl('', [ Validators.required ,Validators.minLength(3),Validators.pattern('[a-zA-Z]*'),]),
  
  stoke: new FormControl('', [ Validators.required ,Validators.pattern('[0-9]*'),]),

 desp : new FormControl('', [ Validators.required ,Validators.minLength(3),Validators.pattern('[a-zA-Z].*'),]),

 organizateur: new FormControl('', [ Validators.required ,Validators.minLength(3),Validators.pattern('[a-zA-Z]*'),]),
 priceForStudent: new FormControl('', [ Validators.required,]),
 priceForNoStudent : new FormControl('', [ Validators.required ,]),
 date:new FormControl('',[
  Validators.required
]),

 } )

get Name():FormControl{
  return this.registerForm.get("name") as FormControl;           }
  get Place():FormControl{
    return this.registerForm.get("lieu") as FormControl;           }

    get City():FormControl{
    return this.registerForm.get("city") as FormControl;           }
    get Stoke():FormControl{
      return this.registerForm.get("stoke") as FormControl;           }
      get Description():FormControl{
        return this.registerForm.get("desp") as FormControl;           }

        get Organizer():FormControl{
          return this.registerForm.get("organizateur") as FormControl;           }

          get Prixforstudent():FormControl{
            return this.registerForm.get("priceForStudent") as FormControl;           }
            get Prixfornostudent():FormControl{
              return this.registerForm.get("priceForNoStudent") as FormControl;           }

}
