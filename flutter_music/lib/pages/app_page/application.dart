import 'package:flutter/material.dart';
import 'package:flutter_music/common/utils/iconfont.dart';
import 'package:flutter_music/common/utils/screen.dart';
import 'package:flutter_music/common/values/values.dart';
import 'package:flutter_music/common/widgets/app.dart';
import 'package:flutter_music/pages/app_page/main_sub_page/app_mian.dart';

class ApplicationPage extends StatefulWidget {
  ApplicationPage({Key? key}) : super(key: key);

  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage>
    with SingleTickerProviderStateMixin {
  // 当前 tab 页码
  int _page = 0;
  // 页控制器
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: this._page);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // tab栏动画
  void _handleNavBarTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  // tab栏页码切换
  void _handlePageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  // tab 页标题
  final List<String> _tabTitles = [
    'Welcome',
    'Cagegory',
    'Bookmarks',
    'Account'
  ];
  // 顶部导航
  AppBar _buildAppBar() {
    // return Container();
    return transparentAppBar(
      context: context,
      title: Text(
        _tabTitles[_page],
        style: TextStyle(
          color: AppColors.primaryText,
          fontFamily: AppFonts.montserrat,
          fontSize: duSetFontSize(18.0),
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: AppColors.primaryText,
          ),
        ),
      ],
    );
  }

  // 内容页
  Widget _buildPageView() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        MainPage(),
        Container(
          color: Colors.yellow,
        ),
        Container(
          // height: 200,
          color: Colors.blue,
        ),
        Container(
          // height: 200,
          color: Colors.green,
        ),
      ],
      controller: _pageController,
      onPageChanged: _handlePageChanged,
    );
  }

  // 底部导航
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: _handleNavBarTap,
      items: [
        _buildBottomNaviItem('Welcome', Iconfont.home),
        _buildBottomNaviItem('Cagegory', Iconfont.grid),
        _buildBottomNaviItem('Bookmarks', Iconfont.tag),
        _buildBottomNaviItem('Account', Iconfont.me),
      ],
      currentIndex: _page,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }

  BottomNavigationBarItem _buildBottomNaviItem(String title, IconData icon) {
    return BottomNavigationBarItem(
      label: title,
      icon: Icon(
        icon,
        color: AppColors.tabBarElement,
      ),
      activeIcon: Icon(
        icon,
        color: AppColors.secondaryElementText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
