import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meri_sadak/constants/app_dimensions.dart';
import 'package:meri_sadak/constants/app_image_path.dart';
import 'package:meri_sadak/screens/registerFeedback/feedback_form_screen.dart';
import 'package:meri_sadak/screens/registerFeedback/submit_feedback_screen.dart';
import 'package:meri_sadak/screens/registerFeedback/upload_image_screen.dart';
import 'package:meri_sadak/utils/device_size.dart';
import 'package:sadja_progress_stepper/sadja_progress_stepper.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body_with_gradient.dart';

class RegisterFeedbackScreen extends StatefulWidget {
  const RegisterFeedbackScreen({super.key});

  @override
  State<RegisterFeedbackScreen> createState() => _RegisterFeedbackScreen();
}

class _RegisterFeedbackScreen extends State<RegisterFeedbackScreen> {
  int _currentStep = 0;
  List<int> _completedSteps = [];
  late List<StepItem> steps;

  isStepCompleted(int index, bool isStepCompleted, bool goBack) {
    if (index < 0 || index > 3) {
      return;
    }

    List<int> updatedSteps = List.from(_completedSteps);

    if (!isStepCompleted) {
      if (updatedSteps.remove(index)) {
        setState(() {
          _completedSteps = updatedSteps;
        });
      }
      return;
    }

    if (!updatedSteps.contains(index)) {
      updatedSteps.add(index);
      updatedSteps.sort();
    }

    int newCurrentStep =
        (updatedSteps.last + 1 < steps.length - 1) && (index >= 0)
            ? updatedSteps.last + 1
            : steps.length - 1;

    setState(() {
      _completedSteps = updatedSteps;
    });

    changeCurrentStep(newCurrentStep);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ✅ Check if all steps are already completed (e.g., from API or DB)
      if (_completedSteps.length == steps.length) {
        Future.delayed(Duration.zero, () => _showUploadDialog());
      }
    });
  }

  void _showUploadDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("All Steps Completed"),
            content: Text("Your information is ready to upload."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
    );
  }

  void changeCurrentStep(int stepValue) {
    if (stepValue < 0 || stepValue > 3) {
      if (kDebugMode) {
        print("Step value out of bounds");
      }
    }
    setState(() {
      _currentStep = stepValue;
    });
  }

  @override
  void initState() {
    steps = [
      StepItem(
        text: AppStrings.uploadImages,
        icon: Icons.photo,
        content: UploadImageScreen(
          stepIndex: 0,
          isStepCompleted: isStepCompleted,
        ),
      ),
      StepItem(
        text: AppStrings.fillDetails,
        icon: Icons.edit,
        content: FeedbackFormScreen(
          stepIndex: 1,
          isStepCompleted: isStepCompleted,
        ),
      ),
      StepItem(
        text: AppStrings.submit,
        icon: Icons.save,
        content: SubmitFeedbackScreen(
          stepIndex: 2,
          isStepCompleted: isStepCompleted,
        ),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorGainsBoro,
      appBar: CustomAppBar(
        title: AppStrings.registerFeedback,
        leadingIcon: ImageAssetsPath.backArrow,
      ),
      body: CustomBodyWithGradient(
        child: SizedBox(
          height: DeviceSize.getScreenHeight(context),
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.di_5),
            child: Container(
              height: DeviceSize.getScreenHeight(context),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimensions.di_20), // Rounded corners
                ),
              ),

              padding: EdgeInsets.all(AppDimensions.di_15),

              child: SizedBox(
                height: DeviceSize.getScreenHeight(context) * 0.80,
                child: SadjaProgressStepper(
                  activeIconColor: AppColors.whiteColor,
                  incompleteIconColor: AppColors.black,
                  key: ValueKey("$_currentStep $_completedSteps"),
                  steps: steps,
                  currentStep: _currentStep,
                  // Optional, default is 0
                  completedSteps: _completedSteps,
                  activeStepColor: AppColors.color_E77728,
                  completedStepColor: AppColors.color_E77728,
                  activeLineColor: Colors.grey,
                  incompleteLineColor: Colors.grey,
                  completedLineColor: AppColors.color_E77728,
                  incompleteStepColor: Colors.grey,
                  onStepTapped: (step) => changeCurrentStep(step),
                  completedIconColor: AppColors.whiteColor,
                  activeTextColor: AppColors.black,
                  completedTextColor: AppColors.textFieldBorderColor,
                  incompleteTextColor: AppColors.textFieldBorderColor, //
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
