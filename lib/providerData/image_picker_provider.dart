import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meri_sadak/providerData/permission_provider.dart';
import 'package:meri_sadak/utils/date_time_utils.dart';
import '../data/model/image_item_model.dart';
import '../services/DatabaseHelper/database_helper.dart';

class ImagePickerProvider extends ChangeNotifier {

  final ImagePicker _picker = ImagePicker();
  List<ImageItem> _imageFiles = [];

  List<ImageItem> get imageFiles => _imageFiles;
  final dbHelper = DatabaseHelper();
  final permissionProvider = PermissionProvider();

  // Load images from DB
  Future<void> loadImages() async {
    final imagesFromDb =
        await dbHelper.getAllImages(); // Replace with your DB fetch logic
    _imageFiles.clear(); // Clear any existing images
    _imageFiles.addAll(imagesFromDb); // Add images from DB to list
    notifyListeners(); // Notify listeners (UI) about the change

  }

  // Pick an image from camera or gallery
  Future<String?> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      if (_imageFiles.length < 3) {
        // Add image to the DB

        ImageItem newImage = ImageItem(
          imagePath: image.path,
          source: source == ImageSource.camera ? 'Camera' : 'Gallery',
          lat: source == ImageSource.camera ? permissionProvider.latitude.toString(): '',
          long: source == ImageSource.camera ? permissionProvider.longitude.toString() : '',
          time: DateTimeUtil.getFormattedDateTime(),
        );

        await dbHelper.insertImage(newImage);
        // Update the image list
        await loadImages();
        return null;
      } else {
        return 'You can only upload up to 3 images.';
      }
    } else {
      return null;
    }
  }

  // Delete image from DB and list
  Future<void> deleteImage(int index) async {
    final image = _imageFiles[index];
    await dbHelper.deleteImage(image.id!);
    _imageFiles.removeAt(index);
    notifyListeners();
    await loadImages();
  }

  // Clear all images from DB
  Future<void> clearImages() async {
    await dbHelper.clearImages();
    _imageFiles.clear();
    notifyListeners();
  }

  // This method will set images from the fetched data
  Future<void> setImages(List<dynamic> feedbackData) async {
    // Assuming feedbackData contains a list of maps with 'images'
    List<ImageItem> fetchedImages = [];

    for (var feedback in feedbackData) {
      if (feedback['images'] != null) {
        for (var imageData in feedback['images']) {
          // Create an ImageItem from each image and add it to the list
          fetchedImages.add(
            ImageItem(
              imagePath: imageData['image'],
              source: imageData['source'],
              id: imageData['id'],
              lat: imageData['lat'],
              long: imageData['long'],
              time: imageData['time'],
            ),
          );
        }
      }
    }

    // Update the imageFiles and notify listeners
    _imageFiles = fetchedImages;
    notifyListeners();
  }
}
