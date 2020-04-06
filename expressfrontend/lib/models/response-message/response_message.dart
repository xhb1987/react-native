class ResponseMessage {
  int statusCode;
  String message;
  String data;

  ResponseMessage({this.statusCode, this.message, this.data});

  factory ResponseMessage.fromJSON(Map<String, dynamic> json) =>
      ResponseMessage(
          statusCode: json['statusCode'] as int,
          message: json['message'] as String,
          data: json['data'] as String);
}
