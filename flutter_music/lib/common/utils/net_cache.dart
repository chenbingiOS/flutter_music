import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter_music/common/utils/storage.dart';
import 'package:flutter_music/common/values/values.dart';

class CacheObject {
  CacheObject(this.response)
      : timeStamp = DateTime.now().millisecondsSinceEpoch;
  Response response;
  int timeStamp;

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
}

class NetCache extends Interceptor {
  // 为确保迭代器顺序和对象插入时间一致顺序一致，我们使用LinkedHashMap
  var cache = LinkedHashMap<String, CacheObject>();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!CACHE_ENABLE) return handler.next(options);

    // refresh标记是否是"下拉刷新"
    bool refresh = options.extra["refresh"] == true;

    // 是否磁盘缓存
    bool cacheDisk = options.extra["cacheDisk"] == true;

    // 如果是下拉刷新，先删除相关缓存
    if (refresh) {
      if (options.extra["list"] == true) {
        //若是列表，则只要url中包含当前path的缓存全部删除（简单实现，并不精准）
        cache.removeWhere((key, v) => key.contains(options.path));
      } else {
        // 如果不是列表，则只删除uri相同的缓存
        cache.remove(options.uri.toString());
      }

      if (cacheDisk) {
        await StorageUtil().remove(options.uri.toString());
      }

      handler.next(options);
      return;
    }

    // get 请求，开启缓存
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == 'get') {
      String key = options.extra["cacheKey"] ?? options.uri.toString();

      // 策略 1 内存缓存优先，2 然后才是磁盘缓存

      // 1 内存缓存
      var ob = cache[key];
      if (ob != null) {
        //若缓存未过期，则返回缓存内容
        if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) / 1000 <
            CACHE_MAXAGE) {
          handler.resolve(cache[key]!.response);
          return;
        } else {
          //若已过期则删除缓存，继续向服务器请求
          cache.remove(key);
        }
      }

      // 2 磁盘缓存
      if (cacheDisk) {
        var cacheData = StorageUtil().getJSON(key);
        if (cacheData != null) {
          handler.resolve(
            Response(
              requestOptions: options,
              statusCode: 200,
              data: cacheData,
            ),
          );
          return;
        }
      }
    }
    // 无缓存，走下一步请求
    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    // 如果启用缓存，将返回结果保存到缓存
    if (CACHE_ENABLE) {
      RequestOptions options = response.requestOptions;
      // 只缓存 get 的请求
      if (options.extra["noCache"] != true &&
          options.method.toLowerCase() == "get") {
        // 策略：内存、磁盘都写缓存

        // 缓存key
        String key = options.extra["cacheKey"] ?? options.uri.toString();

        // 磁盘缓存
        if (options.extra["cacheDisk"] == true) {
          await StorageUtil().setJSON(key, response.data);
        }

        // 内存缓存
        // 如果缓存数量超过最大数量限制，则先移除最早的一条记录
        if (cache.length == CACHE_MAXCOUNT) {
          cache.remove(cache[cache.keys.first]);
        }
        // 保存
        cache[key] = CacheObject(response);
      }
    }

    // 走下一步
    handler.next(response);
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    // 错误状态不缓存，走下一步
    handler.next(err);
  }
}
