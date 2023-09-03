import 'dart:core';

import 'package:open_hands/app/domain/image_data.dart';

class PostData {
  int? id;
  late String title;
  late String description;
  late String category;
  late String condition;
  late String location;
  late List<AppImageData> images = [];
  late DateTime dateTime;
  late String createdBy;

  PostData.empty() : createdBy = 'current user';

  PostData(this.id, this.title, this.description, this.category, this.condition, this.location, this.images,
      this.dateTime, this.createdBy);

  PostData.fromJson(Map<String, dynamic> item) {
    List<AppImageData> newImages = [];
    for (var img in (item['images'] as List<dynamic>)) {
      newImages.add(AppImageData.fromJson(img));
    }
    id = item['id'];
    title = item['title'];
    description = item['description'];
    category = item['category'];
    condition = item['condition'];
    location = item['location'];
    images = newImages;
    dateTime = DateTime.parse(item['dateTime']);
    createdBy = item['createdBy'];
  }

  @override
  String toString() {
    return 'PostData{id: $id, title: $title, description: $description, category: $category, condition: $condition'
        ', location: $location, images: $images, dateTime: $dateTime, createdBy: $createdBy}';
  }

  Map toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'condition': condition,
        'location': location,
        // 'images': images,
        'dateTime': dateTime.toString(),
        'createdBy': createdBy,
      };
}
