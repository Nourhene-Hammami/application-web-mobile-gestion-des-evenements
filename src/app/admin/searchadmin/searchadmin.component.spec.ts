import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SearchadminComponent } from './searchadmin.component';

describe('SearchadminComponent', () => {
  let component: SearchadminComponent;
  let fixture: ComponentFixture<SearchadminComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ SearchadminComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(SearchadminComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
