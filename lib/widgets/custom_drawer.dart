import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meri_sadak/constants/app_colors.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/screens/aboutPmgsy/about_pmgsy.dart';
import 'package:meri_sadak/screens/registerFeedback/register_feedback_screen.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:meri_sadak/widgets/drawer_widget.dart';
import 'custom_base_dialog.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width:
          DeviceSize.getScreenWidth(context) -
          (DeviceSize.getScreenWidth(context) * 0.10),
      child: Column(
        children: [
          // Drawer Header
         /* DrawerHeader(
            decoration: BoxDecoration(color: AppColors.appColor),
            child: SizedBox(
              child: Center(
                child: Text(
                  "Welcome, Sanskar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppDimensions.di_21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),*/

          Container(
            height: AppDimensions.di_200,
            decoration: BoxDecoration(
              color: AppColors.blueGradientColor1
            ),
          ),

          SizedBox(height: AppDimensions.di_12),

          SingleChildScrollView(
            child: Column(
              children: [
                customDrawerWidget(
                  title: AppStrings.home,
                  icon: ImageAssetsPath.home,
                  onClick: () {},
                ),

                Divider(
                  color: Colors.grey, // Line color
                  thickness: AppDimensions.di_1, // Line thickness
                  indent: AppDimensions.di_30, // Space from the left
                  endIndent: AppDimensions.di_30, // Space from the right
                ),

                customDrawerWidget(
                  title: AppStrings.account,
                  icon: ImageAssetsPath.iconPerson,
                  onClick: () {},
                ),

                Divider(
                  color: Colors.grey, // Line color
                  thickness: AppDimensions.di_1, // Line thickness
                  indent: AppDimensions.di_30, // Space from the left
                  endIndent: AppDimensions.di_30, // Space from the right
                ),

                customDrawerWidget(
                  title: AppStrings.settings,
                  icon: ImageAssetsPath.setting,
                  onClick: () {},
                ),

                Divider(
                  color: Colors.grey, // Line color
                  thickness: AppDimensions.di_1, // Line thickness
                  indent: AppDimensions.di_30, // Space from the left
                  endIndent: AppDimensions.di_30, // Space from the right
                ),

                customDrawerWidget(
                  title: AppStrings.contactUs,
                  icon: ImageAssetsPath.mail,
                  onClick: () {},
                ),

                Divider(
                  color: Colors.grey, // Line color
                  thickness: AppDimensions.di_1, // Line thickness
                  indent: AppDimensions.di_30, // Space from the left
                  endIndent: AppDimensions.di_30, // Space from the right
                ),

                customDrawerWidget(
                  title: AppStrings.rateUs,
                  icon: ImageAssetsPath.mail,
                  onClick: () {

                  },
                ),

                Divider(
                  color: Colors.grey, // Line color
                  thickness: AppDimensions.di_1, // Line thickness
                  indent: AppDimensions.di_30, // Space from the left
                  endIndent: AppDimensions.di_30, // Space from the right
                ),

                customDrawerWidget(
                  title: AppStrings.share,
                  icon: ImageAssetsPath.mail,
                  onClick: () {
                    showBaseDialog();
                  },
                ),

                Divider(
                  color: Colors.grey, // Line color
                  thickness: AppDimensions.di_1, // Line thickness
                  indent: AppDimensions.di_30, // Space from the left
                  endIndent: AppDimensions.di_30, // Space from the right
                ),

                customDrawerWidget(
                  title: AppStrings.about,
                  icon: ImageAssetsPath.info,
                  onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AboutPMGSY()),
                    );
                  },
                ),
              ],
            ),
          ),

          Spacer(), // Push Logout to the bottom of the drawer
          // Logout Button
          ListTile(
            leading: SvgPicture.asset(
              ImageAssetsPath.logout,
              color: Colors.red,
            ),
            title: Text(AppStrings.logout, style: TextStyle(color: Colors.red)),

            onTap: () async {
              /* Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );*/
            },
          ),

          /* ListTile(
            leading: Icon(Icons.refresh_outlined, color: Colors.blue),
            title: Text('Master Data'), */
          /*CustomTextWidget(
              text: 'Master Data',
              fontWeight: FontWeight.bold,
              color: Colors
                  .blue, // This will now correctly set the text color to red,
            ),*/
          /*
            onTap: () {
              */
          /*final masterDataViewModel = context.read<MasterDataViewModel>();
              masterDataViewModel
                  .fetchMasterData(refreshDB: true)
                  .then((value) {
                if (kDebugMode) {
                  log("Fetch master data status $value");
                }
              }).catchError((error) {
                if (kDebugMode) {
                  log("error while fetching master data");
                  debugPrint(error);
                }
              });*/
          /*
            },
          ),

          ListTile(
            leading: Icon(Icons.upload_file_outlined, color: Colors.blue,),
            title:Text('Upload Log File'), */
          /*CustomTextWidget(
              text: 'Upload Log File',
              fontWeight: FontWeight.bold,
              color: Colors
                  .blue, // This will now correctly set the text color to red,
            ),*/
          /*
            onTap: () {

            },
          )*/
        ],
      ),
    );
  }

  void showBaseDialog() {
    showCustomBaseDialog(
      context: context,
      title: AppStrings.welcome,
      content: AppStrings.meriSadakApplication,
      icon: ImageAssetsPath.dialogIcon,
      iconVisibility: true,
      onYesPressed: () async {},
    );
  }
}
