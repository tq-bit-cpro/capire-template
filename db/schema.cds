namespace com.cpro.tickets;

using {
  cuid,
  managed,
  sap.common.CodeList
} from '@sap/cds/common';

entity Tickets : cuid, managed {
  title       : String(255)          @mandatory;
  description : String(1024)         @mandatory;
  state       : Association to State @mandatory;
  solvedAt    : Timestamp;
  closedAt    : Timestamp;
  protocol    : Association to many Protocol
                  on protocol.ticket = $self;
}

entity Protocol : cuid, managed {
  title       : String(255)  @mandatory;
  description : String(1024) @mandatory;
  ticket      : Association to Tickets  @mandatory  @assert.target;
}

// Extend a ticket with protocol entries
// extend Tickets with {
//   Protocol: Composition of many Protocol on Protocol.ticket = $self;
// }

// Extend Tickets with timestamps
aspect ManagedObject {
  createdAt  : Timestamp    @cds.on.insert: $now   @odata.etag;
  modifiedAt : Timestamp    @cds.on.insert: $now   @cds.on.update: $now  @odata.etag;
  createdBy  : String(100)  @cds.on.insert: $user;
  modifiedBy : String(100)  @cds.on.insert: $user  @cds.on.update: $user;
}

// Alternatively, 'managed' aspect can be used to create
// 'createdAt', 'createdBy', 'modifiedAt', 'modifiedBy'
// fields automatically

// Code lists are predefined key-value pairs that offer a comprehensive
// way to ensure input values are in a predefined set of values
// Node: Header = 'sap-locale={language}'
entity State : CodeList {
  key ID    : Integer;
      name  : localized String(255);
      descr : localized String(1000);
}
