import 'package:consulta_estados_cidades/shared/domain/state_dto.dart';

import 'helpers/api_base_helper.dart';

class StateRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<StateDTO>> getStates() async {
    try {
      final response = await _helper.get(
        url: 'state?linesPerPage=10&page=0&sortBy=name',
      );

      return List<StateDTO>.from(
        response.map((item) => StateDTO.fromJson(item)),
      );
    } catch (e) {
      print(e);

      throw Exception(e);
    }
  }
}
