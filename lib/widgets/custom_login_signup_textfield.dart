import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import '../constants/app_dimensions.dart';

class CustomLoginSignupTextFieldWidget extends StatefulWidget {
  final TextEditingController textEditController;
  final String hintText;
  final String icon;
  final bool showSuffixIcon; // Boolean to control suffix icon visibility
  final bool changeSuffixIcon; // Boolean to change the suffix icon
  final int maxlength;
  final Function(String)? onChanged;


  const CustomLoginSignupTextFieldWidget({
    Key? key,
    required this.textEditController,
    required this.hintText,
    required this.icon,
    this.onChanged,
    this.showSuffixIcon = false, // Default value is true
    this.changeSuffixIcon = false, // Default value is false
    this.maxlength = 6, // Default value is false
  }) : super(key: key);

  @override
  _CustomLoginSignupTextFieldWidgetState createState() =>
      _CustomLoginSignupTextFieldWidgetState();
}

class _CustomLoginSignupTextFieldWidgetState
    extends State<CustomLoginSignupTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        widget.onChanged?.call(value);
      },
      keyboardType: TextInputType.name,
      controller: widget.textEditController,
      maxLines: 1,
      style: const TextStyle(color: Colors.black),
      maxLength: widget.maxlength,
      decoration: InputDecoration(
        fillColor: Colors.white.withAlpha(200),
        filled: true,
        counterText: "",
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.black54, fontSize: AppDimensions.di_16),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(AppDimensions.di_10),
          child: SvgPicture.asset(
            widget.icon, // Path to the custom icon image
          ),
        ),
        suffixIcon: widget.showSuffixIcon
            ? Padding(
          padding: const EdgeInsets.all(AppDimensions.di_10),
          child: SvgPicture.asset(
            widget.changeSuffixIcon
                ? ImageAssetsPath.checkCircle // The new icon if the boolean is true
                : ImageAssetsPath.deleteImage, // Default icon
          ),
        )
            : null,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black), // Focused border color
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // Enabled border color
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // Disabled border color
        ),
      ),
    );
  }
}
