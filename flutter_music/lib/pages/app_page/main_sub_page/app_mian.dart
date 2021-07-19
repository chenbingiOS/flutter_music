import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_music/common/apis/apis.dart';
import 'package:flutter_music/common/entitys/entitys.dart';
import 'package:flutter_music/common/utils/utils.dart';
import 'package:flutter_music/common/values/values.dart';
import 'package:flutter_music/pages/app_page/main_sub_page/categories_widget.dart';
import 'package:flutter_music/pages/app_page/main_sub_page/channels_widget.dart';
import 'package:flutter_music/pages/app_page/main_sub_page/news_item_widget.dart';
import 'package:flutter_music/pages/app_page/main_sub_page/newsletter_widget.dart';
import 'package:flutter_music/pages/app_page/main_sub_page/recommend_widget.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late EasyRefreshController? _controller; // EasyRefresh控制器

  late Future<List<CategoryResponseEntity>> _categories; // 分类

  late Future<NewsPageListResponseEntity> _newsPageList; // 新闻翻页
  late Future<NewsRecommendResponseEntity> _newsRecommend; // 新闻推荐

  late Future<List<ChannelResponseEntity>> _channels; // 频道

  late String _selCategoryCode; // 选中的分类Code

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _loadAllData();
    _loadLatestWithDiskCache();
  }

  // 如果有磁盘缓存，延迟3秒拉取更新档案
  _loadLatestWithDiskCache() {
    if (CACHE_ENABLE == true) {
      var cacheData = StorageUtil().getJSON(STORAGE_INDEX_NEWS_CACHE_KEY);
      if (cacheData != null) {
        Timer(Duration(seconds: 3), () {
          _controller!.callRefresh();
        });
      }
    }
  }

  // 读取所有数据
  _loadAllData() {
    _categories = NewsAPI.categories(context: context);
    // _channels = await NewsAPI.channels(context: context);
    // _newsRecommend = await NewsAPI.newsRecommend(context: context);
    // _newsPageList = await NewsAPI.newsPageList(context: context);

    // _selCategoryCode = _categories!.first.code;

    // if (mounted) {
    //   setState(() {});
    // }
  }

  // 分类菜单
  Widget _buildCategories() {
    return FutureBuilder<List<CategoryResponseEntity>>(
      future: _categories,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _selCategoryCode = snapshot.data!.first.code;
          return newsCategoriesWidget(
            categories: snapshot.data,
            selCategoryCode: _selCategoryCode,
            onTap: (CategoryResponseEntity item) {
              setState(() {
                _selCategoryCode = item.code;
              });
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Container();
      },
    );
  }

  // 推荐阅读
  Widget _buildRecommend() {
    return Container();
    // return _newsRecommend == null
    //     ? Container()
    //     : recommendWidget(_newsRecommend!);
  }

  // 频道
  Widget _buildChannels() {
    return Container();
    // return _channels == null
    //     ? Container()
    //     : newsChannelsWidget(
    //         channels: _channels!,
    //         onTap: (ChannelResponseEntity entity) {},
    //       );
  }

  // 新闻列表
  Widget _buildNewsList() {
    return Container();
    // return _newsPageList == null
    //     ? Container()
    //     : Column(
    //         children: _newsPageList!.items.map(
    //           (item) {
    //             return Column(
    //               children: [
    //                 newsItem(item),
    //                 Divider(
    //                   height: 1,
    //                 )
    //               ],
    //             );
    //           },
    //         ).toList(),
    //       );
  }

  // ad 广告条
  // 邮件订阅
  Widget _buildEmailSubscribe() {
    return newsletterWidget();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildCategoriesTest(),
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
