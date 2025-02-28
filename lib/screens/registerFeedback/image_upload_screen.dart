import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_strings.dart';

class ImageFormScreen extends StatefulWidget {
  final int stepIndex;
  final Function(int, bool, bool) isStepCompleted;
  const ImageFormScreen({super.key,required this.stepIndex,
    required this.isStepCompleted,});

  @override
  State<ImageFormScreen> createState() => _ImageFormScreen();
}

class _ImageFormScreen extends State<ImageFormScreen> {

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Text("Screen Second", style: TextStyle(color: Colors.black, fontSize: 40),),
          Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                // Aligns text to the right end
                child: TextButton(
                  onPressed: () {
                    widget.isStepCompleted(
                      widget.stepIndex,
                      false, true
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.di_24,
                      vertical: AppDimensions.di_15,
                    ),
                    // Padding
                    backgroundColor: AppColors.color_E77728,
                    // Background color
                    textStyle: TextStyle(
                      fontSize: AppDimensions.di_18,
                    ), // Text style
                  ),
                  child: Text(
                    AppStrings.previous,
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                ),
              ),

              Spacer(),
              Align(
                alignment: Alignment.centerRight,
                // Aligns text to the right end
                child: TextButton(
                  onPressed: () {
                    widget.isStepCompleted(
                      widget.stepIndex,
                      true, false
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.di_24,
                      vertical: AppDimensions.di_15,
                    ),
                    // Padding
                    backgroundColor: AppColors.color_E77728,
                    // Background color
                    textStyle: TextStyle(
                      fontSize: AppDimensions.di_18,
                    ), // Text style
                  ),
                  child: Text(
                    AppStrings.next,
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                ),
              ),
            ],
          )

        ]
    );
  }
}