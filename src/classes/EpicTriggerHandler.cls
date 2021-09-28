public class EpicTriggerHandler extends TriggerHandler {

  public override void afterUpdate() {
    Epic__c afterEpic = (Epic__c) Trigger.new[0];
    Epic__c beforeEpic = (Epic__c) Trigger.old[0];
      
    List<Ticket__c> tickets = [
        SELECT Id, Title__c
        FROM Ticket__c
        WHERE Epic__c = :afterEpic.Id
    ];
    
    for (Ticket__c ticket : tickets) {
      updateTicketTitle(ticket, afterEpic, beforeEpic);
    }
  }

  private void updateTicketTitle(Ticket__c ticket, Epic__c afterEpic, Epic__c beforeEpic) {
    // If the title of the epic changes, we need to prepend the depending tickets' titles with the new epic title.
    if (afterEpic.Title__c != beforeEpic.Title__c) {
      ticket.Title__c = '[' + afterEpic.Title__c + '] ' + ticket.Title__c;
    }
    
    update ticket;
  }
}