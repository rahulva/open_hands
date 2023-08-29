import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:open_hands/app/domain/post_data.dart';
import 'package:open_hands/app/services/post_service.dart';

class PostServiceDummy extends PostService {
  static List<PostData> dummyPosts = List.empty(growable: true);
  static PostServiceDummy postServiceDummy = PostServiceDummy();

  static PostServiceDummy get() {
    return postServiceDummy;
  }

  Future<http.Response> createPost(PostData postModel) async {
    print("Dummy Create Post - $postModel");
    return createPostDummyResp(postModel);
  }

  Future<http.Response> deletePost(int postId, PostData postModel) async {
    return deletePostDummy(postId);
  }

  Future<List<PostData>> getAllPosts() async {
    return getAllPostsDummy();
  }

  List<PostData> getDummyPosts() {
    fillIfEmpty();
    print("Total posts ${dummyPosts.length}");
    return dummyPosts;
  }

  bool dummyEnabled = false;

  http.Response createPostDummyResp(PostData postModel) {
    postModel.id = Random().nextInt(500);
    dummyPosts.add(postModel);
    print("Dummy post created. New length ${dummyPosts.length}");
    return http.Response(jsonEncode(postModel.toJson()), 201);
  }

  http.Response deletePostDummy(int postId) {
    PostData found = dummyPosts.firstWhere((element) => element.id == postId, orElse: () => PostData.empty());
    if (found.id != null) {
      dummyPosts.removeWhere((element) => element.id == postId);
      // https: //developer.mozilla.org/en-US/docs/Web/HTTP/Methods/DELETE
      return http.Response('', 200);
    }
    return http.Response('', 204);
  }

  List<PostData> getAllPostsDummy() {
    fillIfEmpty();
    return dummyPosts;
  }

  void fillIfEmpty() {
    if (dummyPosts.isEmpty) {
      print("Empty dummy - filling!!!");
      dummyPosts
        ..add(PostData(
            Random().nextInt(500),
            'Dummy 1',
            'Dummy Post - The item is very new. I have used it for only few times',
            'Household',
            'Cleaning',
            'Colombo',
            [
              // "https://images.unsplash.com/photo-1598928636135-d146006ff4be?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"
            ],
            DateTime.now(),
            'Dummy user'))
        ..add(PostData(
            Random().nextInt(500),
            'Dummy - Sony Radio',
            'Dummy Post - The item is very new. I have used it for only few times',
            'Electronics',
            'Radio',
            'Colombo',
            [
              // "https://i.pinimg.com/736x/21/b8/7c/21b87c1668302c53892dc16c38ef9994.jpg"
            ],
            DateTime.now(),
            'Dummy user'));
    }
  }
}
