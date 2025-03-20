import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meri_sadak/constants/app_colors.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';

import 'custom_dialog_button.dart';

class CustomSelectionDialog extends StatelessWidget {
  final String? title;
  final String? icon;
  final String? content;
  final List<String> buttonLabels;
  final List<VoidCallback> onButtonPressed;
  final List<bool> isButtonActive;
  final bool titleVisibility;
  final bool iconVisibility;
  final bool contentVisibility;
  final double? dialogHeight;

  // Constructor
  const CustomSelectionDialog({
    Key? key,
    this.title,
    this.icon,
    this.content,
    required this.buttonLabels,
    required this.onButtonPressed,
    required this.isButtonActive,
    this.titleVisibility = true,
    this.iconVisibility = false,
    this.contentVisibility = true,
    this.dialogHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      contentPadding: EdgeInsets.zero, // Remove default padding from the AlertDialog
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Show the icon if iconVisibility is true
            if (iconVisibility && icon != null)
              ClipRect(
                child: SvgPicture.asset(icon!),
              ),

            // Show title if titleVisibility is true
            if (titleVisibility && title != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomTextWidget(
                  text: title!,
                  fontSize: AppDimensions.di_15,
                  color: AppColors.black.withAlpha(150),
                  fontWeight: AppFontWeight.fontWeight600,
                  textAlign: TextAlign.center,
                ),
              ),

            // Show content if contentVisibility is true and content is not null
            if (contentVisibility && content != null)
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomTextWidget(
                  text: content!,
                  fontSize: AppDimensions.di_15,
                  color: AppColors.black.withAlpha(200),
                  fontWeight: AppFontWeight.fontWeight500,
                  textAlign: TextAlign.center,
                ),
              ),

            SizedBox(height: AppDimensions.di_5),

            // Conditionally show buttons based on the button count in `buttonLabels`
            if (buttonLabels.isNotEmpty)
            for (int i = 0; i < buttonLabels.length; i++)
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                child: CustomDialogButton(
                  text: buttonLabels[i],
                  fontSize: AppDimensions.di_15,
                  onClick: isButtonActive[i] ? onButtonPressed[i] : null, // If button is active, assign onClick callback
                  isActive: isButtonActive[i], // Pass the button active state
                ),
              ),
          ],
        ),
      ),
    );
  }
}
