class LoginRes {
  String error;
  String message;
  String code;
  var goals = [];
  var quotes = [];
  var dietPlans = []; 
  var muscleTypes = [];
  var workoutTypes = [];
  Map<String, dynamic> profile;

//  String profile;
  LoginRes(this.error, this.message, this.code, this.goals, this.quotes,
      this.profile, this.muscleTypes, this.workoutTypes, this.dietPlans);

  LoginRes.fromJson(Map<String, dynamic> json) {
    this.error = '${json['error']}';
    this.message = json['message'];
    this.code = json['code'];
    this.goals = json['payload']['goals'];
    this.quotes = json['payload']['quotes'];
    this.dietPlans = json['payload']['dietPlans'];
    this.muscleTypes = json['payload']['muscleTypes'];
    this.workoutTypes = json['payload']['workoutTypes'];
    this.profile = json['payload']['profile'];
  }
}
