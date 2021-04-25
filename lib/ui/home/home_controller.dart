import 'package:consulta_estados_cidades/shared/domain/state_dto.dart';
import 'package:consulta_estados_cidades/shared/repositories/api/helpers/request_state.dart';
import 'package:consulta_estados_cidades/shared/repositories/api/state_repository.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  @observable
  RequestState requestStateGet = Initial();

  @observable
  ObservableList<StateDTO> states;

  StateRepository _stateRepository = StateRepository();

  @action
  Future<void> getStates() async {
    try {
      this.requestStateGet = Loading();

      await Future.delayed(Duration(seconds: 1));

      states = ObservableList<StateDTO>.of(
        await _stateRepository.getStates(),
      );

      requestStateGet = Completed();
    } catch (e, stackTrace) {
      print(stackTrace);

      this.requestStateGet = Error(
        error: e.toString().replaceAll("Exception:", ""),
      );
    }
  }
}
