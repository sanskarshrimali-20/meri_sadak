import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';

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
        Row(
          children: [
            Text(widget.labelText,
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(width: AppDimensions.di_5),
            widget.isRequired
                ? Text("*", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red))
                : SizedBox.shrink(),
          ],
        ),
        SizedBox(height: AppDimensions.di_8),
        Padding(
          padding: const EdgeInsets.only(bottom: AppDimensions.di_12),
          child: Container(
            padding: const EdgeInsets.all(AppDimensions.di_4),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(AppDimensions.di_12),
            ),
            child: TextFormField(
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
                hintText: widget.label,
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey[200],
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
