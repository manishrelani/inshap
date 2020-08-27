
class DietPlan {
  String id;
  String name;
  String imageUrl;

  DietPlan({this.id, this.name, this.imageUrl});

  factory DietPlan.fromJSON(var map) {
    return DietPlan(
      id: map["_id"],
      name: map["name"],
      imageUrl: map["imageUrl"],
    );
  }

  static Map<String, DietPlan> fromJSONList(var dietPlansJSON) {
    Map<String, DietPlan> dietsMap = Map();
//    final dietPlansJSON = json.decode(response)["payload"]["dietPlans"];
    for (var c in dietPlansJSON) {
      final q = DietPlan.fromJSON(c);
      dietsMap[q.id] = q;
    }
    return dietsMap;
  }
}
