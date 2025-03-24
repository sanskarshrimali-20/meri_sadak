import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/constants/app_font_weight.dart';

import '../constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String? value;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final int maxLines;
  final int? maxLength;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final String labelText;
  final bool isRequired;
  final bool editable;
  final bool isNumberWithPrefix;
  final double fontSize;
  final String counterText;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    required this.label,
    this.value,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.maxLength,
    this.controller,
    this.readOnly = false,
    this.onTap,
    this.editable = true,
    required this.labelText,
    required this.isRequired,
    this.fontSize = AppDimensions.di_17,
    this.isNumberWithPrefix = false,
    this.counterText = "",
    this.focusNode,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> inputFormatters = [];

    // Set input formatters for numbers
    if (widget.keyboardType == TextInputType.number) {
      if (widget.isNumberWithPrefix) {
        inputFormatters = [
          FilteringTextInputFormatter.allow(RegExp(r'^[9876][0-9]*$')),
          LengthLimitingTextInputFormatter(widget.maxLength),
        ];
      } else {
        inputFormatters = [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          LengthLimitingTextInputFormatter(widget.maxLength),
        ];
      }
    } else if (widget.keyboardType == TextInputType.name) {
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
      ];
    } else if (widget.keyboardType == TextInputType.text) {
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9\a-zA-Z\s\-]')),
      ];
    } else if (widget.keyboardType == TextInputType.multiline) {
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z0-9\s,.'-\/()]+")),
      ];
    }
    //TextInputType.multiline,
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isRequired
            ? Text(
          "*",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        )
            : SizedBox.shrink(),

        Padding(
          padding: const EdgeInsets.only(bottom: AppDimensions.di_12),
          child: Container(
            padding: const EdgeInsets.only(
              left: AppDimensions.di_5,
              right: AppDimensions.di_5,
            ),
            decoration: BoxDecoration(
              color: AppColors.textFieldBorderColor.withAlpha(12),
              // Use a neutral color or AppColors.greyHundred
              borderRadius: BorderRadius.circular(AppDimensions.di_5),
              border: Border.all(
                color: AppColors.textFieldBorderColor, // First border color
                width: AppDimensions.di_1,
              ),
            ),
            child: TextFormField(
              enabled: widget.editable,
              controller: widget.controller,
              focusNode: widget.focusNode,
              onChanged: (value) {
                widget.onChanged?.call(value);
              },
              maxLines: widget.maxLines,
              maxLength: widget.maxLength,
              keyboardType: widget.keyboardType,
              validator: widget.validator,
              readOnly: widget.readOnly,
              onTap: widget.onTap,
              inputFormatters: inputFormatters,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.label,
                hintStyle: TextStyle(
                  color: AppColors.black.withAlpha(90),
                  fontSize: widget.fontSize,
                ),
                //counterText: widget.counterText,
              ),
              buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
                return widget.keyboardType == TextInputType.multiline? Align(
                  alignment: Alignment.bottomRight, // Align to the bottom-right
                  child: Text(
                    "$currentLength/$maxLength",
                    style: TextStyle(
                      fontSize: AppDimensions.di_12, // Adjust the font size
                      color: AppColors.black.withAlpha(100), // Adjust text color if needed
                    ),
                  ),
                ): null;
              },
              style: TextStyle(
                fontSize: widget.fontSize,
                // Adjust the font size here for the text input
                color: AppColors.black, // Adjust text color if needed
              ),
            ),
          ),
        ),
      ],
    );
  }
}
