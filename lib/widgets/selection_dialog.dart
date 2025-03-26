import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // If you're using SVG icons
import 'package:meri_sadak/widgets/custom_text_widget.dart';

import '../constants/app_dimensions.dart';
import 'custom_dialog_button.dart'; // Assuming this is your custom widget

Future<void> showCustomSelectionDialog({
  required BuildContext context,
  String? title, // Optional title
  String? icon, // Optional icon (if you want to show it)
  String? content, // Optional content (if you want custom content)
  List<String>? buttonLabels, // List of button labels for 1 to 3 buttons
  required List<VoidCallback> onButtonPressed, // List of callback functions for buttons
  required List<bool> isButtonActive, // List of boolean values to determine button activeness
  bool titleVisibility = false, // To show or hide the title
  bool iconVisibility = false, // To show or hide the icon
  double dialogWidth = 300, // Optional width for the dialog, can be customized
  double dialogHeight = 250, // Optional height for the dialog
  Widget? customContent, // Allow passing any custom widget as content
}) async {
  // Show dialog
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white, // Dialog background color
        child: Container(
          width: dialogWidth, // Set the dialog width
          height: dialogHeight, // Set the dialog height
          padding: EdgeInsets.all(16.0), // Padding for the content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // Allow the Column to take as little space as possible
            children: [
              // Show the icon if iconVisibility is true
              if (iconVisibility && icon != null)
                ClipRect(
                  child: SvgPicture.asset(icon!), // Show the icon
                ),

              // Show title if titleVisibility is true
              if (titleVisibility && title != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: CustomTextWidget(
                    text: title!,
                    fontSize: 15.0,
                    color: Colors.black.withAlpha(150),
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                ),

              // Show content if content is available
              if (content != null)
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                  child: CustomTextWidget(
                    text: content!,
                    fontSize: 15.0,
                    color: Colors.black.withAlpha(200),
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                  ),
                ),

              // Allow for custom widget content if provided
              if (customContent != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: customContent, // Custom content passed as widget
                ),

              SizedBox(height: 15.0), // Space between content and buttons

              // Conditionally show buttons based on the button count in `buttonLabels`
              if (buttonLabels != null && buttonLabels.isNotEmpty)
                for (int i = 0; i < buttonLabels.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                    child: CustomDialogButton(
                      text: buttonLabels[i],
                      fontSize: AppDimensions.di_15,
                      onClick:  onButtonPressed[i], // If button is active, assign onClick callback
                      isActive: isButtonActive[i], // Pass the button active state
                    ),
                  ),
            ],
          ),
        ),
      );
    },
  );
}
