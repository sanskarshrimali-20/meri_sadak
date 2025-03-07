import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meri_sadak/constants/app_colors.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:meri_sadak/widgets/custom_text_widget.dart';

class ContactUsWidget extends StatelessWidget {
  final String text;
  final String textOne;
  final String textTwo;
  final double fontSize;
  final double fontSizeOne;
  final Color color;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final FontWeight fontWeightOne;
  final double? letterSpacing;
  final int maxlines;
  final String icon;
  final double space;

  // Constructor to accept parameters for customization
  const ContactUsWidget({
    super.key,
    required this.text,
    required this.textOne,
    this.space = 0.0,
    this.textTwo = "",
    this.fontSize = 16,
    this.fontSizeOne = 14,
    this.color = AppColors.black,
    required this.icon,
    this.textAlign = TextAlign.left, // Default text alignment is left
    this.fontWeightOne = FontWeight.w400, // Default fontWeight is normal
    this.fontWeight = FontWeight.w500, // Default fontWeight is normal
    this.letterSpacing,
    this.maxlines = 3,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DeviceSize.getScreenWidth(context)*0.8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the left
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: SvgPicture.asset(icon, fit: BoxFit.fill),
          ),

          SizedBox(width: AppDimensions.di_15,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the left
            children: [
              CustomTextWidget(text: text, fontSize: fontSize, color: color, fontWeight: fontWeight,),
              SizedBox(
                width: DeviceSize.getScreenWidth(context) * 0.6,
                child:CustomTextWidget(text: textOne, fontSize: fontSizeOne, color: color, fontWeight: fontWeightOne, maxlines: maxlines,),
              ),
              CustomTextWidget(text: textTwo, fontSize: fontSizeOne, color: color, fontWeight: fontWeightOne,),
              SizedBox(height: space,)
            ],
          ),
        ],
      ),
    );
  }
}
