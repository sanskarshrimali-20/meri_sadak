import 'package:flutter/material.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_font_weight.dart';

class CustomRoadItem extends StatefulWidget {
  final Function(String)? onTap;
  final String roadItem;

  const CustomRoadItem({
    super.key,
    this.onTap, required this. roadItem,
  });

  @override
  State<CustomRoadItem> createState() => _CustomRoadItem();
}

class _CustomRoadItem extends State<CustomRoadItem> {


  @override
  Widget build(BuildContext context) {
    return SizedBox(
         child:  Column(
            children: [
              GestureDetector(
                onTap: () {
                  widget.onTap?.call(widget.roadItem);
                },
                child: Text(
                 widget.roadItem,
                  style: TextStyle(
                    fontSize: AppDimensions.di_20,
                    fontWeight: AppFontWeight.fontWeight500,
                  ),
                ),
              )
            ],
      ),
    );
  }
}
