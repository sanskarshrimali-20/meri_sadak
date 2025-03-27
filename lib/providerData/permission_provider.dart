import 'dart:io';
import 'package:flutter/material.dart';
import 'package:meri_sadak/widgets/custom_snackbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../constants/app_image_path.dart';
import '../constants/app_strings.dart';
import '../widgets/selection_dialog.dart';

class PermissionProvider extends ChangeNotifier {
  bool cameraPermissionGranted = false;
  bool microphonePermissionGranted = false;
  double? latitude;
  double? longitude;
  String address = '', location = 'Unknown';
  bool isLoading = false;
  String state = '';
  String district = '';
  String block = '';
  bool isLocationFetched = false;
  File? _profilePic;

  // Getter for profilePic
  File? get profilePic => _profilePic;

  // Setter for profilePic
  set profilePic(File? profilePic) {
    _profilePic = profilePic;
    notifyListeners(); // Optionally notify listeners if needed
  }

  // Method to set profilePic
  void setProfilePic(File? newProfilePic) {
    _profilePic = newProfilePic;
    notifyListeners(); // Notify listeners to update UI
  }

  Future<void> fetchCurrentLocation() async {
    if (isLocationFetched) return; // Don't fetch if already fetched

    isLoading = true;
    notifyListeners();
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.requestPermission();
      }

