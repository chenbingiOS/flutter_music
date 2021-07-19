import 'package:flutter/material.dart';
import 'package:flutter_music/common/entitys/entitys.dart';
import 'package:flutter_music/common/utils/utils.dart';

/// 新闻
class NewsAPI {
  /// 翻页
  static Future<NewsPageListResponseEntity> newsPageList({
    required BuildContext context,
    bool cacheDisek = false,
    NewsPageListRequestEntity? params,
    bool refresh = false,
  }) async {
    var response = await HttpUtil().get('/news', params: params);
    return NewsPageListResponseEntity.fromJson(response);
  }

  /// 推荐
  static Future<NewsRecommendResponseEntity> newsRecommend({
    required BuildContext context,
    bool cacheDisek = false,
    NewsRecommendRequestEntity? params,
    bool refresh = false,
  }) async {
    var response = await HttpUtil().get('/news/recommend', params: params);
    return NewsRecommendResponseEntity.fromJson(response);
  }

  /// 分类
  static Future<List<CategoryResponseEntity>> categories({
    required BuildContext context,
    bool cacheDisek = false,
  }) async {
    var response = await HttpUtil().get('/categories');
    return response
        .map<CategoryResponseEntity>(
            (item) => CategoryResponseEntity.fromJson(item))
        .toList();
  }

  /// 频道
  static Future<List<ChannelResponseEntity>> channels({
    required BuildContext context,
    bool cacheDisek = false,
  }) async {
    var response = await HttpUtil().get('/channels');
    return response
        .map<ChannelResponseEntity>(
            (item) => ChannelResponseEntity.fromJson(item))
        .toList();
  }

  /// 标签列表
  static Future<List<TagResponseEntity>> tags({
    required BuildContext context,
    bool cacheDisek = false,
    TagRequestEntity? params,
  }) async {
    var response = await HttpUtil().get('/tags', params: params);
    return response
        .map<TagResponseEntity>((item) => TagResponseEntity.fromJson(item))
        .toList();
  }
}
