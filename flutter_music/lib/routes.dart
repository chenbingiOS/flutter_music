import 'package:flutter_music/pages/application.dart';
import 'package:flutter_music/pages/sign_in.dart';
import 'package:flutter_music/pages/sign_up.dart';

/// 静态路由
var staticRoutes = {
  "/sign-in": (context) => SignInPage(),
  "/sign-up": (context) => SignUpPage(),
  "/app": (context) => ApplicationPage(), // 主程序
};
