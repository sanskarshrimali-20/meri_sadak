import 'package:flutter/material.dart';

// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import '../constants/app_dimensions.dart';

class CustomLoginSignupTextFieldWidget extends StatefulWidget {
  final String hintText;
  final String icon;
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
  final String? errorText;
  final String? fieldTypeCheck;

  CustomLoginSignupTextFieldWidget({
    required this.hintText,
    required this.icon,
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
    this.errorText,
    this.fieldTypeCheck,
  });

  @override
  State<CustomLoginSignupTextFieldWidget> createState() =>
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
  List<TextInputFormatter> inputFormatters = [];

  // No need to track current/old controller values manually String? errorText;
  @override
  Widget build(BuildContext context) {
    // Assuming `widget.controller` is your TextEditingController
    String text =
        widget.controller?.text ??
        ""; // Get text from controller, default to empty string if null

    // Check the length of the text and set the maxLength accordingly
    int maxLength =
        (text.length == 10 && RegExp(r'^[0-9]{10}$').hasMatch(text)) ? 10 : 25;

    print("controller: ${widget.controller?.text.toString()}");
    print("Max length is: $maxLength");

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
        // Allow letters for name
      ];
    } else if (widget.keyboardType == TextInputType.text) {
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s\-]')),
        // Allow text with spaces and hyphens
      ];
    } else if (widget.fieldTypeCheck == 'phoneEmail') {
      setState(() {
        inputFormatters = [
          // Allow characters valid for both email and phone number
          // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._+-]')),
          // This regex allows letters, numbers, @, ., _, +, and -

          // Also allow numbers that are specific for phone number format
          // FilteringTextInputFormatter.allow(RegExp(r'^[6789][0-9]{9}$')), // Phone number starts with 6, 7, 8, or 9 and 10 digits total

          /* FilteringTextInputFormatter.allow(
            RegExp(r'^[a-zA-Z0-9@._+\-]+$|^[6789][0-9]{9}$'),
          ),*/
          FilteringTextInputFormatter.allow(
            RegExp(r'^[a-zA-Z0-9@._+\-]*$|^[6789][0-9]{9}$'),
          ),
        ];
      });
    }
    print("inputFormatters: ${inputFormatters}");

    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      maxLines: widget.maxLines,
      maxLength: maxLength == 10 ? 10 : widget.maxLength,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      inputFormatters: inputFormatters,
      //textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        fillColor: Colors.white.withAlpha(200),
        // Darken the fill color
        filled: true,
        counterText: "",
        hintText: widget.hintText,
        errorText: widget.errorText,
        errorMaxLines: 3,
        // Allow up to 3 lines for error text
        hintStyle: const TextStyle(
          color: Colors.black54,
          fontSize: AppDimensions.di_17,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(AppDimensions.di_8),
          child: SvgPicture.asset(
            widget.icon, // Path to the custom icon image
            width: AppDimensions.di_24, // Adjust the width of the image
            height: AppDimensions.di_24, // Adjust the height of the image
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ), // Change focused border color
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ), // Change enabled border color
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ), // Change disabled border color
        ),
      ),
    );
  }
}

/*

Widget customLoginSignupTextFieldWidget( {required TextEditingController textEditController, required String hintText, required String icon,String? Function(String?)? validator}) {
  return TextFormField(
    keyboardType: TextInputType.name,
    controller: textEditController,
    //maxLines: 1,
    style: const TextStyle(color: Colors.black),
   // maxLength: 1,
    decoration: InputDecoration(
      fillColor: Colors.white.withAlpha(200), // Darken the fill color
      filled: true,
      counterText: "",
      hintText:  hintText,
      hintStyle: const TextStyle(color: Colors.black54, fontSize: AppDimensions.di_17),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(AppDimensions.di_8),
        child: SvgPicture.asset(
          icon,  // Path to the custom icon image
          width: AppDimensions.di_24, // Adjust the width of the image
          height: AppDimensions.di_24, // Adjust the height of the image
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black), // Change focused border color
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey), // Change enabled border color
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey), // Change disabled border color
      ),
    ),
    validator: validator,
  );
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
*/
