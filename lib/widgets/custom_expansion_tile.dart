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

  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.subheading,
    required this.content,
    this.imagePath,
    this.initiallyExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2.0,
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ExpansionTile(
            initiallyExpanded: initiallyExpanded,
            shape: RoundedRectangleBorder(
              side: BorderSide.none,
            ),
            title: CustomTextWidget(
              text: title,
              fontSize: AppDimensions.di_16,
              color: AppColors.blackMagicColor,
              fontWeight: AppFontWeight.fontWeight600,
              // textAlign: AppFontSizeWeight.textAlignJustify,
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomTextWidget(
                      text: subheading,
                      fontSize: AppDimensions.di_14,
                      color: AppColors.blackMagicColor,
                      fontWeight: AppFontWeight.fontWeight400,
                      // textAlign: AppFontSizeWeight.textAlignJustify,
                      // letterSpacing: AppFontSizeWeight.letterSpacing_0_5,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    if (imagePath != null) Image.asset(imagePath!) else content,
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
