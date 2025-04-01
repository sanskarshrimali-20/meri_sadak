import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meri_sadak/constants/app_colors.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/constants/app_image_path.dart';

class MyAppBar {
  static AppBar buildAppBar(
      String titleName, String subtitle, bool automaticallyImplyLeadingCheck, BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset(
          ImageAssetsPath.drawerIcon,
          width: AppDimensions.di_20,
          height: AppDimensions.di_20,
          color: AppColors.whiteColor,
        ),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer(); // Open the drawer using the GlobalKey
        },
      ),
      automaticallyImplyLeading: automaticallyImplyLeadingCheck, // Set this to false since you're using a custom leading icon
      iconTheme: IconThemeData(color: Colors.white),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            titleName,
            style: TextStyle(
                fontSize: AppDimensions.di_21,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontFamily: 'Montserrat',
                letterSpacing: 1.5),
          ),
          Text(
            subtitle ?? '',
            style: TextStyle(
              fontSize: AppDimensions.di_14,
              fontWeight: FontWeight.w400,
              color: Colors.white70,
              fontFamily: 'Montserrat',
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssetsPath.headerBg), // Provide the path to your image
            fit: BoxFit.cover, // Ensures the image covers the AppBar space
            alignment: Alignment.center, // Adjusts the alignment of the image (if needed)
          ),
        ),
      ),
    );
  }
}
