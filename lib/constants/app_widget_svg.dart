import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const String assetSvgPath = 'assets/images';
final Widget gallerySvg = SvgPicture.asset(
  "$assetSvgPath/gallery_icon.svg",
  semanticsLabel: 'Gallery image',
);
final Widget cameraSvg = SvgPicture.asset(
  "$assetSvgPath/camera_icon.svg",
  semanticsLabel: 'Camera image',
);