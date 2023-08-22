import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_hands/app/domain/request_data.dart';
import 'package:uuid/uuid.dart';

import 'constants.dart';

class RequestService {
  var uuid = const Uuid();

  static RequestService get() {
    var postService = RequestService();
    return postService;
  }

  Future<http.Response> create(RequestData requestData) async {
    print("Create Request - $requestData");
    if (dummyEnabled) {
      return createRequestDummyResp(requestData);
    }

    var json = jsonEncode(requestData.toJson());
    print("JSON $json");
    return http.post(Uri.parse(requestsUrl), headers: header, body: json);
  }

  Future<http.Response> delete(String requestId, RequestData requestData) async {
    print("Delete Request $requestId $requestData");
    if (dummyEnabled) {
      return deleteRequestDummy(requestId);
    }
    return http.delete(Uri.parse("$requestsUrl/$requestId"), headers: header);
  }

  Future<http.Response> getAllRequests() async {
    if (dummyEnabled) {
      return getAllRequestsDummy();
    }
    return http.get(Uri.parse(postsUrl), headers: header);
  }

  List<RequestData> getDummyPosts() {
    fillIfEmpty();
    print("Total posts ${dummyRequests.length}");
    return dummyRequests;
  }

  bool dummyEnabled = true;
  static List<RequestData> dummyRequests = List.empty(growable: true);

  http.Response createRequestDummyResp(RequestData requestData) {
    dummyRequests.add(requestData);
    print("Dummy post created. New length ${dummyRequests.length}");
    return http.Response(jsonEncode(requestData.toJson()), 201);
  }

  http.Response deleteRequestDummy(String requestId) {
    RequestData found =
        dummyRequests.firstWhere((element) => element.id == requestId, orElse: () => RequestData.empty());
    if (found.id != null) {
      dummyRequests.removeWhere((element) => element.id == requestId);
      https: //developer.mozilla.org/en-US/docs/Web/HTTP/Methods/DELETE
      return http.Response('', 200);
    }
    return http.Response('', 204);
  }

  http.Response getAllRequestsDummy() {
    fillIfEmpty();
    return http.Response(jsonEncode(dummyRequests), 200);
  }

  void fillIfEmpty() {
    if (dummyRequests.isEmpty) {
      print("Empty dummy - filling!!!");
      dummyRequests
        ..add(RequestData(
            401,
            uuid.v1(),
            'Ron Y',
            'test@gmail.com',
            '+491000012200',
            'Dear current user, I need this item, please provide me. I can collect from this location.',
            'currentuser@gmail.com',
            DateTime.now()))
        ..add(RequestData(401, uuid.v1(), 'Tem', 'test@gmail.com', '+491000012200', 'Hi, I am in need of this ',
            'currentuser@gmail.com', DateTime.now()));
    }
  }
}
