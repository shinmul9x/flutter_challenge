import 'package:base/library.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? toolBarHeight;
  final String? titleText;
  final Widget? title;
  final Widget? leading;
  final Color? backgroundColor;
  final bool centerTitle;
  final List<Widget>? actions;
  final bool showLeading;
  final void Function()? onBack;
  final double? elevation;

  const CustomAppBar({
    Key? key,
    this.toolBarHeight,
    this.titleText,
    this.title,
    this.leading,
    this.backgroundColor,
    this.centerTitle = false,
    this.actions,
    this.showLeading = true,
    this.onBack,
    this.elevation = 0,
  })  : assert(title == null || titleText == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AppBar(
          toolbarHeight: this.toolBarHeight,
          backgroundColor: this.backgroundColor ?? AppColors.white,
          title: this.title ?? _defaultTitles(),
          leading: this.showLeading ? _leading(context) : null,
          centerTitle: this.centerTitle,
          elevation: this.elevation,
          actions: actions,
          titleSpacing: 16.dp,
        ),
        divider(color: AppColors.athensGray),
      ],
    );
  }

  Widget _defaultTitles() {
    return Text(
      this.titleText ?? "",
      style: AppTextTheme.t24W500(),
    );
  }

  Widget _leading(BuildContext context) {
    return this.leading ??
        IconButton(
          icon: SvgAssetIcon(AppImages.icLeftArrow),
          onPressed: () {
            if (onBack != null) {
              onBack?.call();
            } else {
              Get.back();
            }
          },
        );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolBarHeight ?? kToolbarHeight);
}

// class CustomTabViewAppBar extends StatelessWidget
//     implements PreferredSizeWidget {
//   final double? toolBarHeight;
//   final Color? backgroundColor;
//   final int initPosition;
//   final int itemCount;
//   final IndexedWidgetBuilder tabBuilder;
//   final ValueChanged<int>? onPositionChange;

//   const CustomTabViewAppBar({
//     Key? key,
//     this.toolBarHeight,
//     this.backgroundColor,
//     this.initPosition = 0,
//     required this.itemCount,
//     required this.tabBuilder,
//     this.onPositionChange,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       toolbarHeight: this.toolBarHeight,
//       backgroundColor: this.backgroundColor ?? Get.theme.primaryColor,
//       title: Container(
//         child: CustomTabView(
//           initPosition: this.initPosition,
//           isTabScrollable: true,
//           itemCount: this.itemCount,
//           backgroundColor: this.backgroundColor ?? Get.theme.primaryColor,
//           selectedColor: AppColors.nightRider,
//           unselectedLabelColor: AppColors.grey,
//           showIndicator: false,
//           tabBuilder: this.tabBuilder,
//           onPositionChange: onPositionChange,
//           labelStyle: AppTheme.text20W400(),
//           unselectedLabelStyle: AppTheme.text16W500(),
//         ),
//       ),
//       elevation: 0,
//     );
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(toolBarHeight ?? kToolbarHeight);
// }
