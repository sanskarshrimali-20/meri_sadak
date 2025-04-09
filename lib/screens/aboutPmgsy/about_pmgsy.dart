import 'package:flutter/material.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_image_path.dart';
import '../../constants/app_strings.dart';
import '../../providerData/permission_provider.dart';
import '../../providerData/theme_provider.dart';
import '../../widgets/custom_body_with_gradient.dart';
import '../../widgets/custom_carousel_slider.dart';
import '../../widgets/custom_expansion_tile.dart';
import '../location/location_widget.dart';

class AboutPMGSY extends StatefulWidget {
  const AboutPMGSY({super.key});

  @override
  State<AboutPMGSY> createState() => _AboutPMGSYState();
}

class _AboutPMGSYState extends State<AboutPMGSY> {
  List<String> imageList = [
    ImageAssetsPath.pmgsyBanner,
    ImageAssetsPath.pmgsyBanner,
    ImageAssetsPath.pmgsyBanner,
  ];

  @override
  void initState() {
    super.initState();
    _initializePermissionProvider();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PermissionProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.light
          ? AppColors.bgColorGainsBoro
          : AppColors.bgDarkModeColor,
      body: CustomBodyWithGradient(
        title: AppStrings.aboutTitle,
        childHeight: DeviceSize.getScreenHeight(context) * 0.85,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Carousel Slider
              CustomCarouselSlider(
                imageList: [
                  ImageAssetsPath.pmgsyBanner,
                  ImageAssetsPath.pmgsyBannerOne,
                  ImageAssetsPath.pmgsyBannerTwo,
                  ImageAssetsPath.pmgsyBannerThree,
                ],
              ),

              // Use CustomExpansionTile for "About PMGSY"
              SizedBox(height: 10,),
              CustomExpansionTile(
                title: AppStrings.aboutPMGSYHeading,
                subheading: AppStrings.aboutPMGSYSubHeading,
                content:
                Container(), // Content can be empty or add custom widgets here
                initiallyExpanded: true,
                backgroundColor: themeProvider.themeMode == ThemeMode.light
                    ? AppColors.whiteColor
                    : AppColors.boxDarkModeColor,
                textColor: themeProvider.themeMode == ThemeMode.light
                    ? AppColors.black
                    : AppColors.whiteColor,
              ),

              // Use CustomExpansionTile for "How to identify PMGSY Roads"
              CustomExpansionTile(
                title: AppStrings.aboutPMGSYRoadIdentifyHeading,
                subheading: AppStrings.aboutPMGSYRoadIdentifySubHeading,
                content: Image.asset(ImageAssetsPath.pmgsyAndPmgsySignBoards),
                imagePath: ImageAssetsPath.pmgsyAndPmgsySignBoards,
                backgroundColor: themeProvider.themeMode == ThemeMode.light
                    ? AppColors.whiteColor
                    : AppColors.boxDarkModeColor,
                textColor: themeProvider.themeMode == ThemeMode.light
                    ? AppColors.black
                    : AppColors.whiteColor,
              ),

              // Use CustomExpansionTile for "Find Nearby PMGSY Roads"
              CustomExpansionTile(
                title: AppStrings.aboutPMGSYRoadNearbyHeading,
                subheading: provider.address.toString(),
                backgroundColor: themeProvider.themeMode == ThemeMode.light
                    ? AppColors.whiteColor
                    : AppColors.boxDarkModeColor,
                textColor: themeProvider.themeMode == ThemeMode.light
                    ? AppColors.black
                    : AppColors.whiteColor,
                content: provider.isLoading
                    ? Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator())
                    : CustomLocationWidget(
                  labelText: 'Current Location:',
                  isRequired: true,
                  latitude: provider.latitude,
                  longitude: provider.longitude,
                  initialAddress: provider.address.toString(),
                  isLoading: provider.isLoading,
                  mapHeight: DeviceSize.getScreenHeight(context) * 0.5,
                  mapWidth: DeviceSize.getScreenWidth(context) * 0.8,
                  onRefresh: () async {
                    await provider.fetchCurrentLocation();
                  },
                  onMapTap: (point) async {
                    await provider.setLocation(
                        point.latitude, point.longitude);
                  }, onMapReady: () {  },

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _initializePermissionProvider() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Initialize permissionProvider after the widget is built
      final provider = Provider.of<PermissionProvider>(context, listen: false);
      // Ensure permissionProvider is available
      await provider.requestLocationPermission();
      await provider.fetchCurrentLocation();
        });
  }
}
