import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

class CustomCharCountTextField extends StatelessWidget {
  final String label;
  final String? value;
  final Function(String)? onChanged;
  final VoidCallback? onTapHelp;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final int maxLines;
  final int? maxLength;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final String labelText;
  final bool isRequired;

  const CustomCharCountTextField(
      {super.key,
        required this.label,
        this.value,
        this.onChanged,
        this.validator,
        this.onTapHelp,
        this.keyboardType = TextInputType.text,
        this.maxLines = 1,
        this.maxLength,
        this.controller,
        this.readOnly = false,
        this.onTap,
        required this.labelText,
        required this.isRequired});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(labelText, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(width: AppDimensions.di_5), // Space between text and image
            isRequired == true
                ? Text("*",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.red))
                : SizedBox.shrink(),
            Spacer(),
            GestureDetector(
              onTap: onTapHelp,
              child: Image.asset(
                'assets/images/help.png', width: AppDimensions.di_20, height: AppDimensions.di_20,), // Replace with your image path
            ),
          ],
        ),
        SizedBox(height: AppDimensions.di_8),
        Padding(
          padding: const EdgeInsets.only(bottom: AppDimensions.di_12),
          child: Container(
            padding: const EdgeInsets.all(AppDimensions.di_4),
            decoration: BoxDecoration(
              color: AppColors.greyHundred,
              borderRadius: BorderRadius.circular(AppDimensions.di_12),
            ),
            child: TextFormField(
              controller: controller,
              onChanged: onChanged,
              maxLines: maxLines,
              maxLength: maxLength,
              keyboardType: keyboardType,
              validator: validator,
              readOnly: readOnly,
              onTap: onTap,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r"^[a-zA-Z0-9\s,.'-\/()]+$")),
                // Allow address characters
              ],
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: label,
                border: InputBorder.none,
                filled: true,
                fillColor: AppColors.greyHundred,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
