import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_hands/app/common/constants.dart';
import 'package:open_hands/app/domain/post_data.dart';
import 'package:open_hands/app/item_post/post_detail.dart';
import 'dart:convert' as convert;

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
    // if (dummyEnabled) {
    //   return deletePostDummy(postId);
    // }
    return http.delete(Uri.parse("$postsUrl/$postId"), headers: header);
  }

  Future<http.Response> getAllPosts() async {
    // if (dummyEnabled) {
    //   return getAllPostsDummy();
    // }
    return http.get(Uri.parse(postsUrl), headers: header);
  }

  Future<List<PostData>> getAllPostsInType() async {
    var response = await getAllPosts();
    if (response.statusCode == 200) {
      print(response.body);
      var jsonDecode2 = convert.jsonDecode(response.body) as List<dynamic>;
      List<PostData> data = [];
      for (var item in jsonDecode2) {
        print(item);
        List<String> images = [];
        for (var img in item['images'] as List<dynamic>) {
          images.add(img);
        }
        data.add(PostData(item['id'], item['title'], item['description'], item['category'], item['subCategory'],
            item['location'], images, DateTime.parse(item['dateTime']), item['createdBy']));
      }
      return data;
      // return Future<List<PostData>>.sync(() => data);
    }
    return List.empty();
  }

// List<PostData> getDummyPosts() {
//   fillIfEmpty();
//   print("Total posts ${dummyPosts.length}");
//   return dummyPosts;
// }

// bool dummyEnabled = false;
// static List<PostData> dummyPosts = List.empty(growable: true);

// http.Response createPostDummyResp(PostData postModel) {
//   postModel.id = Random().nextInt(500);
//   dummyPosts.add(postModel);
//   print("Dummy post created. New length ${dummyPosts.length}");
//   return http.Response(jsonEncode(postModel.toJson()), 201);
// }

// http.Response deletePostDummy(int postId) {
//   PostData found = dummyPosts.firstWhere((element) => element.id == postId, orElse: () => PostData.empty());
//   if (found.id != null) {
//     dummyPosts.removeWhere((element) => element.id == postId);
//     https: //developer.mozilla.org/en-US/docs/Web/HTTP/Methods/DELETE
//     return http.Response('', 200);
//   }
//   return http.Response('', 204);
// }

// http.Response getAllPostsDummy() {
//   fillIfEmpty();
//   return http.Response(jsonEncode(dummyPosts), 200);
// }

// void fillIfEmpty() {
//   if (dummyPosts.isEmpty) {
//     print("Empty dummy - filling!!!");
//     dummyPosts
//       ..add(PostData(
//           Random().nextInt(500),
//           'Dummy 1',
//           'Dummy Post - The item is very new. I have used it for only few times',
//           'Household',
//           'Cleaning',
//           'Colombo',
//           [
//             "https://images.unsplash.com/photo-1598928636135-d146006ff4be?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"
//           ],
//           DateTime.now(),
//           'Dummy user'))
//       ..add(PostData(
//           Random().nextInt(500),
//           'Dummy - Sony Radio',
//           'Dummy Post - The item is very new. I have used it for only few times',
//           'Electronics',
//           'Radio',
//           'Colombo',
//           ["https://i.pinimg.com/736x/21/b8/7c/21b87c1668302c53892dc16c38ef9994.jpg"],
//           DateTime.now(),
//           'Dummy user'));
//   }
// }
}