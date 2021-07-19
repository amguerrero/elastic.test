public class TicketTriggerHandler extends TriggerHandler {
  public override void beforeInsert() {
    List<Ticket__c> newTickets = (List<Ticket__c>) Trigger.new;
    preventClosing(newTickets, null);
  }

  public override void beforeUpdate() {
    List<Ticket__c> newTickets = (List<Ticket__c>) Trigger.new;
    Map<Id, Ticket__c> oldTickects = (Map<Id, Ticket__c>) Trigger.oldMap;
    preventClosing(newTickets, oldTickects);
  }

  private void preventClosing(List<Ticket__c> newTickets, Map<Id, Ticket__c> beforeTickets) {
    for (Ticket__c ticket : newTickets) {
      if (ticket.Status__c == 'DONE' && ticket.End_Date__c == null) {
        String previousStatus = 'NEW';
        if (beforeTickets != null) {
          previousStatus = beforeTickets.get(ticket.Id).Status__c;
        }
      }
    }
  }
}