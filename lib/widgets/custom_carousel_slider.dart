import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

class CustomCarouselSlider extends StatefulWidget {
  final List<String> imageList; // List of image paths for carousel
  final double height; // Height of the carousel
  final bool autoPlay; // Whether the carousel should autoplay
  final double aspectRatio; // Aspect ratio of the carousel
  final double viewportFraction; // Fraction of the carousel that is visible
  final Color activeDotColor; // Active dot color for the indicator

  const CustomCarouselSlider({
    super.key,
    required this.imageList,
    this.height = 237,
    this.autoPlay = true,
    this.aspectRatio = 16 / 9,
    this.viewportFraction = 1.0,
    this.activeDotColor = AppColors.blueGradientColor1,
  });

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int _currentIndex = 0; // Track the current index of the carousel

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Carousel Slider
         CarouselSlider(
            items: widget.imageList.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      item,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: widget.height,
              enlargeCenterPage: true,
              autoPlay: widget.autoPlay,
              aspectRatio: widget.aspectRatio,
              viewportFraction: widget.viewportFraction,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index; // Update current index when page changes
                });
              },
            ),
          ),

        // Dots Indicator
        DotsIndicator(
          dotsCount: widget.imageList.length,
          position: _currentIndex.toDouble(),
          decorator: DotsDecorator(
            activeColor: widget.activeDotColor,
            activeShape: BeveledRectangleBorder(),
            activeSize: Size(20, 4.0),
            shape: BeveledRectangleBorder(),
            size: Size(20, 4.0),
          ),
        ),
      ],
    );
  }
}
