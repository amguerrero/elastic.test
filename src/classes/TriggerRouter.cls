/**
 * @class: TriggerRouter
 * @description: routes the trigger events to the proper methods
 **/
public class TriggerRouter {
  /**
  * @method: handler
  * @params:
  *      1) handler (TriggerInterface): handler contains trigger event logic
  * @return: N/A
  * @description: handles the routing of trigger events
  **/
  public static void handler(TriggerInterface handler) {
    if (handler.isActive()) {
      switch on Trigger.OperationType  {
        when BEFORE_INSERT {
          handler.beforeInsert();
        }

        when BEFORE_UPDATE {
          handler.beforeUpdate();
        }

        when BEFORE_DELETE {
          handler.beforeDelete();
        }

        when AFTER_INSERT {
          handler.afterInsert();
        }

        when AFTER_UPDATE {
          handler.afterUpdate();
        }

        when AFTER_DELETE {
          handler.afterDelete();
        }

        when AFTER_UNDELETE {
          handler.afterUndelete();
        }
      }
    }
  }
}