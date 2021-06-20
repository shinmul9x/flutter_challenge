import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgAssetIcon extends StatelessWidget {
  final double iconSize;
  final Alignment alignment;
  final Color? color;
  final EdgeInsetsGeometry padding;
  final String assetName;

  SvgAssetIcon(
    this.assetName, {
    Key? key,
    this.iconSize = 24.0,
    this.alignment = Alignment.center,
    this.color,
    this.padding = const EdgeInsets.all(4.0),
  }) : super(key: key);

  // factory IconSvg.box({
  //   Key? key,
  //   double iconSize = 24.0,
  //   Alignment alignment = Alignment.center,
  //   Color? color,
  //   EdgeInsetsGeometry padding = const EdgeInsets.all(4.0),
  //   Widget? icon,
  //   Decoration? decoration,
  // }) =>
  //     _IconSvgBox(
  //       key: key,
  //       iconSize: iconSize,
  //       alignment: alignment,
  //       color: color,
  //       padding: padding,
  //       icon: icon,
  //       decoration: decoration,
  //     );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: SizedBox(
        height: iconSize,
        width: iconSize,
        child: Align(
          alignment: alignment,
          child: IconTheme.merge(
            child: SvgPicture.asset(assetName, color: color),
            data: IconThemeData(
              size: iconSize,
              // color: color,
            ),
          ),
        ),
      ),
    );
  }
}

// class _IconSvgBox extends IconSvg {
//   final double iconSize;
//   final Alignment alignment;
//   final Color? color;
//   final EdgeInsetsGeometry padding;
//   final Widget? icon;
//   final Decoration? decoration;

//   _IconSvgBox({
//     Key? key,
//     this.iconSize = 24.0,
//     this.alignment = Alignment.center,
//     this.color,
//     this.padding = const EdgeInsets.all(4.0),
//     @required this.icon,
//     this.decoration,
//   });

//   @override
//   Widget build(BuildContext context) {
//     var decoration = this.decoration ??
//         BoxDecoration(
//           color: AppColors.white,
//           borderRadius: BorderRadius.circular(Dimens.dimen4),
//           border: Border.all(color: AppColors.platinum),
//         );
//     return Container(
//       padding: padding,
//       decoration: decoration,
//       child: SizedBox(
//         height: iconSize,
//         width: iconSize,
//         child: Align(
//           alignment: alignment,
//           child: IconTheme.merge(
//             data: IconThemeData(
//               size: iconSize,
//               color: color,
//             ),
//             child: icon ?? Container(),
//           ),
//         ),
//       ),
//     );
//   }
// }