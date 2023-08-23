const String _restBase = "http://10.0.2.2:8080";
const String requestsUrl = "$_restBase/messages";
const String postsUrl = "$_restBase/posts";
const String userUrl = "$_restBase/users";
const Map<String, String> header = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};
// 'Context-Type': 'application/json; charset=UTF-8'