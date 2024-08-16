import { TestBed } from '@angular/core/testing';

import { CrudserviceeventService } from './crudserviceevent.service';

describe('CrudserviceeventService', () => {
  let service: CrudserviceeventService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(CrudserviceeventService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
