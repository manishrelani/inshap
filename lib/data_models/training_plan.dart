import 'dart:convert';

class TrainingPlan {
  String id;
  String name;
  String gender;
  int trainingPeriod;
  String goal;

  // day, List<Plan>
  Map<int, List<Plan>> plans;

  TrainingPlan(
      {this.id,
      this.name,
      this.gender,
      this.trainingPeriod,
      this.goal,
      this.plans});

  factory TrainingPlan.fromJSON(var map) {
    //print(map);
    return TrainingPlan(
      id: map['_id'],
      name: map['name'],
      gender: map['gender'],
      trainingPeriod: map['trainingPeriod'],
      goal: map['goal'],
      plans: Plan.dayWiseMapOfPlans(map['plan'], map['trainingPeriod']),
    );
  }

  static Map<String, TrainingPlan> parseJSONAsMap(String response) {
    final jsonList = json.decode(response)['payload']['plans'];
    final List<TrainingPlan> plans = fromJSONList(jsonList);
    Map<String, TrainingPlan> plansMap = Map();
    for (var plan in plans) {
      plansMap[plan.id] = plan;
    }
    return plansMap;
  }

  static List<TrainingPlan> fromJSONList(var jsonList) {
    List<TrainingPlan> plans = [];
    for (var c in jsonList) {
      plans.add(TrainingPlan.fromJSON(c));
    }
    return plans;
  }

  @override
  String toString() {
    return 'TrainingPlan{id: $id, name: $name, gender: $gender, trainingPeriod: $trainingPeriod, goal: $goal, plans: $plans}';
  }
}

class Plan {
  int day;
  String name;
  List<WorkoutId> workouts;
  String thumbnailUrl;

  Plan({this.day, this.name, this.workouts, this.thumbnailUrl});

  factory Plan.fromJSON(var map) {
    return Plan(
      name: map['name'],
      day: map['day'],
      workouts: WorkoutId.fromJSONList(map["workouts"]),
      thumbnailUrl: map["thumbnailUrl"],
    );
  }

  static Map<int, List<Plan>> dayWiseMapOfPlans(
      List jsonList, int trainingPeriod) {
    Map<int, List<Plan>> plansMap = Map();
    List<Plan> plansList = fromJSONList(jsonList);
    for (int i = 1; i <= trainingPeriod; i++) {
      plansMap[i] = plansList.where((element) => element.day == i).toList();
    }
    return plansMap;
  }

  static List<Plan> fromJSONList(List jsonList) {
    List<Plan> list = [];
    for (var c in jsonList) {
      list.add(Plan.fromJSON(c));
    }
    return list;
  }

  @override
  String toString() {
    return 'Plan{day: $day, name: $name, workouts: $workouts, thumbnailUrl: $thumbnailUrl}';
  }
}

class WorkoutId {
  String workoutId;

  WorkoutId({this.workoutId});

  factory WorkoutId.fromJSON(var map) {
    return WorkoutId(
      workoutId: map['workoutId'],
    );
  }

  static List<WorkoutId> fromJSONList(var jsonList) {
    List<WorkoutId> list = [];

    for (var c in jsonList) {
      list.add(WorkoutId.fromJSON(c));
    }
    return list;
  }

  @override
  String toString() {
    return 'WorkoutId{workoutId: $workoutId}';
  }
}
