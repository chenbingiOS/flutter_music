/// 标签列表 Request
class TagRequestEntity {
  String categoryCode;
  String channelCode;
  String tag;
  String keyword;
  String newsID;

  TagRequestEntity({
    required this.categoryCode,
    required this.channelCode,
    required this.tag,
    required this.keyword,
    required this.newsID,
  });
}

/// 标签列表 Response
class TagResponseEntity {
  String tag;

  TagResponseEntity({
    required this.tag,
  });

  factory TagResponseEntity.fromJson(Map<String, dynamic> json) =>
      TagResponseEntity(
        tag: json["tag"],
      );

  Map<String, dynamic> toJson() => {
        "tag": tag,
      };
}
