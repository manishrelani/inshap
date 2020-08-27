
class MuscleType {
  String id;
  String name;
  String thumbnailUrl;

  MuscleType({this.id, this.name, this.thumbnailUrl});

  factory MuscleType.fromJSON(var map) {
    return MuscleType(
      id: map["_id"],
      name: map["name"],
      thumbnailUrl: map["thumbnailUrl"],
    );
  }

  static Map<String, MuscleType> fromJSONList(var muscleTypeJSON) {
    Map<String, MuscleType> muscleTypesMap = Map();
//    final muscleTypeJSON = json.decode(response)["payload"]["muscleTypes"];
    for (var c in muscleTypeJSON) {
      final q = MuscleType.fromJSON(c);
      muscleTypesMap[q.id] = q;
    }
    return muscleTypesMap;
  }
}
