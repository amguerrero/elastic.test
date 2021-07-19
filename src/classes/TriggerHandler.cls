/**
 * @description This is a Virtual Class which implements the 
 *              trigger interface and the ObjectTriggerHandler classes should
 *              extend this class and override the methods specified here.
 */
public virtual class TriggerHandler implements TriggerInterface {

  //before insert, what logic do you want to implement?
  public virtual void beforeInsert(){}

  //before update, what logic do you want to implement?
  public virtual void beforeUpdate(){}

  //before delete, what logic do you want to implement?
  public virtual void beforeDelete(){}

  //after insert, what logic do you want to implement?
  public virtual void afterInsert(){}

  //after update, what logic do you want to implement?
  public virtual void afterUpdate(){}

  //after delete, what logic do you want to implement?
  public virtual void afterDelete(){}

  //after undelete, what logic do you want to implement?
  public virtual void afterUndelete(){}

  //is it active?
  public virtual boolean isActive(){ return true;}
}