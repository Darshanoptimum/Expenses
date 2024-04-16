import { Component, ElementRef, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ApiService } from '../api.service';
import { Expense } from '../expense';
import { ActivatedRoute, Router } from '@angular/router';
import { SignupComponent } from '../signup/signup.component';

@Component({
  selector: 'app-add-expences',
  templateUrl: './add-expences.component.html',
  styleUrls: ['./add-expences.component.css']
})
export class AddExpencesComponent implements OnInit {
  myForm!: FormGroup;

  constructor(private fb: FormBuilder,private apiService: ApiService,private elementRef:ElementRef,private route:ActivatedRoute,private router:Router){}
  expenses?:Expense[];
  expense = new Expense();
  data: any;

  ngOnInit() {
    if(!this.apiService.loginflag){
      this.router.navigate(["/login"])
    }
    this.myForm = this.fb.group({
      ExpensesType: ['', Validators.required],
      ExpensesAmount: ['', [Validators.required,Validators.pattern("^[0-9]*$")]],
    });
    

  }
  onSubmit(form: FormGroup) {
    console.log('Valid?', form.valid); // true or false
    console.log('ExpensesType', form.value.ExpensesType);
    console.log('ExpensesAmount', form.value.ExpensesAmount);
    this.route.queryParams.subscribe(params => {
      this.expense.User_Id=params['Id'];
    })
    this.expense.Ex_Type=form.value.ExpensesType;
    this.expense.Amount=form.value.ExpensesAmount;

    this.apiService.addPerson(this.expense,"https://localhost:44358/api/insertExpense")
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
