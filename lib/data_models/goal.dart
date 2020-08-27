class Goal {
  String id;
  String name;
  String imageUrl;
  String thumbnailUrl;

  Goal({this.id, this.name, this.imageUrl, this.thumbnailUrl});

  factory Goal.fromJSON(var map) {
    return Goal(
      id: map["_id"],
      name: map["name"],
      imageUrl: map["imageUrl"],
      thumbnailUrl: map["thumbnailUrl"],
    );
  }

  static Map<String, Goal> getGoalsMapFromJSON(var goalsArray) {
//    final goalsArray = json.decode(response)['payload']["goals"];
    Map<String, Goal> goalsMap = Map();
    for (var goal in goalsArray) {
      final g = Goal.fromJSON(goal);
      goalsMap[g.id] = g;
    }
    return goalsMap;
  }
}
