import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';


import { AppComponent } from './app.component';
import { NavComponent } from './components/nav/nav.component';
import { SignupComponent } from './components/signup/signup.component';
import { ReactiveFormsModule } from '@angular/forms';
import { AddExpencesComponent } from './components/add-expences/add-expences.component';

import { HttpClientModule, HttpClient } from '@angular/common/http';
import { AppRoutingModule } from './app-routing.module';
import { RouterModule, Routes } from '@angular/router';
import { GetExpensesComponent } from './components/get-expenses/get-expenses.component';
import { HomePageComponent } from './components/home-page/home-page.component';


const routes: Routes = [{
  path: "addexpense", component: AddExpencesComponent

},
{
  path: "login", component: SignupComponent
},
{
  path:"GetExpenses", component:GetExpensesComponent
},
{
  path:"home", component:HomePageComponent
}
]

@NgModule({
    declarations: [
    AppComponent,
    NavComponent,
    SignupComponent,
    AddExpencesComponent,
    GetExpensesComponent,
    HomePageComponent

  ],
  imports: [
    BrowserModule,
    ReactiveFormsModule, HttpClientModule, AppRoutingModule, RouterModule.forRoot(routes)
  ],
  providers: [SignupComponent],
  bootstrap: [AppComponent]
})
export class AppModule { }
