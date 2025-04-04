import 'dart:io';
import 'package:flutter/material.dart';
import 'package:meri_sadak/widgets/custom_snackbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

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
      state = placemarks.first.administrativeArea ?? '';
      district = placemarks.first.locality ?? '';
      block = placemarks.first.subLocality ?? ''; // This ma
      address =
          '${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea} - ${placemarks.first.postalCode}, ${placemarks.first.country}.';

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
    //if (isLocationFetched) return; // Don't fetch if already fetched

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

      latitude = posLat;
      longitude = posLong;

      // Get the address from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude!,
        longitude!,
      );
      location = '$posLat, $posLong';
      state = placemarks.first.administrativeArea ?? '';
      district = placemarks.first.locality ?? '';
      block = placemarks.first.subLocality ?? ''; // This ma
      address =
          '${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea} - ${placemarks.first.postalCode}, ${placemarks.first.country}.';

      isLocationFetched = true;
      notifyListeners();
    } catch (e) {
      address = 'Failed to fetch location: ${e.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
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