      // Check permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        isLoading = false;
        notifyListeners();
        throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.',
        );
      }

      // Get the current position
      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
      );

      latitude = position.latitude;
      longitude = position.longitude;

      // Get the address from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude!,
        longitude!,
      );
      location = '${position.latitude}, ${position.longitude}';
      debugPrint("location---$location");
      state = placemarks.first.administrativeArea ?? '';
      district = placemarks.first.locality ?? '';
      block = placemarks.first.subLocality ?? ''; // This ma
      address =
          '${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea} - ${placemarks.first.postalCode}, ${placemarks.first.country}.';
      debugPrint("address---$address");

      isLocationFetched = true;
      notifyListeners();
    } catch (e) {
      address = 'Failed to fetch location: ${e.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> setLocation(double lat, double lng) async {
    latitude = lat;
    longitude = lng;
    isLoading = true;
    notifyListeners();
    // Fetch address from coordinates
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      location = '$lat, $lng';
      state = placemarks.first.administrativeArea ?? '';
      district = placemarks.first.locality ?? '';
      block = placemarks.first.subLocality ?? ''; // This ma
      address =
          '${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea} - ${placemarks.first.postalCode}, ${placemarks.first.country}.';
      notifyListeners();
    } catch (e) {
      address = 'Failed to fetch location: ${e.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchLocationBasedOnLatLong(posLat, posLong) async {
    // if (isLocationFetched) return; // Don't fetch if already fetched

    isLoading = true;
    notifyListeners();
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.requestPermission();
      }

      // Check permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        isLoading = false;
        notifyListeners();
        throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.',
        );
      }

      // Get the current position
      // final position = await Geolocator.getCurrentPosition(
      //   locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
      // );

      // latitude = position.latitude;
      // longitude = position.longitude;
      latitude = posLat;
      longitude = posLong;

      // Get the address from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude!,
        longitude!,
      );
      location = '${posLat}, ${posLong}';
      debugPrint("location---$location");
      state = placemarks.first.administrativeArea ?? '';
      district = placemarks.first.locality ?? '';
      block = placemarks.first.subLocality ?? ''; // This ma
      address =
          '${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea} - ${placemarks.first.postalCode}, ${placemarks.first.country}.';
      debugPrint("address---$address");

      // isLocationFetched = true;
      notifyListeners();
    } catch (e) {
      address = 'Failed to fetch location: ${e.toString()}';
    } finally {
      // isLoading = false;
      notifyListeners();
    }
  }

  // Method to handle location permission
  Future<bool> requestLocationPermission() async {
    final status = await Permission.location.status;
    print("statusLoc---$status");
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      final result = await Permission.location.request();
      return result.isGranted;
    } else if (status.isPermanentlyDenied) {
      return status
          .isPermanentlyDenied; //false; // User must enable permissions from app settings
    }
    return false;
  }

  // New method for camera permission
  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.status;

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      final result = await Permission.camera.request();
      return result.isGranted;
    } else if (status.isPermanentlyDenied) {
      return false; // User must enable permissions from app settings
    }
    return false;
  }

  // Request Location Permission
  Future<void> requestLocationPermissionNew(BuildContext context) async {
    final status = await Permission.location.status;

    if (status.isGranted) {
      print("Location permission granted.");
    } else if (status.isDenied) {
      // Request permission if it's denied
      final result = await Permission.location.request();
      if (result.isGranted) {
        print("Location permission granted.");
      } else {
        // Show custom permission dialog if not granted
        /*  showCustomSelectionDialog(
          title: AppStrings.allowLocationAlertTitle,
          titleVisibility: true,
          content: AppStrings.allowLocationAlertContent,
          icon: ImageAssetsPath.locationPin,
          iconVisibility: true,
          buttonLabels: ["Allow", "Skip for now"],
          onButtonPressed: [
                () async {
                  // Request permission to the system
                  Permission.location.request();
                  Permission.camera.request();
                  Navigator.pop(context);  // Close the dialog
            },
                () {
              Navigator.pop(context); // Close the dialog
            },
          ],
          isButtonActive: [true, false],
          context: context,
          dialogHeight: 350,
        );*/
      }
    } else if (status.isPermanentlyDenied) {
      // Show the custom permission dialog to guide users to settings if permanently denied
      /* showCustomSelectionDialog(
        title: 'Permission Required',
        titleVisibility: true,
        content: 'The location permission is permanently denied. You need to enable it in the app settings.',
        icon: ImageAssetsPath.locationPin,
        iconVisibility: true,
        buttonLabels: ["Go to Settings", "Cancel"],
        onButtonPressed: [
              () async {
                await openAppSettings();
            // Request permission to the system
            // Permission.location.request();
            // Permission.camera.request();
            Navigator.pop(context);  // Close the dialog
          },
              () {
            Navigator.pop(context); // Close the dialog
          },
        ],
        isButtonActive: [true, false],
        context: context,
        dialogHeight: 350,
      );*/
    }
  }

  // Request Camera Permission
  Future<void> requestCameraPermissionNew(BuildContext context) async {
    final status = await Permission.camera.status;

    if (status.isGranted) {
      print("Camera permission granted.");
    } else if (status.isDenied) {
      final result = await Permission.camera.request();
      if (result.isGranted) {
        print("Camera permission granted.");
      } else {
        //_showPermissionDialog(context);
        /*    showCustomSelectionDialog(
          title: AppStrings.allowCameraAlertTitle,
          titleVisibility: true,
          content: AppStrings.allowCameraAlertContent,
          icon: ImageAssetsPath.photo,
          iconVisibility: true,
          buttonLabels: ["Allow", "Skip for now"],
          onButtonPressed: [
                () async {
              // Request permission to the system
              Permission.location.request();
              Permission.camera.request();
              Navigator.pop(context);  // Close the dialog
            },
                () {
              Navigator.pop(context); // Close the dialog
            },
          ],
          isButtonActive: [true, false],
          context: context,
          dialogHeight: 350,
        );*/
      }
    } else if (status.isPermanentlyDenied) {
      // _showPermissionDialog(context);
      /*  showCustomSelectionDialog(
        title: AppStrings.allowCameraAlertTitle,
        titleVisibility: true,
        content: AppStrings.allowCameraAlertContent,
        icon: ImageAssetsPath.photo,
        iconVisibility: true,
        buttonLabels: ["Allow", "Skip for now"],
        onButtonPressed: [
              () async {
            // Request permission to the system
            Permission.location.request();
            Permission.camera.request();
            Navigator.pop(context);  // Close the dialog
          },
              () {
            Navigator.pop(context); // Close the dialog
          },
        ],
        isButtonActive: [true, false],
        context: context,
        dialogHeight: 350,
      );*/
    }
  }

  Future<void> openSettingsAppForPermission(BuildContext context) async {
    final locationStatus = await Permission.location.status;
    final cameraStatus = await Permission.camera.status;
    if (locationStatus.isPermanentlyDenied ||
        cameraStatus.isPermanentlyDenied) {
      openAppSettings();
    } else if (locationStatus.isDenied || cameraStatus.isDenied) {
      showErrorDialog(
        context,
        "Please allow permission",
        backgroundColor: Colors.red,
      );
    } else {
      openAppSettings();
      showErrorDialog(
        context,
        "Already Permission given",
        backgroundColor: Colors.green,
      );
    }
  }
}
