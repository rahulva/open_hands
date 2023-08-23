import 'dart:core';

class PostData {
  int? id;
  late String title;
  late String description;
  late String category;
  late String subCategory;
  late String location;
  late List<String>? images = List.empty(growable: true);
  late DateTime dateTime;
  late String createdBy;

  PostData.empty() : createdBy = 'current user';

  PostData(this.id, this.title, this.description, this.category, this.subCategory, this.location, this.images,
      this.dateTime, this.createdBy);

  @override
  String toString() {
    return 'PostData{id: $id, title: $title, description: $description, category: $category, subCategory: $subCategory'
        ', location: $location, images: $images, dateTime: $dateTime, createdBy: $createdBy}';
  }

  Map toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'subCategory': subCategory,
        'location': location,
        'images': images,
        'dateTime': dateTime.toString(),
        'createdBy': createdBy,
      };
}
