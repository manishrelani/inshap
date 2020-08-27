

class WorkoutType{
  String id;
  String name;

  WorkoutType({this.id, this.name});

  factory WorkoutType.fromJSON(var map){
    return WorkoutType(
      id: map["_id"],
      name: map["name"]
    );
  }

  static Map<String, WorkoutType> fromJSONList(var response) {
    Map<String, WorkoutType> workoutsJSON = Map();
//    final quotesJSON = json.decode(response)["payload"]["workoutTypes"];
    for (var c in response) {
      final q = WorkoutType.fromJSON(c);
      workoutsJSON[q.id] = q;
    }
    return workoutsJSON;
  }
}