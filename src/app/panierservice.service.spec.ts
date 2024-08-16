import { TestBed } from '@angular/core/testing';

import { PanierserviceService } from './panierservice.service';

describe('PanierserviceService', () => {
  let service: PanierserviceService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(PanierserviceService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
