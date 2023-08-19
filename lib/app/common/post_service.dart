import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_hands/app/domain/post_model.dart';

class PostService {
  static const Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  static const String postsUrl = "http://10.0.2.2:8080/posts";

  static PostService get() {
    return PostService();
  }

  Future<http.Response> createPost(PostModel postModel) async {
    print("Create Post - $postModel");
    var json = jsonEncode(postModel.toJson());
    print("JSON $json");
    return http.post(Uri.parse(postsUrl), headers: header, body: json);
  }

  Future<http.Response> deletePost(String postId, PostModel postModel) async {
    print("Delete Post $postId $postModel");
    return http.delete(Uri.parse("$postsUrl/$postId"), headers: header);
  }

  Future<http.Response> getAllPosts() async {
    return http.get(Uri.parse(postsUrl), headers: header);
  }
}
