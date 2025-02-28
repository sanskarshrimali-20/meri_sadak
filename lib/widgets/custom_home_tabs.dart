import 'package:flutter/material.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_font_weight.dart';
import '../constants/app_strings.dart';

class CustomHomeTabs extends StatefulWidget {
  final String label;
  final int dataOne;
  final int dataTwo;
  final Function(String, String)? onTap;

  const CustomHomeTabs({
    super.key,
    required this.label,
    this.dataOne = 0,
    this.dataTwo = 0,
    this.onTap,
  });

  @override
  State<CustomHomeTabs> createState() => _CustomHomeTabs();
}

class _CustomHomeTabs extends State<CustomHomeTabs> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Column(
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: AppDimensions.di_20,
                  fontWeight: AppFontWeight.fontWeight500,
                  color: Colors.black
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      widget.onTap?.call(widget.label, AppStrings.newConnectivity);
                    },
                    child: Text(
                      AppStrings.newConnectivity,
                      style: TextStyle(
                        fontSize: AppDimensions.di_18,
                        fontWeight: AppFontWeight.fontWeight400,
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),

                  GestureDetector(
                    onTap: () {
                      widget.onTap?.call(widget.label, AppStrings.upgradation);
                    },
                    child: Text(
                      AppStrings.upgradation,
                      style: TextStyle(
                        fontSize: AppDimensions.di_18,
                        fontWeight: AppFontWeight.fontWeight400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
