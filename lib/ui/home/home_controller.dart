import 'package:consulta_estados_cidades/shared/model/response_impl.dart';
import 'package:consulta_estados_cidades/shared/model/state_dto.dart';
import 'package:consulta_estados_cidades/shared/repositories/api/helpers/request_state.dart';
import 'package:consulta_estados_cidades/shared/repositories/api/state_repository.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  @observable
  RequestState requestStateGet = Initial();

  @observable
  RequestState loadMoreRequestState = Initial();

  @observable
  ObservableList<StateDTO> states = ObservableList();

  ResponseImpl _statesImpl;

  StateRepository _stateRepository = StateRepository();

  int _page = 0;

  bool _loadLast = false;
  bool _loadMore = false;

  bool get loadLast => _loadLast;

  @action
  Future<void> getStates() async {
    try {
      this.requestStateGet = Loading();

      await Future.delayed(Duration(seconds: 1));

      _statesImpl = await _stateRepository.getStates(page: _page);

      states = ObservableList<StateDTO>.of(
        _statesImpl.responsesInterface.cast(),
      );

      _page += 1;

      requestStateGet = Completed();
    } catch (e, stackTrace) {
      print(stackTrace);

      this.requestStateGet = Error(
        error: e.toString().replaceAll("Exception:", ""),
      );
    }
  }

  @action
  Future<void> loadMore() async {
    try {
      if (!_loadMore && !_loadLast) {
        _loadMore = true;

        _statesImpl = await _stateRepository.getStates(page: _page);

        List<StateDTO> aux = _statesImpl.responsesInterface.cast();

        states.addAll(ObservableList.of(aux));

        if (aux.length == 0) _loadLast = true;

        _page += 1;

        _loadMore = false;
      }
    } catch (e) {
       _loadLast = true;
       _loadMore = true;

      this.requestStateGet = Error(
        error: e.toString().replaceAll("Exception:", ""),
      );
    }
  }
}
