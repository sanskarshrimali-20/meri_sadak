import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data/model/image_item_model.dart';

class ImagePickerProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  final List<ImageItem> _imageFiles = [];

  List<ImageItem> get imageFiles => _imageFiles;

  Future<String?> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      final imgSizeCheck =
      await getImageSize(image); // Get the image size in KB
     /* if (imgSizeCheck >= 2048) {
        return 'Image exceeds the size limit of 2MB. Please choose a smaller image.';
      } else */
        if (_imageFiles.length < 3) {
        // Add image and its source (Camera or Gallery) to the list
        _imageFiles.add(ImageItem(
          image: image,
          source: source == ImageSource.camera ? 'Camera' : 'Gallery',
        ));
        notifyListeners(); // Notify listeners to update the UI
        return null;
      } else {
        return 'You can only upload up to 3 images.';
      }
    } else {
      print("No image selected");
      return null;
    }
  }

  void clearImages() {
    _imageFiles.clear();
    notifyListeners();
  }

  void deleteImage(int index) {
    _imageFiles.removeAt(index);
    notifyListeners();
  }

  Future<double> getImageSize(XFile? selectedImage) async {
    // Read the image's bytes asynchronously
    final bytes = await selectedImage!.readAsBytes();

    // Get the size in bytes
    final sizeInBytes = bytes.lengthInBytes;

    // Convert bytes to KB and MB
    final kb = sizeInBytes / 1024;
    final mb = kb / 1024;

    // Print the size in MB for clarity
    print("Image size: ${mb.toStringAsFixed(2)} MB");

    // Check if the image is less than 5MB (5000 KB)
    if (kb < 5000.0) {
      print("Image is Less than 5MB");
    } else {
      print("Image is More than 5MB...!!!");
    }

    // Return the size in KB
    return kb;
  }
}
