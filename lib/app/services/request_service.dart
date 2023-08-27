import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_hands/app/domain/request_data.dart';
import 'package:open_hands/app/services/user_service.dart';

import '../common/constants.dart';

class RequestService {
  static final RequestService postService = RequestService();

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

  Future<List<RequestData>> getMessagesByMe() async {
    return await getMessages('from');
  }

  Future<List<RequestData>> getMessagesForMe() async {
    return getMessages('to');
  }

  Future<List<RequestData>> getMessages(String fromOrTo) async {
    var currentUserMail = UserService.get().loggedInUser?.email;
    // try {
    var response = await http.get(Uri.parse('$requestsUrl/$fromOrTo/$currentUserMail'), headers: header);
    print('resp ${response.body}');
    if (response.statusCode == 200) {
      return convertToModel(response);
    }
    if (response.statusCode == 204) {
      return [];
    }
    throw Exception('Retrieving requests for current user did not succeed : ${response.statusCode}');

    // } catch (e) {
    //   throw Exception('Error retrieving current user requests : $e');
    // }
  }

  List<RequestData> convertToModel(http.Response response) {
    var bodyList = jsonDecode(response.body) as List<dynamic>;
    return bodyList.map((e) {
      var item = e as Map<String, dynamic>;
      return RequestData(
        item['post']['id'],
        item['id'],
        item['name'],
        item['fromEmail'],
        item['telephoneNo'],
        item['messageText'],
        item['toEmail'],
        DateTime.parse(item['requestTime']),
      );
    }).toList();
  }
}
