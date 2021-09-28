public class TicketEpicTriggerHandler extends TriggerHandler {
  public override void afterUpdate() {
    Map<Id, String> epicPriorityMap = new Map<Id, String>();
    for (SObject objTicket : Trigger.new) {
      Ticket__c ticket = (Ticket__c) objTicket;
      Ticket__c oldTicket = (Ticket__c) Trigger.oldMap.get(ticket.Id);
      if (ticket.Priority__c != oldTicket.Priority__c
          && comparePriority(ticket.Priority__c, oldTicket.Priority__c) < 0) {
        epicPriorityMap.put(ticket.Epic__c, ticket.Priority__c);
      }
    }
      
    List<Epic__c> epicCandidates = [
        SELECT Id, Max_Priority__c
        FROM Epic__c
        WHERE Id = :epicPriorityMap.keySet()
    ];
      
    List<Epic__c> epicsToUpdate = new List<Epic__c>();
    
    for (Epic__c epic : epicCandidates) {
      if (comparePriority(epic.Max_Priority__c, epicPriorityMap.get(epic.Id)) > 0) {
        epic.Max_Priority__c = epicPriorityMap.get(epic.Id);
        epicsToUpdate.add(epic);
      }
    }
    
    if (epicsToUpdate.size() > 0) {
      update epicsToUpdate;
    }
  }

  public override void afterInsert() {
    // Update Epic's max priority
    Map<Id, String> epicPriorityMap = new Map<Id, String>();
    for (SObject objTicket : Trigger.new) {
      Ticket__c ticket = (Ticket__c) objTicket;
      epicPriorityMap.put(ticket.Epic__c, ticket.Priority__c);
    }
      
    List<Epic__c> epicCandidates = [
        SELECT Id, Max_Priority__c
        FROM Epic__c
        WHERE Id = :epicPriorityMap.keySet()
    ];
      
    for (Epic__c epic : epicCandidates) {
      epic.Max_Priority__c = epicPriorityMap.get(epic.Id);
    }
    
    update epicCandidates;
  }
    
  /* Not relevant for the test
   * 
   * Returns -1 if priority1 is bigger than priority2
   * Returns 0 if both priorities are the same
   * Returns 1 if priority2 is bigger than priority1
   */
  private Integer comparePriority(String priority1, String priority2) {
    if (priority1 == priority2) {
      return 0;
    }
      
    if (priority1 == 'Sev 0') {
      return -1;
    }
      
    if (priority2 == 'Sev 0') {
      return 1;
    }
      
    if (priority1 == 'Sev 1') {
      return -1;
    }
      
    if (priority2 == 'Sev 1') {
      return 1;
    }
      
    if (priority1 == 'Sev 3') {
      return 1;
    }
      
    if (priority2 == 'Sev 3') {
      return -1;
    } else {
      return 1;
    }
  }
}