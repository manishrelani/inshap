class UserProfileModel {
  String error;
  String message;
  String code;
  Map<String, dynamic> payload;


  UserProfileModel(
      this.message,
      this.error,
      this.code,
      this.payload

      );

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    this.error = '${json['error']}';
    this.message = json['message'];
    this.code = json['code'];
    this.payload=json['payload'];
  }
}
