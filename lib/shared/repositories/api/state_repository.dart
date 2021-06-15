import 'package:consulta_estados_cidades/shared/model/header.dart';
import 'package:consulta_estados_cidades/shared/model/response_impl.dart';
import 'package:consulta_estados_cidades/shared/model/state_dto.dart';
import 'package:flutter/cupertino.dart';

import 'helpers/api_base_helper.dart';

class StateRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<ResponseImpl> getStates({
    @required int page,
    String orderBy = 'name',
  }) async {
    try {
      var response = await _helper.get(
        url: 'state?linesPerPage=10&page=$page&sortBy=$orderBy',
      );

      ResponseImpl responseImpl = ResponseImpl();
      responseImpl.header = Header.fromJson(response['headers']);
      response['body'].forEach((item) {
        responseImpl.responsesInterface.add(StateDTO.fromJson(item));
      });

      return responseImpl;
    } catch (e) {
      print(e);

      throw Exception(e);
    }
  }
}
