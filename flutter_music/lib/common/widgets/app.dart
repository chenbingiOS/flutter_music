import 'package:flutter/material.dart';
import 'package:flutter_music/common/values/values.dart';

/// 透明背景 AppBar
AppBar transparentAppBar({
  required BuildContext context,
  List<Widget>? actions,
  String title = '',
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(title),
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: AppColors.primaryText,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    actions: actions,
  );
}
