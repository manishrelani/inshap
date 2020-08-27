class Training {
  String code;
  String error;
  String message;
  String name;
  String gender;
  String trainingGoal;
  Map<String, dynamic> playload;

  Training(this.gender, this.name, this.playload, this.trainingGoal, this.error,
      this.message, this.code);

  Training.fromJson(Map<String, dynamic> json) {
    this.error = '${json['error']}';
    this.message = json['message'];
    this.code = json['code'];
    this.trainingGoal = '${json['training']}';
    this.gender = json['gender'];
    this.name = json['name'];
    this.playload = json['playload'];
  }
}
