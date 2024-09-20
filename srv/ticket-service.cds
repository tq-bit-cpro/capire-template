using com.cpro.tickets as db from '../db/schema';

service TicketService @(path: '/tickets') {
  entity Tickets  as projection on db.Tickets;
  entity Protocol as projection on db.Protocol;


  action closeTicket(ticketId : db.Tickets:ID)                                        returns {
    ID : db.Tickets:ID;
    state : db.Tickets:state;
  };


  action createTicket(title : db.Tickets:title, description : db.Tickets:description) returns {
    ID : db.Tickets:ID;
  };
}
