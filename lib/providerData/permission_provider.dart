import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class PermissionProvider extends ChangeNotifier {
  bool cameraPermissionGranted = false;
  bool microphonePermissionGranted = false;
  double? latitude;
  double? longitude;
  String address = '',location='Unknown';
  bool isLoading = false;

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
    notifyListeners();  // Notify listeners to update UI
  }


  Future<void> fetchCurrentLocation() async {
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
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // Get the current position
      final position = await Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(
              accuracy: LocationAccuracy.best
          )
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
      address =
      '${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea} - ${placemarks.first.postalCode}, ${placemarks.first.country}.';
      debugPrint("address---$address");
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
    notifyListeners();

    // Fetch address from coordinates
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      location = '$lat, $lng';
      address =
      '${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea} - ${placemarks.first.postalCode}, ${placemarks.first.country}.';
    } catch (e) {
      address = 'Failed to fetch address.';
    }

    notifyListeners();
  }

  // Method to handle location permission
  Future<bool> requestLocationPermission() async {
    final status = await Permission.location.status;

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      final result = await Permission.location.request();
      return result.isGranted;
    } else if (status.isPermanentlyDenied) {
      return false; // User must enable permissions from app settings
    }
    return false;
  }

}
