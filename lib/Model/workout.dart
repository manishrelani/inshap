class WorkOut{
  String error;
  String message;
  String code;
  var workout;

  WorkOut(this.error, this.message, this.code,this.workout);
  WorkOut.fromJson(Map<String, dynamic> json) {
    this.error = '${json['error']}';
    this.message = json['message'];
    this.code = json['code'];
    this.workout=json['payload']['workoutTypes'];
  }
}