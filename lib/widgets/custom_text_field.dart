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
    this.isNumberWithPrefix = false,
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
    }
    else if(widget.keyboardType == TextInputType.name){
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),];
    }
    else if(widget.keyboardType == TextInputType.text){
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s\-]')),];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

            widget.isRequired
                ? Text("*", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red))
                : SizedBox.shrink(),

        Padding(
          padding: const EdgeInsets.only(bottom: AppDimensions.di_12),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.textFieldColor.withAlpha(8), // Use a neutral color or AppColors.greyHundred
              borderRadius: BorderRadius.circular(AppDimensions.di_5),
              border: Border.all(
                color: AppColors.textFieldBorderColor, // First border color
                width:  AppDimensions.di_1,
              ),
            ),
            child: TextFormField(
              enabled: widget.editable,
              controller: widget.controller,
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
                filled: true,
                fillColor:  AppColors.textFieldColor.withAlpha(8), // Use a neutral color or AppColors.greyHundred
                border: InputBorder.none,
                hintText: widget.label,
                hintStyle: TextStyle(color: AppColors.black.withAlpha(90), fontSize: AppDimensions.di_17, fontWeight: AppFontWeight.fontWeight400),
                counterText: "",
                // errorText: errorText, // Display error message here
              ),
            ),
          ),
        ),
      ],
    );
  }
}
