class RequestData {
  String? id;
  String name, fromEmail, telephoneNo, messageText;
  String toEmail;
  DateTime requestTime;
  int postId;

  RequestData(
      this.postId, this.id, this.name, this.fromEmail, this.telephoneNo, this.messageText, this.toEmail, this.requestTime);

  RequestData.empty()
      : postId = 0,
        fromEmail = '',
        messageText = '',
        telephoneNo = '',
        name = '',
        requestTime = DateTime.now(),
        toEmail = '';

  Map toJson() => {
        'name': name,
        'fromEmail': fromEmail,
        'telephoneNo': telephoneNo,
        'messageText': messageText,
        'toEmail': toEmail,
        'requestTime': requestTime.toString(),
        'postId': postId,
      };

  @override
  String toString() {
    return 'RequestData{id: $id, name: $name, fromEmail: $fromEmail, telephoneNo: $telephoneNo, message: $messageText, toEmail: $toEmail, requestTime: $requestTime, postId: $postId}';
  }
}
