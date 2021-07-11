import 'package:flutter/material.dart';
import 'package:flutter_music/common/utils/utils.dart';
import 'package:flutter_music/common/values/values.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// 页头标题
    final _headerTitle = Padding(
      padding: EdgeInsets.only(top: duSetHeight(60.0 + 44.0)),
      child: Text(
        'Features',
        style: TextStyle(
          color: AppColors.primaryText,
          fontFamily: AppFonts.montserrat,
          fontWeight: FontWeight.w600,
          fontSize: duSetFontSize(24),
          height: 1,
        ),
      ),
    );

    /// 页头说明
    final _headerDetail = Container(
      margin: EdgeInsets.only(
        top: duSetHeight(14),
      ),
      width: duSetWidth(242),
      height: duSetWidth(70),
      child: Text(
        'The best of news channels all in one place. '
        'Trusted sources and personalized news for you.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.primaryText,
          fontFamily: AppFonts.avenir,
          fontWeight: FontWeight.normal,
          fontSize: duSetFontSize(16),
          height: 1.3,
        ),
      ),
    );

    /// 特性说明
    /// 宽度 80 + 20 + 195 = 295
    Widget _buildFeatureItem(String imageName, String intro, double marginTop) {
      return Container(
        width: duSetWidth(295),
        height: duSetHeight(80),
        margin: EdgeInsets.only(top: duSetHeight(marginTop)),
        child: Row(
          children: [
            Image.asset(
              'assets/images/$imageName.png',
              width: duSetWidth(80),
              height: duSetHeight(80),
              fit: BoxFit.none,
            ),
            Spacer(),
            Container(
              width: duSetWidth(195),
              child: Text(
                intro,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: AppFonts.avenir,
                  fontWeight: FontWeight.normal,
                  fontSize: duSetFontSize(16),
                ),
              ),
            ),
          ],
        ),
      );
    }

    final _featureItem = Column(
      children: [
        _buildFeatureItem(
          'feature-1',
          'Compelling photography and typography provide a beautiful reading',
          86,
        ),
        _buildFeatureItem(
          'feature-2',
          'Sector news never shares your personal data with advertisers or publishers',
          40,
        ),
        _buildFeatureItem(
          'feature-3',
          'You can get Premium to unlock hundreds of publications',
          40,
        ),
      ],
    );

    /// 开始按钮
    final _startButton = Container(
        width: duSetWidth(295),
        height: duSetHeight(44),
        margin: EdgeInsets.only(bottom: duSetHeight(20)),
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: AppColors.primaryElement,
              primary: AppColors.primaryElementText,
              shape: RoundedRectangleBorder(borderRadius: Radii.k6pxRadius)),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/sign-in',
            );
          },
          child: Text(
            'Get started',
          ),
        ));

    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              _headerTitle,
              _headerDetail,
              _featureItem,
              Spacer(),
              _startButton,
            ],
          ),
        ),
      ),
    );
    ;
  }
}
