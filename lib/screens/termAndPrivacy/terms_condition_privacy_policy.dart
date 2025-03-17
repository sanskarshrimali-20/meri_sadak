import 'package:flutter/material.dart';

import '../../constants/app_image_path.dart';

class TermsConditionPrivacyPolicyScreen extends StatefulWidget{
  const TermsConditionPrivacyPolicyScreen({super.key});

  @override
  State<TermsConditionPrivacyPolicyScreen> createState()  => _TermsConditionPrivacyPolicyScreen();
}

class _TermsConditionPrivacyPolicyScreen extends State<TermsConditionPrivacyPolicyScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SizedBox.expand(
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset(
            ImageAssetsPath.tAndCScreen,
            fit: BoxFit.cover, // This will ensure the image covers the whole screen
          ),
        ),
      ),
    );
  }
}