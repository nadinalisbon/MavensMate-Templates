trigger {{ api_name }} on {{ object_name }} (before insert, before update, before delete, 
                                              after insert,  after update,  after delete) {
  // Execute the createAndExecuteHandler method of the ITriggerFactory class
  // and send the [{{ object_name }}]TriggerHandler.class as a parameter
  // ITriggerFactory.createAndExecuteHandler([{{ object_name }}]TriggerHandler.class);
}
