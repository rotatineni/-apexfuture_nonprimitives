//Assuming you have 2 collections to pass to @future method: List<case> and Map<Id, List<case>>

list<Case> caseList     = new list<Case>();
map<Id, list<Id>> IdMap = new map<Id, list<Id>>();
//Notice that the map defined has another collection within. 

//Serialize your collections before sending them to @future method
myfuturemthod(JSON.serialize(caseList), JSON.serialize(IdMap));

@future
private static void myfuturemthod(String caseListJSON, String IdMapJSON){
  //deserialize your collections
    List<Case> caseList = (List<Case>)JSON.deserialize(caseListJSON, List<Case>.class);
    Map<Id, List<Id>> IdMap = (Map<Id, List<Id>>)JSON.deserialize(IdMapJSON, Map<Id, List<Id>>.class);

  //all your asynchronous logic......
}
