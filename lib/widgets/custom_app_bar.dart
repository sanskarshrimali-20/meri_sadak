import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import '../constants/app_colors.dart';
import 'custom_text_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String leadingIcon; // Optional, can be customized
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.leadingIcon,
    this.centerTitle = true, // Default to true, you can change for some screens
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset(
          leadingIcon,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context); // Open the drawer using the GlobalKey
        },
      ),
      backgroundColor: AppColors.blueGradientColor1,//const Color(0xff453CC4),
      title: CustomTextWidget(
        text: title,
        fontSize: AppDimensions.di_24,
        color: AppColors.whiteColor,
        fontWeight: AppFontWeight.fontWeight600,
      ),
      centerTitle: centerTitle,
      iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading:true
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
