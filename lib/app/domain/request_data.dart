class RequestData {
  String? id;
  String name, fromEmail, telephoneNo, message;
  String toEmail;
  DateTime requestTime;
  int postId;

  RequestData(
      this.postId, this.id, this.name, this.fromEmail, this.telephoneNo, this.message, this.toEmail, this.requestTime);

  RequestData.empty()
      : postId = 0,
        fromEmail = '',
        message = '',
        telephoneNo = '',
        name = '',
        requestTime = DateTime.now(),
        toEmail = '';

  Map toJson() => {
        'name': name,
        'fromEmail': fromEmail,
        'telephoneNo': telephoneNo,
        'messageText': message,
        'toEmail': toEmail,
        'requestTime': requestTime.toString(),
        'postId': postId,
      };
}
