import 'package:flutter/material.dart';
import 'package:flutter_music/common/apis/apis.dart';
import 'package:flutter_music/common/entitys/entitys.dart';
import 'package:flutter_music/common/utils/utils.dart';
import 'package:flutter_music/common/values/values.dart';
import 'package:flutter_music/pages/app_page/main_sub_page/categories_widget.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late NewsPageListResponseEntity _newsPageList; // 新闻翻页
  late NewsRecommendResponseEntity _newsRecommend; // 新闻推荐
  late List<CategoryResponseEntity> _categories; // 分类
  late List<ChannelResponseEntity> _channels; // 频道

  late String _selCategoryCode; // 选中的分类Code

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  // 读取所有数据
  _loadAllData() async {
    _categories = await NewsAPI.categories();
    _channels = await NewsAPI.channels();
    _newsRecommend = await NewsAPI.newsRecommend();
    _newsPageList = await NewsAPI.newsPageList();

    _selCategoryCode = _categories.first.code;

    if (mounted) {
      setState(() {});
    }
  }

  // 分类菜单
  Widget _buildCategories() {
    return newsCategoriesWidget(
      categories: _categories,
      selCategoryCode: _selCategoryCode,
      onTap: (CategoryResponseEntity item) {
        setState(() {
          _selCategoryCode = item.code;
        });
      },
    );
  }

  // 推荐阅读
  Widget _buildRecommend() {
    return Container(
      height: duSetHeight(490),
      color: Colors.amber,
    );
  }

  // 频道
  Widget _buildChannels() {
    return Container(
      height: duSetHeight(137),
      color: Colors.blueAccent,
    );
  }

  // 新闻列表
  Widget _buildNewsList() {
    return Container(
      height: duSetHeight(161 * 5 + 100.0),
      color: Colors.purple,
    );
  }

  // ad 广告条
  // 邮件订阅
  Widget _buildEmailSubscribe() {
    return Container(
      height: duSetHeight(259),
      color: Colors.brown,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildCategories(),
          _buildRecommend(),
          _buildChannels(),
          _buildNewsList(),
          _buildEmailSubscribe(),
        ],
      ),
    );
  }
}
