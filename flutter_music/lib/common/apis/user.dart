import 'package:flutter_music/common/entitys/entitys.dart';
import 'package:flutter_music/common/utils/utils.dart';

class UserAPI {
  static Future<UserLoginResponseEntity> login(
      {required UserLoginRequestEntity params}) async {
    final response = await HttpUtil().post('/user/login', params: params);
    return UserLoginResponseEntity.fromJson(response);
  }
}
