class Notes{
  String error;
  String message;
  String code;
  var notes;

  Notes(this.error, this.message, this.code,this.notes);
  Notes.fromJson(Map<String, dynamic> json) {
    this.error = '${json['error']}';
    this.message = json['message'];
    this.code = json['code'];
    this.notes=json['payload']['notes']; 
  }
}