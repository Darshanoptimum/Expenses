import { HttpClient, HttpHeaders } from '@angular/common/http';
import {User} from './user'
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
 
@Injectable({providedIn:'root'})
export class ApiService {
 
  public emailString?:String;
  public loginflag:boolean=false;
  constructor(private http: HttpClient) {  }

  addPerson(user:any,URL:string): Observable<any> {
    const headers = { 'content-type': 'application/json'}  
    const body=JSON.stringify(user);
   
    return this.http.post(URL, body,{'headers':headers})
  }
 
} 