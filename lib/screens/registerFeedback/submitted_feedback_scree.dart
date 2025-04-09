import 'package:flutter/material.dart';

import '../../constants/app_image_path.dart';
import '../home/home_screen.dart';

class SubmittedFeedbackScree extends StatefulWidget {
  const SubmittedFeedbackScree({super.key});

  @override
  State<SubmittedFeedbackScree> createState() => _SubmittedFeedbackScreeState();
}

class _SubmittedFeedbackScreeState extends State<SubmittedFeedbackScree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
    );
  }
}
