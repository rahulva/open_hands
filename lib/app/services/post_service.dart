import 'dart:async';
import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:open_hands/app/common/constants.dart';
import 'package:open_hands/app/domain/image_data.dart';
import 'package:open_hands/app/domain/post_data.dart';
import 'package:path/path.dart';

class PostService {
  static final postService = PostService();

  static PostService get() {
    return postService;
  }

  Future<http.Response> createPost(PostData postModel) async {
    print("Create Post - $postModel");
    // if (dummyEnabled) {
    //   return createPostDummyResp(postModel);
    // }

    var json = jsonEncode(postModel.toJson());
    print("JSON $json");
    return http.post(Uri.parse(postsUrl), headers: header, body: json);
  }

  Future<http.Response> deletePost(int postId, PostData postModel) async {
    print("Delete Post $postId $postModel");
    return http.delete(Uri.parse("$postsUrl/$postId"), headers: header);
  }

  Future<http.Response> getAllPosts() async {
    return http.get(Uri.parse(postsUrl), headers: header);
  }

  Future<List<PostData>> getAllPostsInType() async {
    var response = await getAllPosts();
    if (response.statusCode == 200) {
      // print(response.body);
      return toModel(response);
    }
    return List.empty();
  }

  Future<List<PostData>> getPostCreatedBy(String email) async {
    var response = await http.get(Uri.parse('$postsUrl/$email'), headers: header);
    return toModel(response);
  }

  List<PostData> toModel(http.Response response) {
    var jsonDecode2 = convert.jsonDecode(response.body) as List<dynamic>;
    List<PostData> data = [];
    for (var item in jsonDecode2) {
      List<AppImageData> images = [];
      for (var img in item['images'] as List<dynamic>) {
        if (kDebugMode) {
          print(img);
        }
        images.add(AppImageData(img['id'], img['name'], img['postId'], img['type'], img['imageData']));
      }
      data.add(PostData(item['id'], item['title'], item['description'], item['category'], item['condition'],
          item['location'], images, DateTime.parse(item['dateTime']), item['createdBy']));
    }
    return data;
  }

  // upload(File imageFile) async {
  //   // string to uri
  //   var uri = Uri.parse('$postImagesUrl/upload-all');
  //
  //   // create multipart request
  //   var request = http.MultipartRequest("POST", uri);
  //
  //   // open a bytestream
  //   var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  //
  //   // get file length
  //   var length = await imageFile.length();
  //
  //   // multipart that takes file
  //   var multipartFile = http.MultipartFile('file', stream, length, filename: basename(imageFile.path));
  //
  //   // add file to multipart
  //   request.files.add(multipartFile);
  //
  //   // send
  //   var response = await request.send();
  //   print(response.statusCode);
  //
  //   // listen for response
  //   response.stream.transform(utf8.decoder).listen((value) {
  //     print(value);
  //   });
  // }

  Future<http.StreamedResponse> uploadAll(int postId, List<String> imagePaths) async {
    var request = http.MultipartRequest("POST", Uri.parse('$postImagesUrl/upload-all'));
    request.fields['postId'] = '$postId';
    for (var fPath in imagePaths) {
      var imageFile = File(fPath);
      var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile('file', stream, length, filename: basename(imageFile.path));

      request.files.add(multipartFile);
    }
    // send
    http.StreamedResponse response = await request.send();
    print("Image Upload completed");
    return response;
  }
}
