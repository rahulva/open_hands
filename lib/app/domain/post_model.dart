
import 'dart:core';

class PostModel {
  int id;
  String name;
  String description;
  String location;
  String category;
  String subCategory;
  List<String> images;
  DateTime dateTime;
  String byUser;

  PostModel(this.id, this.name, this.description, this.location, this.category, this.subCategory, this.images,
      this.dateTime, this.byUser);
}