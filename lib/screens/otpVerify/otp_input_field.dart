import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../providerData/theme_provider.dart';

class OTPInputField extends StatefulWidget {
  final int length;
  final ValueChanged<String> onCompleted;

  const OTPInputField({super.key, this.length = 6, required this.onCompleted});

  @override
  State<OTPInputField> createState() => _OTPInputFieldState();
}

class _OTPInputFieldState extends State<OTPInputField> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;
  late List<String> otp;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(widget.length, (index) => TextEditingController());
    focusNodes = List.generate(widget.length, (index) => FocusNode());
    otp = List.filled(widget.length, "");
  }

  void _onChanged(String value, int index) {
    otp[index] = value;

    // Move focus to next field when a digit is entered
    if (value.isNotEmpty && index < widget.length - 1) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    }

    // Move focus to previous field if backspace is pressed
    if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }

    // Call onCompleted when all OTP digits are entered
    if (otp.every((digit) => digit.isNotEmpty)) {
      widget.onCompleted(otp.join());
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(widget.length, (index) {
        return SizedBox(
          width: AppDimensions.di_45,
          height: AppDimensions.di_45,
          child: TextFormField(
            style: TextStyle(color: themeProvider.themeMode == ThemeMode.light
                ? AppColors.textColor
                : AppColors.authDarkModeTextColor,),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            maxLength: 1,
            decoration: InputDecoration(
              counterText: "",
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.blueGradientColor1),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0), // Adjust padding
            ),
            cursorColor: AppColors.blueGradientColor1,
            textAlign: TextAlign.center,
            onChanged: (value) => _onChanged(value, index),
            onFieldSubmitted: (value) {
              // Move to next field on submission
              if (index < widget.length - 1) {
                FocusScope.of(context).requestFocus(focusNodes[index + 1]);
              }
            },
          ),
        );
      }),
    );
  }
}

