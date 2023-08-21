import 'dart:core';

class PostModel {
  int? id;
  late String name;
  late String description;
  late String category;
  late String subCategory;
  late String location;
  late List<String>? images = List.empty(growable: true);
  late DateTime dateTime;
  late String byUser;

  PostModel.empty() : byUser = 'current user';

  PostModel(this.id, this.name, this.description, this.category, this.subCategory, this.location, this.images,
      this.dateTime, this.byUser);

  @override
  String toString() {
    return 'PostModel{id: $id, name: $name, description: $description, category: $category, subCategory: $subCategory, location: $location, images: $images, dateTime: $dateTime, byUser: $byUser}';
  }

  Map toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'category': category,
        'subCategory': subCategory,
        'location': location,
        'images': images,
        'dateTime': dateTime.toString(),
        'byUser': byUser,
      };
}
