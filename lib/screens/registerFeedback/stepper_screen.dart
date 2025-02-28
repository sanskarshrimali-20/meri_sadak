import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:meri_sadak/constants/app_colors.dart';

class IconStepperDemo extends StatefulWidget {
  @override
  _IconStepperDemo createState() => _IconStepperDemo();
}

class _IconStepperDemo extends State<IconStepperDemo> {
  // THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.
  int activeStep = 0; // Initial step set to 5.

  int upperBound = 2; // upperBound MUST BE total number of icons minus 1.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('IconStepper Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ImageStepper(),
              IconStepper(
                activeStepBorderWidth: 0,
                activeStepColor: AppColors.color_E77728,
                activeStepBorderPadding:0.0,
                scrollingDisabled: true,
                enableNextPreviousButtons: false,
                lineLength: 90,

                icons: [
                  Icon(Icons.photo),
                  Icon(Icons.edit_outlined),
                  Icon(Icons.rule_folder),
                ],

                // activeStep property set to activeStep variable defined above.
                activeStep: activeStep,

                // This ensures step-tapping updates the activeStep.
                onStepReached: (index) {
                  setState(() {
                    activeStep = index;
                  });
                },
              ),
              // header(),
              Expanded(
                child: FittedBox(
                  child: Center(
                    child: screens(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  previousButton(),
                  nextButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
        }
      },
      child: Text('Next'),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: Text('Prev'),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$activeStep')
          ),
        ],
      ),
    );
  }

  // Returns the header text based on the activeStep.
  Widget screens() {
    switch (activeStep) {
      case 0:
        return Step1Screen();
      case 1:
        return Step2Screen();
      case 2:
        return Step1Screen();
    }
    return Step1Screen();
  }
}

class Step1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("This is Step 1"),
          Image.asset(
            'assets/images/forget_password_bg.png',
            height: 400,
          ),
        ],
      ),
    );
  }
}

class Step2Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("This is Step 1"),
          Image.asset(
            'assets/images/login_bg.png',
            height: 400,
          ),
        ],
      ),
    );
  }
}