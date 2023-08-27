import 'package:intl/intl.dart';

const String _restBase = "http://10.0.2.2:8080";
const String requestsUrl = "$_restBase/messages";
const String postsUrl = "$_restBase/posts";
const String postImagesUrl = "$_restBase/images";
const String userUrl = "$_restBase/users";
const Map<String, String> header = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};
DateFormat appDateFormat = DateFormat('d EEE MMM, h:mm a');
// 'Context-Type': 'application/json; charset=UTF-8'