import { Component, ElementRef, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ApiService } from '../api.service';
import { ActivatedRoute, Router } from '@angular/router';
import { Expense } from '../expense';
import { SignupComponent } from '../signup/signup.component';

@Component({
  selector: 'app-get-expenses',
  templateUrl: './get-expenses.component.html',
  styleUrls: ['./get-expenses.component.css']
})
export class GetExpensesComponent implements OnInit {

  showFirst:boolean=false;
  showSecound:boolean=false;
 
  


  [x: string]: any;
  emailstring?: String;
  myForm!: FormGroup;
  i?: number;
  constructor(private fb: FormBuilder, private apiService: ApiService, private elementRef: ElementRef, private router:Router,private route: ActivatedRoute, private sign: SignupComponent) { }

  ngOnInit(): void {
    if(!this.apiService.loginflag){
      this.router.navigate(["/login"])
    }
    this.emailstring = this.sign.mail;
    
  }

  Email: string = "darshan0@gmail.com"
  expenses?: Expense[];
  expense = new Expense();
  dataModelMonth?: any;
  dataModel?: any;


  onSubmit() {

    this.expense.Email = this.apiService.emailString;

    this.apiService.addPerson(this.expense, "https://localhost:44358/api/GetExpense")
      .subscribe(
        data => {
          console.log(data);
          
          if (data) {
            this.dataModel = data.ArrayOfResponse;
            this.showFirst=false;
            this.showSecound=true;
          }
          // var d1 = this.elementRef.nativeElement.querySelector('#expensestable');
          // d1.innerHTML = "";
          // d1.insertAdjacentHTML('beforeend', '<thead><tr><th scope="col">Index</th><th scope="col">Date</th><th scope="col">Expenses Type</th><th scope="col">Expenses Amount</th><th scope="col">Balance</th></tr></thead><tbody><tr>');

          // this.i = 0;
          // if (data) {
          //   data.ArrayOfResponse.forEach((element: any, index: number) => {
          //     d1.insertAdjacentHTML('beforeend', '<th scope="row">' + (index + 1) + '</th><td>' + String(element.Date).slice(0, 10) + '</td><td>' + element.Ex_Type + '</td><td>' + element.Amount + '</td><td>' + element.Balance_Amount + '</td>');
          //   });
          //   d1.insertAdjacentHTML('beforeend', '</tr></tbody>');
          // }
        },
        error => {
          console.log(error);
        });
  }
  onSubmit1() {
    this.expense.Email = this.apiService.emailString;
    this.apiService.addPerson(this.expense, "https://localhost:44358/api/GetExpensesByMonth")
      .subscribe(
        data => {
          console.log(data);
          this.i = 0;
          if (data) {
            this.dataModelMonth = data.ArrayOfResponse;
            this.showFirst=true;
            this.showSecound=false;
          }

          // var d1 = this.elementRef.nativeElement.querySelector('#expensestable');
          // d1.innerHTML="";
          // d1.insertAdjacentHTML('beforeend', '<thead><tr><th scope="col">Index</th><th scope="col">Month</th><th scope="col">Total Credit</th><th scope="col">Total Debit</th><th scope="col">Total Balance</th></tr></thead><tbody><tr>');
          // data.ArrayOfResponse.forEach((element: any,index: number) => {
          //   d1.insertAdjacentHTML('beforeend', '<th scope="row">'+(index+1)+'</th><td>'+String(element.Month).slice(0,10)+'</td><td>'+element.TotalCredit+'</td><td>'+element.TotalDebit+'</td><td>'+element.Balance+'</td>');
          // });
          // d1.insertAdjacentHTML('beforeend', '</tr></tbody>');

        },
        error => {
          console.log(error);
        });
  }
}
