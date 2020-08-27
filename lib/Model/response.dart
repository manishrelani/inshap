class RegResponse {
  String error;
  String message;
  String code;

  RegResponse(this.error, this.message, this.code);

  RegResponse.fromJson(Map<String, dynamic> json) {
    this.error = '${json['error']}';
    this.message = json['message'];
    this.code = json['code'];
  }
}
