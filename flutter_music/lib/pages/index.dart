import 'package:flutter/material.dart';
import 'package:flutter_music/global.dart';
import 'package:flutter_music/pages/application.dart';
import 'package:flutter_music/pages/sign_in.dart';
import 'package:flutter_music/pages/welcome.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    //设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(375, 812 - 44 - 34),
        orientation: Orientation.portrait);
    ScreenUtil.init(BoxConstraints());

    return Scaffold(
      body: Global.isFirstOpen == true
          ? WelcomePage()
          : Global.isOfflineLogin == true
              ? ApplicationPage()
              : SignInPage(),
    );
  }
}
