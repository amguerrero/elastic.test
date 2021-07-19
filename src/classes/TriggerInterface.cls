/**
 * @interface: TriggerInterface
 * @description: concrete implementations of this interface
 *               will be used to store business logic for a given trigger
 **/
public interface TriggerInterface {
  //before insert, what logic do you want to implement?
  void beforeInsert();

  //before update, what logic do you want to implement?
  void beforeUpdate();

  //before delete, what logic do you want to implement?
  void beforeDelete();

  //after insert, what logic do you want to implement?
  void afterInsert();

  //after update, what logic do you want to implement?
  void afterUpdate();

  //after delete, what logic do you want to implement?
  void afterDelete();

  //after undelete, what logic do you want to implement?
  void afterUndelete();

  //is it active?
  boolean isActive();
}