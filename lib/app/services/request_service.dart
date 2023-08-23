import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_hands/app/domain/request_data.dart';
import 'package:open_hands/app/services/user_service.dart';

import '../common/constants.dart';

class RequestService {
  static RequestService postService = RequestService();

  static RequestService get() {
    return postService;
  }

  Future<http.Response> create(RequestData requestData) async {
    print("Create Request - $requestData");
    var json = jsonEncode(requestData.toJson());
    print("Request Json $json");
    return http.post(Uri.parse(requestsUrl), headers: header, body: json);
  }

  Future<http.Response> delete(String requestId, RequestData requestData) async {
    print("Delete Request $requestId $requestData");
    return http.delete(Uri.parse("$requestsUrl/$requestId"), headers: header);
  }

  Future<http.Response> getAllRequests() async {
    return http.get(Uri.parse(requestsUrl), headers: header);
  }

  Future<http.Response> getRequestsByMe() async {
    var currentUserMail = UserService.get().loggedInUser?.email;
    return http.get(Uri.parse('$requestsUrl/from/$currentUserMail'), headers: header);
  }

  Future<http.Response> getRequestsToMe() async {
    var currentUserMail = UserService.get().loggedInUser?.email;
    return http.get(Uri.parse('$requestsUrl/to/$currentUserMail'), headers: header);
  }
}
