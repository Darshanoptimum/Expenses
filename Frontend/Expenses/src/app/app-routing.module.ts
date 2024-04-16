import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Route, Routes } from '@angular/router';
import { AddExpencesComponent } from './components/add-expences/add-expences.component';
import { SignupComponent } from './components/signup/signup.component';

const routs : Routes = [
  {
    path:"addexpense",component:AddExpencesComponent
    
  },
  {
    path:"login",component:SignupComponent
    
  }
]

@NgModule({
  declarations: [],
  imports: [
    CommonModule
  ]
})
export class AppRoutingModule { }
