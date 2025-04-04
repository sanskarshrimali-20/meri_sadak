import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_map_dragmarker/flutter_map_dragmarker.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../providerData/permission_provider.dart';

class CustomLocationWidget extends StatefulWidget {
  final String labelText;
  final bool isRequired;
  final double? latitude;
  final double? longitude;
  final String initialAddress;
  final bool isLoading;
  final Color backgroundColor;
  final Color refreshIconColor;
  final Color progressIndicatorColor;
  final double mapHeight;
  final double mapWidth;
  final Function() onRefresh;
  final VoidCallback? onMapReady;
  final Function(LatLng) onMapTap;

  // ignore: use_super_parameters
  const CustomLocationWidget({
    Key? key,
    required this.labelText,
    required this.isRequired,
    required this.latitude,
    required this.longitude,
    required this.initialAddress,
    this.isLoading = false,
    this.backgroundColor = const Color(0xFFF0F0F0),
    this.refreshIconColor = Colors.black,
    this.progressIndicatorColor = Colors.blue,
    this.mapHeight = 200.0,
    this.mapWidth = 300.0,
    required this.onRefresh,
    this.onMapReady,
    required this.onMapTap,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomLocationWidgetState createState() => _CustomLocationWidgetState();
}

class _CustomLocationWidgetState extends State<CustomLocationWidget> {
  String currentAddress = '';

  // ignore: unused_field, prefer_final_fields
  bool _isSatellite = false;
  late LatLng markerPosition; // Tracks marker and circle position
  final double allowedRadius = 350; // Radius in meters
  late LatLng initialPosition;
  final Distance distanceCalculator = const Distance();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  String path = '';

  @override
  void initState() {
    super.initState();
    // currentAddress = widget.initialAddress;
    loadLatLongDataOnInit();
  }

  @override
  Widget build(BuildContext context) {
    final permissionProvider = Provider.of<PermissionProvider>(context);
    return widget.latitude != null && widget.longitude != null
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.labelText,
                  style: TextStyle(
                    fontSize: AppDimensions.di_16,
                    fontWeight: FontWeight.bold,
                    color: widget.refreshIconColor,
                  ),
                ),
                SizedBox(width: 5), // Space between text and image
                widget.isRequired == true
                    ? Text(
                      "*",
                      style: TextStyle(
                        fontSize: AppDimensions.di_16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    )
                    : SizedBox.shrink(),
                Spacer(), // This will push the next widget to the end
                widget.isLoading
                    ? SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        color: widget.progressIndicatorColor,
                      ),
                    )
                    : IconButton(
                      icon: Icon(
                        Icons.refresh,
                        color: widget.refreshIconColor,
                        size: 25,
                      ),
                      onPressed: widget.onRefresh,
                    ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(AppDimensions.di_4),
              decoration: BoxDecoration(
                color: AppColors.textFieldBorderColor.withAlpha(12),
                // Use a neutral color or AppColors.greyHundred
                borderRadius: BorderRadius.circular(AppDimensions.di_5),
                border: Border.all(
                  color: AppColors.textFieldBorderColor, // First border color
                  width: AppDimensions.di_1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ignore: unnecessary_null_comparison
                  initialPosition != null
                      ? SizedBox(
                        width: widget.mapWidth,
                        height: widget.mapHeight,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: FlutterMap(
                            options: MapOptions(
                              onMapReady: () {
                                // Call the onMapReady callback when the map is ready
                                if (widget.onMapReady != null) {
                                  widget.onMapReady!();
                                }
                              },
                              initialCenter: LatLng(
                                widget.latitude!,
                                widget.longitude!,
                              ),
                              initialZoom: 15.0,
                              maxZoom: 18.0,
                              /* onTap: (tapPosition, point) async {

              onPressed: widget.onRefresh,
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(AppDimensions.di_4),
          decoration: BoxDecoration(
            color: AppColors.textFieldBorderColor.withAlpha(12), // Use a neutral color or AppColors.greyHundred
            borderRadius: BorderRadius.circular(AppDimensions.di_5),
            border: Border.all(
              color: AppColors.textFieldBorderColor, // First border color
              width:  AppDimensions.di_1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: unnecessary_null_comparison
              initialPosition != null
                  ? SizedBox(
                width: widget.mapWidth,
                height: widget.mapHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: FlutterMap(
                    options: MapOptions(
                      onMapReady: () {
                        // Call the onMapReady callback when the map is ready
                        if (widget.onMapReady != null) {
                          widget.onMapReady!();
                        }
                      },
                      initialCenter: LatLng(
                          widget.latitude!, widget.longitude!),
                      initialZoom: 15.0,
                      maxZoom: 18.0,
                      onTap: (tapPosition, point) async {
                        var oldPosition = markerPosition;
                        var newPosition = point;

                        if (markerPosition.longitude !=
                            point.longitude &&
                            markerPosition.latitude !=
                                point.latitude) {
                          if (kDebugMode) {
                            log("Old and new position are different");
                          }

                          final distance = distanceCalculator.as(
                              LengthUnit.Meter,
                              newPosition,
                              initialPosition);

                          if (kDebugMode) {
                            log("Distance b/w $oldPosition and $newPosition = $distance");
                          }

                          if (distance >= 0) {
                            if (distance <= allowedRadius) {
                              if (kDebugMode) {
                                log("Distance in allowed radius $allowedRadius");
                              }

                              final placemarks =
                              await placemarkFromCoordinates(
                                point.latitude,
                                point.longitude,
                              );

                              if (kDebugMode) {
                                log("Before state update");
                                log("$markerPosition");
                                log(currentAddress);
                              }

                              setState(() {
                                markerPosition = LatLng(
                                    point.latitude,
                                    point.longitude);
                                currentAddress =
                                '${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea} - ${placemarks.first.postalCode}, ${placemarks.first.country}.';
                              });
                              if (kDebugMode) {
                                log("After state update");
                                log("$markerPosition");
                                log(currentAddress);
                              }
                              widget.onMapTap(point);
                            } else {
                              if (kDebugMode) {
                                log("Distance: $distance  Allowed Radius: $allowedRadius");
                              }

                              // Show message when point is outside the allowed radius
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "The tapped location is outside the allowed radius of $allowedRadius meters."),
                                  backgroundColor: Colors.red,
                                  behavior:
                                  SnackBarBehavior.floating,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          } else {
                            if (kDebugMode) {
                              log("Distance = $distance");
                            }
                            var absoluteDistance = 0 - distance;
                            if (absoluteDistance <= allowedRadius) {
                              // Handle case where absolute distance is within radius (if needed)
                            }
                          }
                        } else {
                          if (kDebugMode) {
                            log("Placement at the same location");
                          }

                          // Show message for tapping the same location
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            SnackBar(
                              content: Text(
                                  "You tapped the same location."),
                              backgroundColor: Colors.orange,
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      interactionOptions: InteractionOptions(
                        enableMultiFingerGestureRace: true,
                        pinchMoveWinGestures: 0,
                        rotationWinGestures: 0,
                      ),*/
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                                userAgentPackageName:
                                    "com.merisadak.app.meri_sadak_ui",
                              ),
                              /* MarkerLayer(
                        markers: [
                          Marker(
                            point: markerPosition,
                            width: 50.0,
                            height: 50.0,
                            child: Icon(
                              Icons.location_pin,
                              color: AppColors.blueGradientColor1,
                              size: 40,
                            ),
                          ),
                        ],

                      ),*/
                              CircleLayer(
                                circles: [
                                  CircleMarker(
                                    point: initialPosition,
                                    // Original center
                                    radius: allowedRadius,
                                    useRadiusInMeter: true,
                                    color: Colors.blue.withAlpha(
                                      (0.09 * 255).toInt(),
                                    ),
                                    borderColor: Colors.black,
                                    borderStrokeWidth: 0.5,
                                  ),
                                ],
                              ),
                              DragMarkers(
                                alignment: Alignment.topCenter,
                                markers: [
                                  DragMarker(
                                    point: markerPosition,
                                    size: Size(40, 40),
                                    // Required size parameter
                                    builder:
                                        (ctx, pos, isDragging) => Icon(
                                          isDragging
                                              ? Icons.edit_location
                                              : Icons.location_on,
                                          size: 50,
                                          color: Colors.red,
                                        ),
                                    onDragUpdate: (details, newPosition) {
                                      setState(() {
                                        markerPosition = newPosition;
                                      });
                                    },
                                    onDragEnd: (details, newPosition) async {
                                      try {
                                        final distance = Distance().as(
                                          LengthUnit.Meter,
                                          newPosition,
                                          initialPosition,
                                        );

                                        final placeMarks =
                                            await placemarkFromCoordinates(
                                              newPosition.latitude,
                                              newPosition.longitude,
                                            );

                                        if (distance <= allowedRadius) {
                                          // Update marker position and fetch address
                                          setState(() {
                                            markerPosition = newPosition;
                                            permissionProvider.address =
                                                '${placeMarks.first.street}, ${placeMarks.first.locality}, ${placeMarks.first.administrativeArea} - ${placeMarks.first.postalCode}, ${placeMarks.first.country}.';
                                          });

                                          widget.onMapTap(newPosition);
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "The dragged location is outside the allowed radius of $allowedRadius meters.",
                                              ),
                                              backgroundColor: Colors.red,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                          final currentPlacemarks =
                                              await placemarkFromCoordinates(
                                                initialPosition.latitude,
                                                initialPosition.longitude,
                                              );

                                          setState(() {
                                            markerPosition = initialPosition;
                                            permissionProvider.address =
                                                '${currentPlacemarks.first.street}, ${currentPlacemarks.first.locality}, ${currentPlacemarks.first.administrativeArea} - ${currentPlacemarks.first.postalCode}, ${currentPlacemarks.first.country}.';
                                          });
                                        }
                                      } catch (e) {
                                        setState(() {
                                          permissionProvider.address =
                                              'Failed to fetch location: ${e.toString()}';
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                      : Text("Map Could not be loaded"),
                  SizedBox(height: 6.0),
                  Container(
                    padding: EdgeInsets.all(AppDimensions.di_4),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppDimensions.di_5),
                      ),
                    ),
                    child: CustomTextWidget(
                      text: permissionProvider.address,
                      fontSize: AppDimensions.di_15,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
        : const Center(child: CircularProgressIndicator(strokeWidth: 2.0));
  }

  void loadLatLongDataOnInit() {
    try {
      final provider = Provider.of<PermissionProvider>(context, listen: false);

      // Safely parse latitude and longitude
      final double lat = double.parse(
        widget.latitude?.toString() ?? '0.0',
      );
      final double lng = double.parse(
        widget.longitude?.toString() ?? '0.0',
      );
      setState(() {
        // Set the marker position if values are valid
        markerPosition = LatLng(lat, lng);
        provider.address = widget.initialAddress;
        initialPosition = LatLng(lat, lng);
      });
      if (kDebugMode) {
        log("Initial Marker Position $initialPosition");
      }
    } catch (e) {
      // Handle parsing error
      markerPosition = LatLng(0.0, 0.0); // Default to (0,0) if parsing fails
    }
  }
}
