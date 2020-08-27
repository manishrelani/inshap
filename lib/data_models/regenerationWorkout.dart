class RegenerationWorkout {
  String id;
  String regType;
  String regName;
  String sortDescription;
  String description;
  String url;
  String imgUrl;
  String videoUrl;

  RegenerationWorkout(
      {this.id,
      this.regName,
      this.regType,
      this.description,
      this.imgUrl,
      this.sortDescription,
      this.url,
      this.videoUrl});

  factory RegenerationWorkout.fromJSON(var map) {
    return RegenerationWorkout(
      id: map['_id'],
      regName: map['regenerationName'],
      regType: map['regenerationType'],
      sortDescription: map['shortDesc'],
      description: map['desc'],
      url: map['url'],
      imgUrl: map['imageUrl'],
      videoUrl: map['vedioUrl'],
    );
  }

  static Map<String, RegenerationWorkout> fromJSONList(var regJSON) {
    Map<String, RegenerationWorkout> regMap = Map();
//    final quotesJSON = json.decode(response)["payload"]["quotes"];
    for (var c in regJSON) {
      final q = RegenerationWorkout.fromJSON(c);
      regMap[q.id] = q;
    }
    return regMap;
  }
}
