public class TicketTriggerHandler extends TriggerHandler {
  public override void afterInsert() {
    updateTotalEstimatedDaysOnEpic();
  }
    
  public override void afterUpdate() {
    updateTotalEstimatedDaysOnEpic();
  }
  
  public override void beforeInsert() {
    List<Ticket__c> newTickets = (List<Ticket__c>) Trigger.new;
    preventClosing(newTickets, null);
  }

  public override void beforeUpdate() {
    List<Ticket__c> newTickets = (List<Ticket__c>) Trigger.new;
    Map<Id, Ticket__c> oldTickects = (Map<Id, Ticket__c>) Trigger.oldMap;
    preventClosing(newTickets, oldTickects);
  }
  
  private void updateTotalEstimatedDaysonEpic() {
    List<Ticket__c> newTickets = (List<Ticket__c>) Trigger.new;
    Map<Id, Decimal> newWorkDaysByEpic = new Map<Id, Decimal>();
    for (Ticket__c ticket : newTickets) {
      newWorkDaysByEpic.put(ticket.Epic__c, ticket.Estimated_Days_of_Work__c);
    }
      
    List<Epic__c> epics = [
        SELECT Id, Total_Estimated_Days_of_Work__c
        FROM Epic__c
        WHERE ID = :newWorkDaysByEpic.keySet()
    ];
    for (Epic__c epic : epics) {
      epic.Total_Estimated_Days_of_Work__c += newWorkDaysByEpic.get(epic.Id);
    }
      
    update epics;
  }

  private void preventClosing(List<Ticket__c> newTickets, Map<Id, Ticket__c> beforeTickets) {
    List<Ticket__c> ticketsToUpdate = new List<Ticket__c>();
    for (Ticket__c ticket : newTickets) {
      if (ticket.Status__c == 'DONE' && ticket.End_Date__c == null) {
        String previousStatus = 'NEW';
        if (beforeTickets != null) {
          previousStatus = beforeTickets.get(ticket.Id).Status__c;
        }
        ticket.Status__c = previousStatus;
        ticketsToUpdate.add(ticket);
      }
    }
    update ticketsToUpdate;
  }
}