public without sharing class {{ api_name }} implements [INTERFACE_CLASS] {
  ////////////////////////
  // Instance Variables //
  ////////////////////////
  
  /**
   *   Method used to bulkify all data needed in any "before" action of a trigger.
   */
  public void bulkBefore() {
  
  }
  
  /**
   *   Method used to bulkify all data needed in any "after" action of a trigger.
   */
  public void bulkAfter() {
  
  }
  
  /**
   *   All before insert logic should be done here. This method is called iteratively and as such
   *   should contain no actions which could potentially hit limits or is considered bad practice 
   *   in the Salesforce environment.
   *   
   *   @param  {SObject}   so Single SObject representation of the object being acted upon.
   */
  public void beforeInsert(SObject so) {
  
  }
  
  /**
   *   All before update logic should be done here. This method is called iteratively and as such
   *   should contain no actions which could potentially hit limits or is considered bad practice
   *   in the Salesforce environment.
   *
   *   @param  {SObject}   oldSo Single SObject representation of the "old" copy of the current 
   *                             object being acted upon.
   *   @param  {SObject}   so    Single SObject representation of the object being acted upon.
   */
  public void beforeUpdate(SObject oldSo, SObject so) {
  
  }
  
  /**
   *   All before delete logic should be done here. This method is called iteratively and as such
   *   should contain no actions which could potentilly hit limits or is considered bad practice
   *   in the Salesforce environment.
   *
   *   @param  {SObject}   so Single SObject representation of the object being acted upon.
   */
  public void beforeDelete(SObject so) {
  
  }
  
  /**
   *   All after insert logic should be done here. This method is called iteratively and as such
   *   should contain no actions which could potentilly hit limits or is considered bad practice
   *   in the Salesforce environment. 
   *
   *   @param  {SObject}   so Single SObject representation of the object being acted upon.
   */
  public void afterInsert(SObject so) {
  
  }
  
  /**
   *   All after update logic should be done here. This method is called iteratively and as such
   *   should contain no actions which could potentilly hit limits or is considered bad practice
   *   in the Salesforce environment.
   *   
   *   @param  {SObject}   oldSo Single SObject representation of the "old" copy of the current 
   *                             object being acted upon.
   *   @param  {SObject}   so    Single SObject representation of the object being acted upon.
   */
  public void afterUpdate(SObject oldSo, SObject so) {
  
  }
  
  /**
   *   All after delete logic should be done here. This method is called iteratively and as such
   *   should contain no actions which could potentilly hit limits or is considered bad practice
   *   in the Salesforce environment. 
   *
   *   @param  {SObject}   so Single SObject representation of the object being acted upon.
   */
  public void afterDelete(SObject so) {
  
  }
  
  /**
   *   All final logic should be done at this point such as modification to objects outside of
   *   the current object. At this point all updates to the current trigger transaction should be
   *   complete and all validation done.
   */
  public void andFinally() {
  
  }
  
  //////////////////////////
  // CUSTOM METHODS BELOW //
  //////////////////////////
  
}
