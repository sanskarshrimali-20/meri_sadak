import 'package:flutter/material.dart';
import 'package:meri_sadak/utils/device_size.dart';

import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_font_weight.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final double? letterSpacing;
  final int maxlines;
  final TextOverflow textOverflow;

  // Constructor to accept parameters for customization
  const CustomTextWidget({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
    this.textAlign = TextAlign.left, // Default text alignment is left
    this.fontWeight = FontWeight.w400, // Default fontWeight is normal
    this.letterSpacing,
    this.maxlines = 3,this.textOverflow= TextOverflow.ellipsis
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight,),
      textAlign: textAlign,
      overflow: textOverflow,  // Truncate with ellipsis when text overflows
      maxLines: maxlines,
    );
  }
}


//---not used maxline and textoverflow
class CustomTextWithoutFadeWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final double? letterSpacing;

  // Constructor to accept parameters for customization
  const CustomTextWithoutFadeWidget({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
    this.textAlign = TextAlign.left, // Default text alignment is left
    this.fontWeight = FontWeight.w400, // Default fontWeight is normal
    this.letterSpacing,

  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
      textAlign: textAlign,
    );
  }
}

//text with container decoration
class CustomContainerText extends StatelessWidget {
  final String label;
  final double fontSize;
  final Color textColor;
  final Color boxBgColor;


  const CustomContainerText({
    Key? key,
    required this.label,
    required this.fontSize,
    this.textColor = AppColors.black,
    this.boxBgColor =  AppColors.black,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceSize.getScreenWidth(context),
      height: 50,
      padding: const EdgeInsets.all(AppDimensions.di_8),
      decoration: BoxDecoration(
        color: boxBgColor,
        borderRadius: BorderRadius.circular(AppDimensions.di_5),
        border: Border.all(
          color: AppColors.textFieldBorderColor, // First border color
          width: AppDimensions.di_1,
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          //textAlign: TextAlign.start,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: AppFontWeight.fontWeight500,
          ),
        ),
      ),
    );
  }
}
