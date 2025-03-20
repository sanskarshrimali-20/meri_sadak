import 'package:flutter/material.dart';
import 'package:meri_sadak/constants/app_strings.dart';
import 'package:meri_sadak/utils/device_size.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../widgets/custom_body_with_gradient.dart';

class LegalPolicyScreen extends StatefulWidget {
  const LegalPolicyScreen({super.key});

  @override
  State<LegalPolicyScreen> createState() => _LegalPolicyScreen();
}

class _LegalPolicyScreen extends State<LegalPolicyScreen> {

  final List<String> items = [
    "Usage: By using this government app, you agree to its terms.",
    "Eligibility: For citizens/residents of India only.",
    "User Responsibilities: Provide accurate information; keep credentials secure.",
    "Security: Unauthorized access, hacking, or misuse is prohibited.",
    "Data Collection: Personal and non-personal data may be collected for service improvement and security.",
    "Data Sharing: Shared only with government agencies; no third-party sales.",
    "User Rights: Request data access, correction, or deletion.",
    "Service Availability: May change or be suspended without notice.",
    "Liability: Government of India is not responsible for damages from app use.",
    "Legal Compliance: Governed by the laws of India."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorGainsBoro,
      body: CustomBodyWithGradient(
        title: AppStrings.legalAndPolicies,
        childHeight: DeviceSize.getScreenHeight(context) * 0.7,
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.di_5),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.all(
                Radius.circular(AppDimensions.di_20), // Rounded corners
              ),
            ),

            padding: EdgeInsets.all(AppDimensions.di_13),

            child: SizedBox(
              child:ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("• ", style: TextStyle(fontSize: 18)), // Bullet point
                      Expanded(
                        child: Text(
                          items[index],
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

}
