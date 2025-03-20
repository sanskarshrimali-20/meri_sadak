import 'package:image_picker/image_picker.dart';

class ImageItem {
  final int? id; // Added for db
  final String imagePath;
  final String source;

  ImageItem({
    this.id,
    required this.imagePath,
    required this.source,
  });

  // Convert ImageItem to Map for database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': imagePath,
      'source': source,
    };
  }

  // Create ImageItem from a Map (used when loading from database)
  factory ImageItem.fromMap(Map<String, dynamic> map) {
    return ImageItem(
      id: map['id'],
      imagePath: map['image'],
      source: map['source'],
    );
  }
}
