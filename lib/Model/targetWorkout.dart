class TargetWorkOut {
  String error;
  String message;
  String code;
  List workout;

  TargetWorkOut(this.error, this.message, this.code, this.workout);

  TargetWorkOut.fromJson(Map<String, dynamic> json) {
    this.error = '${json['error']}';
    this.message = json['message'];
    this.code = json['code'];
    this.workout = json['payload']['workouts'];
  }
}
