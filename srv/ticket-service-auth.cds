using {
  TicketService.Protocol,
  TicketService.Tickets,
  TicketService.closeTicket
} from './ticket-service';

annotate Protocol with @readonly; // alternatively: @insertonly
annotate Tickets with @readonly;
annotate closeTicket with @(requires: 'authenticated-user');


annotate Tickets with @(restrict: [
  {
    grant: ['DELETE'],
    to   : 'admin',
    where: `state_ID = 5`
  },
  {
    grant: [
      'READ',
      'CREATE',
      'UPDATE'
    ],
    to   : 'admin'
  }
]);
