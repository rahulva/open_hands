class RequestData {
  String? id;
  String title, fromEmail, telephoneNo, messageText;
  String toEmail;
  DateTime requestTime;
  int postId;

  RequestData(this.postId, this.id, this.title, this.fromEmail, this.telephoneNo, this.messageText, this.toEmail,
      this.requestTime);

  RequestData.empty()
      : postId = 0,
        fromEmail = '',
        messageText = '',
        telephoneNo = '',
        title = '',
        requestTime = DateTime.now(),
        toEmail = '';

  Map toJson() => {
        'title': title,
        'fromEmail': fromEmail,
        'telephoneNo': telephoneNo,
        'messageText': messageText,
        'toEmail': toEmail,
        'requestTime': requestTime.toString(),
        'postId': postId,
      };

  @override
  String toString() {
    return 'RequestData{id: $id, title: $title, fromEmail: $fromEmail, telephoneNo: $telephoneNo, message: $messageText, toEmail: $toEmail, requestTime: $requestTime, postId: $postId}';
  }
}
