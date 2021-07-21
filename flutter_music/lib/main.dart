import 'package:flutter/material.dart';
import 'package:flutter_music/common/provider/app_provider.dart';
import 'package:flutter_music/global.dart';
import 'package:flutter_music/pages/index.dart';
import 'package:flutter_music/routes.dart';
import 'package:provider/provider.dart';

void main() => Global.init().then(
      (e) => runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AppState>.value(
              value: Global.appState,
            ),
          ],
          child: Consumer<AppState>(
            builder: (context, appState, _) {
              if (appState.isGrayFilter) {
                return ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.white,
                    BlendMode.color,
                  ),
                  child: MyApp(),
                );
              } else {
                return MyApp();
              }
            },
          ),
        ),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ducafecat.tech',
      home: IndexPage(),
      routes: staticRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
