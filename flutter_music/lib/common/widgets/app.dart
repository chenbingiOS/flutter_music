import 'package:flutter/material.dart';
import 'package:flutter_music/common/values/values.dart';

/// 透明背景 AppBar
AppBar transparentAppBar({
  required BuildContext context,
  Widget? title,
  Widget? leading,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: title,
    leading: leading == null
        ? IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.primaryText,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        : Container(),
    actions: actions,
  );
}
