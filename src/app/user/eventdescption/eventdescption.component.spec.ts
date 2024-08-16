import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EventdescptionComponent } from './eventdescption.component';

describe('EventdescptionComponent', () => {
  let component: EventdescptionComponent;
  let fixture: ComponentFixture<EventdescptionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ EventdescptionComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(EventdescptionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
