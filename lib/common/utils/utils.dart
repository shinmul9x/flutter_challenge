import 'package:flutter/material.dart';

import '../../library.dart';

void clearFocus(BuildContext context) =>
    FocusScope.of(context).requestFocus(FocusNode());

Widget space({double? width, double? height}) {
  return SizedBox(
    width: width,
    height: height,
  );
}

Widget divider({
  double height = 1,
  Color? color = AppColors.wildSand,
  double? indent,
  double? endIndent,
}) {
  return Divider(
    height: height,
    thickness: height,
    color: color,
    indent: indent,
    endIndent: endIndent ?? indent,
  );
}
