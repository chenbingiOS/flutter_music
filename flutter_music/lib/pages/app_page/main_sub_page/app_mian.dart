import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_music/common/apis/apis.dart';
import 'package:flutter_music/common/entitys/entitys.dart';
import 'package:flutter_music/common/utils/utils.dart';
import 'package:flutter_music/common/values/values.dart';
import 'package:flutter_music/pages/app_page/main_sub_page/ad_widget.dart';
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
  late Future<List<ChannelResponseEntity>> _channels; // 频道
  late Future<NewsPageListResponseEntity> _newsPageList; // 新闻翻页
  late Future<NewsRecommendResponseEntity> _newsRecommend; // 新闻推荐

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
    _categories = NewsAPI.categories();
    _channels = NewsAPI.channels();
    _newsRecommend = NewsAPI.newsRecommend();
    _newsPageList = NewsAPI.newsPageList();
  }

  _loadNewsData(
    categoryCode, {
    bool refresh = false,
  }) async {
    _selCategoryCode = categoryCode;
    _newsRecommend = NewsAPI.newsRecommend(
      cacheDisk: true,
      refresh: refresh,
      params: NewsRecommendRequestEntity(
        categoryCode: categoryCode,
      ),
    );
    _newsPageList = NewsAPI.newsPageList(
      cacheDisk: true,
      refresh: refresh,
      params: NewsPageListRequestEntity(
        categoryCode: categoryCode,
      ),
    );

    if (mounted) {
      setState(() {});
    }
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
    return FutureBuilder<NewsRecommendResponseEntity>(
      future: _newsRecommend,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return recommendWidget(snapshot.data!);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Container();
      },
    );
  }

  // 频道
  Widget _buildChannels() {
    return FutureBuilder<List<ChannelResponseEntity>>(
      future: _channels,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return newsChannelsWidget(
            channels: snapshot.data!,
            onTap: (ChannelResponseEntity item) {},
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Container();
      },
    );
  }

  // 新闻列表
  Widget _buildNewsList() {
    return FutureBuilder<NewsPageListResponseEntity>(
      future: _newsPageList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: snapshot.data!.items.map(
              (item) {
                // 新闻行
                List<Widget> widgets = <Widget>[
                  newsItem(item),
                  Divider(height: 1),
                ];

                int index = snapshot.data!.items.indexOf(item);
                if (((index + 1) % 5) == 0) {
                  widgets.addAll(<Widget>[
                    adWidget(),
                    Divider(height: 1),
                  ]);
                }

                return Column(
                  children: widgets,
                );
              },
            ).toList(),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Container();
      },
    );
  }

  // ad 广告条
  // 邮件订阅
  Widget _buildEmailSubscribe() {
    return newsletterWidget();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      enableControlFinishLoad: true,
      controller: _controller,
      header: ClassicalHeader(),
      onRefresh: () async {
        _loadNewsData(
          _selCategoryCode,
          refresh: true,
        );
      },
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildCategories(),
            Divider(height: 1),
            _buildRecommend(),
            Divider(height: 1),
            _buildChannels(),
            Divider(height: 1),
            _buildNewsList(),
            Divider(height: 1),
            _buildEmailSubscribe(),
          ],
        ),
      ),
    );
  }
}
