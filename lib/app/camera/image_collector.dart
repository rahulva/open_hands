import 'package:flutter/foundation.dart';

class ImageCollector {
  Set<String> _images = {};

  set add(String image) {
    var add = _images.add(image);
    if (kDebugMode) {
      print('Adding new image $image $add');
    }
  }

  Set<String> get images {
    return _images;
  }

  reset() {
    _images = {};
  }
}
