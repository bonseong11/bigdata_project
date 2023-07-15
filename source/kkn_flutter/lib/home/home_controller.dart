import 'dart:convert';
import 'package:kkn/home/dto/home_response_dto.dart';
import 'package:logger/logger.dart';

import 'package:kkn/home/dto/home_dto.dart';
import 'package:kkn/server_connector.dart';

class HomeController {
  Future<HomeResponseDto> homeInformationLoad(String userid) async {
    ServerConnector connector = ServerConnector();

    HomeResponseDto homeResponseDto = HomeResponseDto("");

    try {
      String response = await connector.sendProcess("/", userid);

      homeResponseDto.homeDto = HomeDto.fromJson(json.decode(response));
    } catch (exception) {
      Logger().e(exception);

      homeResponseDto.errorMessage = "서버 접속 오류. 서버 관리자에게 문의해주세요.";
    }

    return homeResponseDto;
  }

  Future<String> homeInformationModify(HomeDto homeDto) async {
    ServerConnector connector = ServerConnector();

    amountEmptyProcess(homeDto);

    try {
      await connector.sendProcess("/homeinformationmodify", json.encode(homeDto.toJson()));

      return "";
    } catch (exception) {
      return connector.serverExceptionProcess(exception);
    }
  }

  void amountEmptyProcess(HomeDto homeDto) {
    if (homeDto.steps.isEmpty) {
      homeDto.steps = "0";
    }

    if (homeDto.waterInTake.isEmpty) {
      homeDto.waterInTake = "0.0";
    }
  }
}
