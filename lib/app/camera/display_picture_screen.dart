import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_hands/app/camera/image_collector.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final ImageCollector imageCollector;

  const DisplayPictureScreen({super.key, required this.imagePath, required this.imageCollector});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview')),
      body: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Image.file(File(imagePath)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                // la: const Icon(Icons.add),
                child: const Text('Add'),
                onPressed: () {
                  imageCollector.add = imagePath;
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => const PostCreate()));
                },
              ),
              FloatingActionButton(
                // child: const Icon(Icons.add),
                child: const Text('Add More'),
                onPressed: () {
                  imageCollector.add = imagePath;
                  Navigator.pop(context, true);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
