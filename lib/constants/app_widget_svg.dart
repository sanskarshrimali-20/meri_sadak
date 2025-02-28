import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const String assetSvgPath = 'assets/images_svg';
final Widget gallerySvg = SvgPicture.asset(
  "$assetSvgPath/gallery.svg",
  semanticsLabel: 'Gallery image',
);
final Widget cameraSvg = SvgPicture.asset(
  "$assetSvgPath/camera.svg",
  semanticsLabel: 'Camera image',
);