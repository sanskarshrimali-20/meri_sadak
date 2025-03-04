import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const String assetSvgPath = 'assets/images';
final Widget gallerySvg = SvgPicture.asset(
  "$assetSvgPath/gallery_select.svg",
  semanticsLabel: 'Gallery image',
);
final Widget cameraSvg = SvgPicture.asset(
  "$assetSvgPath/camera.svg",
  semanticsLabel: 'Camera image',
);