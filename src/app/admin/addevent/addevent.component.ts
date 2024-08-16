import { isNgTemplate } from '@angular/compiler';
import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, NgForm, Validators } from '@angular/forms';
import { DomSanitizer } from '@angular/platform-browser';
import { Router } from '@angular/router';
import { CrudserviceeventService } from 'src/app/crudserviceevent.service';
import { Event }from 'src/app/event';

@Component({
  selector: 'app-addevent',
  templateUrl: './addevent.component.html',
  styleUrls: ['./addevent.component.css']
})
export class AddeventComponent implements OnInit{
  event =new Event();
  userFile: any;
  formIsValid = false;

imgURL:any

public imagePath :any;
public _eventlist: Array<Event>=[];

  
constructor(private router:Router,private service:CrudserviceeventService
    ,private sanit:DomSanitizer){}
  ngOnInit(): void {}
 
  addeventfromsubmit(){
    if (this.registerForm.valid) {
      //valider le formulaire 
      this.formIsValid = true;
//event de typeformDta c'est a dire event +image
const eventFormData =this.prepareFormData(this.event);

    this.service.addEventToRemote(eventFormData).subscribe(
data=>
{  
  console.log(data);
  alert("event added successuffly");
this.router.navigate(['/admin/list']);
},
error=>console.log("error") )
    }
  }




  gotolist(){
    console.log("go back")
    this.router.navigate(['/admin/list']);}



onFileSelected(item :any) {
  if(item.target.files.length  > 0){

    const file=item.target.files[0];
    this.userFile=file;
    var reader =new FileReader();
    this.imagePath=file
reader.readAsDataURL(file)
reader.onload=(item) =>{
  this.imgURL=reader.result;
  this.event.filenameimg = file.name;
    }}

}



prepareFormData(event:Event):FormData{
  const formData= new FormData();
  formData.append('event',JSON.stringify(event));
 
  formData.append('file',this.userFile);

  if(event && event.filenameimg) {
    formData.append('file', event.filenameimg);}
  return formData;
}





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