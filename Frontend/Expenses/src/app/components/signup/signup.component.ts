import { Component, ElementRef, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { User } from '../user';
import { ApiService } from '../api.service';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
  styleUrls: ['./signup.component.css']
})
export class SignupComponent implements OnInit {

  mail?:String;


  showFirst:boolean=true;
  
  
  toggleSections(){
    this.showFirst=!this.showFirst;
  }

  myForm!: FormGroup;
  myForm1!: any;
  constructor(private fb: FormBuilder,private apiService: ApiService,private elementRef:ElementRef,private router:Router) { }
  
  ngOnInit() {
    this.myForm = this.fb.group({
      name: ['', Validators.required],
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(8)]],
      mobile: ['', Validators.required],
      address: ['', Validators.required],
    });
    this.myForm1 = this.fb.group({
      LoginName: ['', Validators.required],
      LoginEmail: ['', [Validators.required, Validators.email]],
      LoginPassword: ['', [Validators.required, Validators.minLength(8)]],
    });

    

  }

  onSubmit1(form: FormGroup) {
    console.log('Valid?', form.valid); // true or false
    console.log('LoginName', form.value.LoginName);
    console.log('LoginEmail', form.value.LoginEmail);
    console.log('LoginPassword', form.value.LoginPassword);
      
    this.user.Name=form.value.LoginName;
    this.user.Email=form.value.LoginEmail;
    this.user.Password=form.value.LoginPassword;
    
    this.apiService.addPerson(this.user,"https://localhost:44358/api/UserLogin")
    .subscribe(
      data => {
        console.log(data.Message);
        var d1 = this.elementRef.nativeElement.querySelector('#Message');
        d1.innerHTML="";
        d1.insertAdjacentHTML('beforeend', '<div class="two"><b>'+data.Message+'</b></div>');
        if(data.Message=="Valid User"){
        this.router.navigate(["/addexpense"],{queryParams:{Id:data.ID}})
          this.apiService.emailString=data.ArrayOfResponse[0].Email;
          this.apiService.loginflag=true;
        }
        
      }, 
      error => {
        console.log(error);
      }); 
  }
  users?:User[];
  user = new User();
  data: any;
  onSubmit2(form: FormGroup) {
    console.log('Valid?', form.valid); // true or false
    console.log('name', form.value.name);
    console.log('email', form.value.email);
    console.log('password', form.value.password);
    console.log('mobile', form.value.mobile);
    console.log('address', form.value.address);

    this.user.Name=form.value.name;
    this.user.Email=form.value.email;
    this.user.Password=form.value.password;
    this.user.Mobile=form.value.mobile;
    this.user.Address=form.value.address;
    
    this.apiService.addPerson(this.user,"https://localhost:44358/api/UserRegister")
    .subscribe(
      data => {
        console.log(data.Message);
        var d1 = this.elementRef.nativeElement.querySelector('#errorMessage');
        d1.innerHTML="";
        d1.insertAdjacentHTML('beforeend', '<div class="two"><b>'+data.Message+'</b></div>');
      }, 
      error => {
        console.log(error);
      }); 
  }

  

  

  


  

}
