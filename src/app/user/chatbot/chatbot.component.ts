
import { v2 } from '@google-cloud/dialogflow';
//import { SessionsClient } from '@google-cloud/dialogflow';
import { SessionsClient } from '@google-cloud/dialogflow/build/src/v2';
import { Component, OnInit, Renderer2, ElementRef,ViewChild } from '@angular/core';
import { FormGroup,FormsModule,FormBuilder } from '@angular/forms';
import {Chatbox} from '../../chatbox';
import { Event }from 'src/app/event';
declare var jquery:any;
declare var $:any;
import { Observable } from 'rxjs';
import { PanierserviceService } from 'src/app/panierservice.service';
import { Router } from '@angular/router';
@Component({
  selector: 'app-chatbot',
  templateUrl: './chatbot.component.html',
  styleUrls: ['./chatbot.component.css']
})
export class ChatbotComponent  implements OnInit{
  event =new Event();


     // ngOnInit(): void {}
TextMsg!:FormGroup; 
chatModal=new Chatbox("Hello"); 
sendButton:boolean; 
bottext!:string; 


randomStuff:Array<string>=[
  "Hello Nice to here you",
  //"Hey Whatsupp",
"How can I help you",
//"I am your assitant","I am unable to get"
]; 
@ViewChild('chatlogs',{ read: ElementRef, static: false }) divMsgs!: ElementRef; 
@ViewChild('chatlogs',{ read: ElementRef, static: false }) botMsgs!: ElementRef; 
constructor(private formBuilder:FormBuilder,private renderer:Renderer2, public service2: PanierserviceService,private router:Router,){ 
  this.sendButton=true 
} 
ngOnInit(){ 
 // $(document).ready(function () {$('#ChatBot').modal('show'); });
/*
  $("#close").hover(
    function () {
       $("#chatdone").show(); // show 
      },
 function () { 
  $("#chatdone").hide(); //masquer 
 } 
 
); */} 

 title = 'ChatBotApp'; 

 Empty(){ 
  if(this.chatModal.inputQuery!=null){ 
         this.sendButton=true } 
        if(this.chatModal.inputQuery==null){ this.sendButton=false } 
      }


  onSubmit(){
     this.sendButton=false 
    if(this.chatModal.inputQuery==""){ 
      return false }
  else{ 
    console.log(this.chatModal.inputQuery) 
    //User Msgs 
  const divMain= this.renderer.createElement('div');
   const divSub= this.renderer.createElement('div'); 
  const text=this.renderer.createText(this.chatModal.inputQuery);
   this.renderer.appendChild(divSub,text); 
  this.renderer.addClass(divSub,"UserMsg"); 
  this.renderer.appendChild(divMain,divSub); 
  this.renderer.addClass(divMain,"d-flex");
   this.renderer.addClass(divMain,"flex-row-reverse"); 
  this.renderer.appendChild(this.divMsgs.nativeElement,divMain); //Bot Msgs
   let random=Math.floor(Math.random() * 5) + 0 
   const botMain= this.renderer.createElement('div'); 
   const botimg= this.renderer.createElement('div'); 
   this.renderer.addClass(botimg,"botimg"); 
   const botSub= this.renderer.createElement('div'); 


   if (this.chatModal.inputQuery.toLowerCase() === "how can i reserve an event?") {
    this.bottext = this.renderer.createText("To reserve an event, you can simply click on the Reserve button on the desired event page. You can then specify the quantity of seats you wish to reserve in the booking form.");
  } else if (this.chatModal.inputQuery.toLowerCase() === "how can i pay for my reservation?") {
    this.bottext = this.renderer.createText("To pay for your reservation, you can click on the Validation button after filling out the reservation form.");
  } else if (this.chatModal.inputQuery.toLowerCase()==="thank you") {
    this.bottext = this.renderer.createText("Welcome)");
  } else {
    this.bottext = this.renderer.createText(this.randomStuff[random]);
  }
   //Our input chat
         this.renderer.appendChild(botSub,botimg); 
         this.renderer.appendChild(botSub,this.bottext); 
         this.renderer.addClass(botSub,"botMsg"); 
         this.renderer.appendChild(botMain,botSub); 
 this.renderer.addClass(botMain,"d-flex"); 
 this.renderer.appendChild(this.divMsgs.nativeElement,botMain);
  var out = document.getElementById("chatlogs"); 
  if(out !=null){
  var isScrolledToBottom = out.scrollHeight - out.clientHeight <= out.scrollTop + 1; 
  console.log(isScrolledToBottom) 
  if(!isScrolledToBottom) out.scrollTop = out.scrollHeight - out.clientHeight; 
  //Audio click 
 /* let audio = new Audio(); 
  audio.src = "../../../assets/audio/tick.mp3"; 
  audio.load(); 
  audio.play();
   this.chatModal.inputQuery="" //Reseting to empty for next query 
 */
  } } 
return true}



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

}
 
