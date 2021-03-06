import 'package:flutter_music/common/entitys/entitys.dart';
import 'package:flutter_music/common/utils/utils.dart';
import 'package:flutter_music/common/values/values.dart';

/// 新闻
class NewsAPI {
  /// 翻页
  static Future<NewsPageListResponseEntity> newsPageList({
    NewsPageListRequestEntity? params,
    bool cacheDisk = false,
    bool refresh = false,
  }) async {
    var response = await HttpUtil().get(
      '/news',
      params: params?.toJson(),
      refresh: refresh,
      cacheDisk: cacheDisk,
      cacheKey: STORAGE_INDEX_NEWS_CACHE_KEY,
    );
    return NewsPageListResponseEntity.fromJson(response);
  }

  /// 推荐
  static Future<NewsRecommendResponseEntity> newsRecommend({
    NewsRecommendRequestEntity? params,
    bool cacheDisk = false,
    bool refresh = false,
  }) async {
    var response = await HttpUtil().get(
      '/news/recommend',
      params: params?.toJson(),
      refresh: refresh,
    );
    return NewsRecommendResponseEntity.fromJson(response);
  }

  /// 分类
  static Future<List<CategoryResponseEntity>> categories({
    bool cacheDisk = false,
  }) async {
    var response = await HttpUtil().get(
      '/categories',
      cacheDisk: cacheDisk,
    );
    return response
        .map<CategoryResponseEntity>(
            (item) => CategoryResponseEntity.fromJson(item))
        .toList();
  }

  /// 频道
  static Future<List<ChannelResponseEntity>> channels({
    bool cacheDisk = false,
  }) async {
    var response = await HttpUtil().get(
      '/channels',
      cacheDisk: cacheDisk,
    );
    return response
        .map<ChannelResponseEntity>(
            (item) => ChannelResponseEntity.fromJson(item))
        .toList();
  }

  /// 标签列表
  static Future<List<TagResponseEntity>> tags({
    bool cacheDisk = false,
    TagRequestEntity? params,
  }) async {
    var response = await HttpUtil().get(
      '/tags',
      params: params?.toJson(),
      cacheDisk: cacheDisk,
    );
    return response
        .map<TagResponseEntity>((item) => TagResponseEntity.fromJson(item))
        .toList();
  }
}
