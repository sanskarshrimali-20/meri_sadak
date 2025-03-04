import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meri_sadak/constants/app_colors.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_font_weight.dart';
import '../constants/app_strings.dart';

class CustomHomeTabs extends StatefulWidget {
  final String label;
  final int dataOne;
  final int dataTwo;
  final String image;
  final Function(String, String)? onTap;

  const CustomHomeTabs({
    super.key,
    required this.label,
    this.dataOne = 0,
    this.dataTwo = 0,
    required this.image,
    this.onTap,
  });

  @override
  State<CustomHomeTabs> createState() => _CustomHomeTabs();
}

class _CustomHomeTabs extends State<CustomHomeTabs> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.di_16),
      decoration: BoxDecoration(
        color: AppColors.color_F3F4F6,
        borderRadius: BorderRadius.all(
          Radius.circular(AppDimensions.di_20), // Rounded corners
        ),
      ),
      child: Row(
        children: [
          // Container to control the image alignment and size
          Container(
            padding: const EdgeInsets.only(top: AppDimensions.di_20),
            child: SvgPicture.asset(
              widget.image, // Path to your image in the assets folder
              fit: BoxFit.cover, // The image will cover the entire container
            ),
          ),

          Spacer(),

          Column(
            children: [
              CustomTextWidget(
                text: widget.label,
                fontSize: AppDimensions.di_16,
                fontWeight: AppFontWeight.fontWeight500,
                color: AppColors.black,
              ),
              SizedBox(height: AppDimensions.di_5),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      widget.onTap?.call(
                        widget.label,
                        AppStrings.newConnectivity,
                      );
                    },
                    child: Column(
                      children: [
                        CustomTextWidget(
                          text: '58',
                          fontSize: AppDimensions.di_30,
                          fontWeight: AppFontWeight.fontWeight600,
                          color: AppColors.black,
                        ),
                        CustomTextWidget(
                          text: AppStrings.newConnectivity,
                          fontSize: AppDimensions.di_12,
                          fontWeight: AppFontWeight.fontWeight500,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: AppDimensions.di_20),
                  SizedBox(
                    height: AppDimensions.di_50,
                    width: AppDimensions.di_5,
                    child: VerticalDivider(
                      thickness: 1.5, // Line thickness
                      color: Colors.black, // Divider color
                    ),
                  ),
                  SizedBox(width: AppDimensions.di_20),

                  GestureDetector(
                    onTap: () {
                      widget.onTap?.call(
                        widget.label,
                        AppStrings.upgradation,
                      );
                    },
                    child: Column(
                      children: [
                        CustomTextWidget(
                          text: '58',
                          fontSize: AppDimensions.di_30,
                          fontWeight: AppFontWeight.fontWeight600,
                          color: AppColors.black,
                        ),
                        CustomTextWidget(
                          text: AppStrings.upgradation,
                          fontSize: AppDimensions.di_12,
                          fontWeight: AppFontWeight.fontWeight500,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
