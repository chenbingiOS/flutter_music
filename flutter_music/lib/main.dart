import 'package:flutter/material.dart';
import 'package:flutter_music/global.dart';
import 'package:flutter_music/pages/welcome.dart';
import 'package:flutter_music/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main(List<String> args) => Global.init().then((value) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812 - 44 - 34),
      builder: () => MaterialApp(
        title: 'Material App',
        home: WelcomePage(),
        routes: staticRoutes,
      ),
    );
  }
}
