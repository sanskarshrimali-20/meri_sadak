import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/utils/device_size.dart';
import '../constants/app_colors.dart';
import '../constants/app_font_weight.dart';
import '../constants/app_image_path.dart';
import 'custom_text_widget.dart';

class CustomBodyWithGradient extends StatelessWidget {
  final Widget child; // Content to be displayed below the gradient
  final double childHeight; // Custom height for the child
  final double topSpacing; // Custom top spacing
  final String title;

  const CustomBodyWithGradient({
    super.key,
    required this.child,
    required this.childHeight,
    this.topSpacing = 10.0, // Default top spacing if not passed
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Positioned Gradient Background
        Positioned(
          width: DeviceSize.getScreenWidth(context),
          child: Image.asset(
            ImageAssetsPath.headerBg, // Your image asset
            fit: BoxFit.cover, // Makes the image cover the AppBar
            width: DeviceSize.getScreenWidth(context),
          ),
        ),
        // Custom AppBar with Leading and Title
        Positioned(
          top: topSpacing, // Adjust this to control the spacing from the top
          left: 0,
          right: 0,
          child: AppBar(
            automaticallyImplyLeading: false, // Disable default back button
            backgroundColor: Colors.transparent, // Transparent to show image
            elevation: 0, // Remove shadow
            title: CustomTextWidget(
              text: title,
              fontSize: AppDimensions.di_22,
              color: AppColors.whiteColor,
              fontWeight: AppFontWeight.fontWeight600,
            ),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white),
            leading: IconButton(
              icon: SvgPicture.asset(
                ImageAssetsPath.backArrow,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context); // Pop the current screen
              },
            ),
          ),
        ),
        // Content of the screen (received as the child widget)
        Positioned(
          width: DeviceSize.getScreenWidth(context),
          // Use kToolbarHeight to ensure content starts below the AppBar
          // top: topSpacing + kToolbarHeight + childHeight + AppDimensions.di_16,
          child: Padding(
            padding: const EdgeInsets.only(top: AppDimensions.di_80),
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.di_16),
              child: SizedBox(
                height: childHeight, // Custom height for the child
                child: child, // Here we render the passed child widget

              ),
            ),
          ),
        ),
        // Third Positioned widget (space from top after content)
        // Positioned(
        //   // Adjust for the space you want for the third widget
        //   top: topSpacing + kToolbarHeight + childHeight + AppDimensions.di_16,
        //   left: 0,
        //   right: 0,
        //   child: Container(
        //     height: 100, // Set the height for your third widget here
        //     color: Colors.blue, // Example background color
        //     child: Center(child: Text("Third Widget")),
        //   ),
        // ),
      ],
    );
  }
}

