class RegenerationType {
  String id;
  String name;

  RegenerationType({this.id, this.name});

  factory RegenerationType.fromJSON(var map) {
    return RegenerationType(
      id: map['_id'],
      name: map['name'],
    );
  }

  static Map<String, RegenerationType> fromJSONList(var regJSON) {
    Map<String, RegenerationType> regMap = Map();
//    final quotesJSON = json.decode(response)["payload"]["quotes"];
    for (var c in regJSON) {
      final q = RegenerationType.fromJSON(c);
      regMap[q.id] = q;
    }
    return regMap;
  }
}