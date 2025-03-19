import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UFUSvgImage extends StatelessWidget {
  const UFUSvgImage({
    super.key,
    required this.assetPath,
    this.height,
    this.width
  });

  final String assetPath;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      height: height,
      width: width,
    );
  }
}
