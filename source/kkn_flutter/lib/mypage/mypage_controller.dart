import 'dart:convert';

import 'package:kkn/mypage/mypage_dto.dart';
import 'package:kkn/server_connector.dart';

class MypageController {
  Future<String> memberupdate(MypageDto member) async {
    String validationErrorMessage = updateValidate(member);

    if (validationErrorMessage.isEmpty) {
      ServerConnector connector = ServerConnector();

      String body = json.encode(member.toJson());

      try {
        if (bool.parse(await connector.sendProcess("/update", body))) {
          return "";
        }
      } catch (exception) {
        return connector.serverExceptionProcess(exception);
      }
    }

    return validationErrorMessage;
  }

  String updateValidate(MypageDto member) {
    if (member.height.isEmpty) {
      return '키를 입력해주세요.';
    } else if (member.weight.isEmpty) {
      return '몸무게를 입력해주세요.';
    }

    return "";
  }
}
