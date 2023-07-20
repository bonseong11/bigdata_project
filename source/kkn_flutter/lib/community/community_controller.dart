import 'dart:convert';

import 'package:kkn/community/dto/post_save_dto.dart';
import 'package:kkn/community/dto/post_dto.dart';
import 'package:kkn/server_connector.dart';

class CommunityController {
  Future<List<PostDto>> postListLoad(String loadTimestamp) async {
    ServerConnector serverConnector = ServerConnector();

    try {
      String responseBody =
          await serverConnector.sendProcess("/community", loadTimestamp);

      List<PostDto> postList = [];
      for (var rawPost in json.decode(responseBody)) {
        postList.add(PostDto.fromJson(rawPost));
      }

      return postList;
    } catch (exception) {
      serverConnector.serverExceptionProcess(exception);

      return [];
    }
  }

  Future<String> postCreate(PostSaveDto communityDto) async {
    if (postFormValidate(communityDto)) {
      ServerConnector serverConnector = ServerConnector();

      String body = json.encode(communityDto.toJson());

      try {
        await serverConnector.sendProcess("/community/create", body);

        return "";
      } catch (exception) {
        return serverConnector.serverExceptionProcess(exception);
      }
    }

    return "빈칸을 입력해주세요.";
  }

  bool postFormValidate(PostSaveDto communityDto) {
    if (communityDto.title.isEmpty || communityDto.content.isEmpty) {
      return false;
    }
    return true;
  }

  Future<String> postDelete(
      String loginUserid, String postWriterUserid, int postNum) async {
    if (loginUserid == postWriterUserid) {
      ServerConnector serverConnector = ServerConnector();

      try {
        await serverConnector.sendProcess(
            "/community/delete", postNum.toString());

        return "";
      } catch (exception) {
        return serverConnector.serverExceptionProcess(exception);
      }
    }

    return "다른 사람이 쓴 글을 삭제할 수 없습니다.";
  }
}
