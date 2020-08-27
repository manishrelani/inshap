import 'package:inshape/utils/parser.dart';

class Profile {
  String fullName;
  String email;
  String gender;
  int age, height, weight, bodyFrame, workoutFrequency, expertiseLevel;
  String goal;
  List<String> workoutTypes;
  List<String> muscleTypes;
  List<String> gallery;
  var dietPlan; 
  String avtarUrl;

  Profile({
    this.fullName,
    this.email,
    this.gender,
    this.age,
    this.height,
    this.weight,
    this.bodyFrame,
    this.workoutFrequency,
    this.expertiseLevel,
    this.goal,
    this.workoutTypes,
    this.muscleTypes,
    this.dietPlan,
    this.avtarUrl,
    this.gallery,
  });

  factory Profile.fromJSON(var map) {
    if (map == null) {
      return Profile();
    }
    // print(map);
    return Profile(
      fullName: map['fullName'],
      email: map['email'],
      gender: map['gender'],
      age: map['age'],
      height: map['height'],
      weight: map['weight'],
      bodyFrame: map['bodyFrame'],
      workoutFrequency: map['workoutFrequency'],
      expertiseLevel: map['expertiseLevel'],
      goal: map['goal'],
      workoutTypes: DataParser.parseStringList(map['workoutTypes']),
      muscleTypes: DataParser.parseStringList(map['muscleTypes']),
      dietPlan: map['dietPlan'],
      avtarUrl: map['avatarUrl'],
      gallery: DataParser.parseStringList(map['gallery']),
    );
  }

  static Profile getFromJSON(var response) {
    return Profile.fromJSON(response);
  }

  @override
  String toString() {
    return 'Profile{fullName: $fullName, email: $email, gender: $gender, age: $age, height: $height, weight: $weight, bodyFrame: $bodyFrame, workoutFrequency: $workoutFrequency, expertiseLevel: $expertiseLevel, goal: $goal, workoutTypes: $workoutTypes, muscleTypes: $muscleTypes, dietPlan: $dietPlan, avtarUrl: $avtarUrl, gallery: $gallery}';
  }
}
