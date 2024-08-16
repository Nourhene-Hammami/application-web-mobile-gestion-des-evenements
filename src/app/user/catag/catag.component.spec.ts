import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CatagComponent } from './catag.component';

describe('CatagComponent', () => {
  let component: CatagComponent;
  let fixture: ComponentFixture<CatagComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CatagComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CatagComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
