class Quotes{
  String error;
  String message;
  String code;
  var quotes;

  Quotes(this.error, this.message, this.code,this.quotes);
  Quotes.fromJson(Map<String, dynamic> json) {
    this.error = '${json['error']}';
    this.message = json['message'];
    this.code = json['code'];
    this.quotes=json['payload']['quotes'];
  }
}