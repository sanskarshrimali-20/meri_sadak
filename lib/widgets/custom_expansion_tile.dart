import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import '../constants/app_colors.dart';
import 'custom_text_widget.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final String subheading;
  final Widget content;
  final String? imagePath;
  final bool initiallyExpanded;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onTap; // onTap callback

  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.subheading,
    required this.content,
    this.imagePath,
    this.initiallyExpanded = false,
    this.backgroundColor = AppColors.black,
    this.textColor = AppColors.black,
    this.onTap,  // Initialize the onTap callback
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Trigger onTap on any tap inside the widget
      child: Card(
        elevation: 2.0,
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ExpansionTile(
            iconColor: textColor,
            initiallyExpanded: initiallyExpanded,
            shape: RoundedRectangleBorder(
              side: BorderSide.none,
            ),
            title: CustomTextWidget(
              text: title,
              fontSize: AppDimensions.di_16,
              color: textColor,
              fontWeight: AppFontWeight.fontWeight600,
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    subheading == ''
                        ? Container()
                        : CustomTextWidget(
                      text: subheading,
                      fontSize: AppDimensions.di_14,
                      color: textColor,
                      fontWeight: AppFontWeight.fontWeight400,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    if (imagePath != null)
                      Image.asset(imagePath!)
                    else
                      content,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
