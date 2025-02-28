import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:meri_sadak/widgets/custom_app_bar.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../widgets/custom_road_item.dart';
import '../roadDetails/road_details_screen.dart';

class RoadListScreen extends StatefulWidget {
  final String label, value;

   const RoadListScreen({super.key, required this.label, required this.value});

  @override
  State<RoadListScreen> createState() => _RoadListScreen();
}

class _RoadListScreen extends State<RoadListScreen> {

  var roadList = ["Road1", "Road2", "Road3"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyHundred,
      appBar: CustomAppBar(
        title: widget.label,
        leadingIcon: ImageAssetsPath.backArrow,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: AppDimensions.di_20),

            Row(
              children: [
                Text(
                  widget.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: AppDimensions.di_20,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(width: 20,),

                Text(
                  widget.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: AppDimensions.di_20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: DeviceSize.getScreenHeight(context)*0.8,
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: roadList.length,
                itemBuilder: (context, index) {
                  return CustomRoadItem( onTap: (value){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> RoadDetailsScreen(label: widget.label, data: value)));
                  }, roadItem: roadList[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
