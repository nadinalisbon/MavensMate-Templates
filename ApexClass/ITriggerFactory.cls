/**
 * Class TriggerFactory
 *
 * Used to instantiate and execute Trigger Handlers associated with sObjects.
 */
global with sharing class TriggerFactory {
    /**
     * Public static method to create and execute a trigger handler
     *
     * Arguments:   Type t - Type of handler to instatiate
     *
     * Throws a TriggerException if no handler has been found.
     */
    global static void createAndExecuteHandler(Type t) {
        //Don't allow null Types
        if (t == null) {
            throw new TriggerException('Why are you trying to hand me a null Type/Class, dingbat?');
        }
        
        // Get a handler appropriate to the object being processed
        ITrigger handler = getHandler(t);
        String className = t.getName();
        String hashName = String.valueof(t.hashCode());
         
        // Make sure we have a handler registered, new handlers must be registered in the getHandler method.
        if (handler == null) {
            throw new TriggerException('No Trigger Handler found named: ' + className);
        }
         
        // Get the custom setting for the handler, if it exists
        Trigger_Handler_Settings__c triggerHandlerSetting = Trigger_Handler_Settings__c.getValues(hashName);
                
        // If a custom setting for the handler does not exist, create a custom setting and assign the handler name as the custom setting name and assign the Object name (if not null)
        if(triggerHandlerSetting == null){          
            String objectType = null;
            if(trigger.new != null && trigger.new.size() > 0){
                objectType = trigger.new[0].getSObjectType().getDescribe().getLabel();
            } else if(trigger.old != null && trigger.old.size() > 0){
                objectType = trigger.old[0].getSObjectType().getDescribe().getLabel();
            }
            
            triggerHandlerSetting = new Trigger_Handler_Settings__c(
                Name = hashName, // use hash code value for unique name for custom setting
                Class_Name__c = className,
                Object__c = objectType, //objectType could potentially be null :(
                Active__c = true
            );
            
            insert triggerHandlerSetting;
        }
        
        
        // Execute the handler to fulfill the trigger (only if the handler is enabled in the trigger settings)
        if(triggerHandlerSetting.Active__c){      
            execute(handler);
        }
    }
 
    /**
     * private static method to control the execution of the handler
     *
     * Arguments:   ITrigger handler - A Trigger Handler to execute
     */
    private static void execute(ITrigger handler) {
        // Before Trigger
        if (Trigger.isBefore) {
            // Call the bulk before to handle any caching of data and enable bulkification
            handler.bulkBefore();
 
            // Iterate through the records to be deleted passing them to the handler.
            if (Trigger.isDelete) {
                for (Integer i=0; i< Trigger.old.size(); i++){
                    SObject so= Trigger.old.get(i);
                    handler.beforeDelete(so);
                }
            }
            // Iterate through the records to be inserted passing them to the handler.
            else if (Trigger.isInsert) {
                for (Integer i=0; i< Trigger.new.size(); i++) {
                    SObject so= Trigger.new.get(i);
                    handler.beforeInsert(so);
                }
            }
            // Iterate through the records to be updated passing them to the handler.
            else if (Trigger.isUpdate) {
                for (Integer i=0; i< Trigger.old.size(); i++) {
                    SObject so= Trigger.old.get(i);

                    handler.beforeUpdate(so, Trigger.newMap.get(so.Id));
                }
            }
            
            handler.andFinallyBefore();
            
        } else {
            // Call the bulk after to handle any caching of data and enable bulkification
            handler.bulkAfter();
 
            // Iterate through the records deleted passing them to the handler.
            if (Trigger.isDelete) {
                for (Integer i=0; i< Trigger.old.size(); i++) {
                    SObject so= Trigger.old.get(i);
                    handler.afterDelete(so);
                }
            }
            // Iterate through the records inserted passing them to the handler.
            else if (Trigger.isInsert) {
                for (Integer i=0; i< Trigger.new.size(); i++) {
                    SObject so= Trigger.new.get(i);
                    handler.afterInsert(so);
                }
            }
            // Iterate through the records updated passing them to the handler.
            else if (Trigger.isUpdate) {
                for (Integer i=0; i< Trigger.old.size(); i++) {
                    SObject so= Trigger.old.get(i);
                    handler.afterUpdate(so, Trigger.newMap.get(so.Id));
                }
            }
            else if (Trigger.isUndelete){
                for (Integer i=0; i< Trigger.new.size(); i++){
                    SObject so= Trigger.new.get(i);
                    handler.afterUndelete(so);
                }
            }
            handler.andFinallyAfter();
        }

    }
 
    /**
     * private static method to get the named handler.
     *
     * Arguments:   Type t - Class of handler to instatiate
     *
     * Returns:     ITrigger - A trigger handler if one exists or null.
     */
    private static ITrigger getHandler(Type t) {
        // Instantiate the type
        Object o = t.newInstance();
 
        // if its not an instance of ITrigger return null
        if (!(o instanceOf ITrigger)) {
            return null;
        }
 
        return (ITrigger)o;
    }
 
    public class TriggerException extends Exception {}
}
