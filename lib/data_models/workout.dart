import 'package:inshape/utils/parser.dart';

class Workout {
  String id;
  String name;
  String type;
  String description;
  List<String> targetMuscles;
  String videoUrl;
  String thumbnailUrl;
  List<Reps> reps;

  Workout(
      {this.id,
      this.name,
      this.type,
      this.description,
      this.targetMuscles,
      this.videoUrl,
      this.thumbnailUrl,
      this.reps});

  factory Workout.fromJSON(var map) {
    return Workout(
        id: map['_id'],
        name: map['name'],
        type: map['type'],
        description: map['description'],
        targetMuscles: DataParser.parseStringList(map['targetMuscles']),
        videoUrl: map['videoUrl'],
        thumbnailUrl: map['thumbnailUrl'],
        reps: Reps.fromJSONList(map['reps']));
  }



  static List<Workout> fromJSONList(var jsonList) {
    List<Workout> list = [];
    for (var c in jsonList) {
      list.add(Workout.fromJSON(c));
    }
    return list;
  }
}

class Reps {
  String goal;
  String value;

  Reps({this.goal, this.value});

  factory Reps.fromJSON(var map) {
    return Reps(
      goal: map['goal'],
      value: map['value'],
    );
  }

  static List<Reps> fromJSONList(var jsonList) {
    List<Reps> list = [];
    for (var c in jsonList) {
      list.add(Reps.fromJSON(c));
    }
    return list;
  }
}
