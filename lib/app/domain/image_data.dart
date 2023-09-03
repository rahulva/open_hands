import 'dart:core';

class AppImageData {
  late String name;
  late String postId;
  late String type;
  late  int id;
  dynamic imageData;

  AppImageData(this.id, this.name, this.postId, this.type, this.imageData);

  AppImageData.fromJson(Map<String, dynamic> img) {
    id = img['id'];
    name = img['name'];
    postId = img['postId'];
    type = img['type'];
    imageData = img['imageData'];
  }
}
