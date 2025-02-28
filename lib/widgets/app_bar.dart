import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meri_sadak/constants/app_colors.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/constants/app_image_path.dart';

class MyAppBar {
  static AppBar buildAppBar(
      String titleName, String subtitle, bool automaticallyImplyLeadingCheck,BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset(
          ImageAssetsPath.drawerIcon,
          width: AppDimensions.di_30,
          height:  AppDimensions.di_30,
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
                fontSize:  AppDimensions.di_21,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontFamily: 'Montserrat',
                letterSpacing: 1.5),
          ),
          if (subtitle != null)
            Text(
              subtitle ?? '',
              style: TextStyle(
                fontSize:  AppDimensions.di_14,
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
          gradient: LinearGradient(
            colors: [
              AppColors.appColor
                  .withAlpha((0.9 * 255).toInt()),
              const Color(0xFF211D5E),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}

