const cds = require("@sap/cds");

class TicketSerivce extends cds.ApplicationService {
  init() {
    const { Tickets } = this.entities;

    // Action /tickets/closeTicket
    // On how to implement queries, see
    // https://cap.cloud.sap/docs/node.js/core-services#rest-style-api
    this.on('closeTicket', async (req) => {
      const { ticketId } = req.data;
      await this.update(Tickets).with({ state_ID: 5 }).where({ ID: ticketId });

      // Alternatively, construct a query and run it
      // const query = UPDATE.entity(Tickets).where({ ID: ticketId }).set({ state_ID: 5 });
      // await cds.db.run(query)

      return { ticketId, Tickets }
    })

    this.after('READ', Tickets, (results) => {
      results.forEach(result => {
        // Change the result title whenever the service is read
        result.title = `${result.state_ID}: ${result.title.toUpperCase()}`
      })
    })

    return super.init();
  }
}

module.exports = TicketSerivce;