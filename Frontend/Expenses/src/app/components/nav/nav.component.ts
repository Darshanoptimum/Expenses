import { Component, Input } from '@angular/core';
import { Router } from '@angular/router';
import { ApiService } from '../api.service';


@Component({
  selector: 'app-nav',
  templateUrl: './nav.component.html',
  styleUrls: ['./nav.component.css']
})
export class NavComponent {
  @Input() public isUserLoggedIn?: boolean;
  constructor(private apiService: ApiService,private router:Router) { }
  logout(){
    this.apiService.loginflag=false;
  }

}
