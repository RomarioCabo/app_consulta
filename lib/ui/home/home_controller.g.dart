// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on HomeControllerBase, Store {
  final _$requestStateGetAtom =
      Atom(name: 'HomeControllerBase.requestStateGet');

  @override
  RequestState get requestStateGet {
    _$requestStateGetAtom.reportRead();
    return super.requestStateGet;
  }

  @override
  set requestStateGet(RequestState value) {
    _$requestStateGetAtom.reportWrite(value, super.requestStateGet, () {
      super.requestStateGet = value;
    });
  }

  final _$loadMoreRequestStateAtom =
      Atom(name: 'HomeControllerBase.loadMoreRequestState');

  @override
  RequestState get loadMoreRequestState {
    _$loadMoreRequestStateAtom.reportRead();
    return super.loadMoreRequestState;
  }

  @override
  set loadMoreRequestState(RequestState value) {
    _$loadMoreRequestStateAtom.reportWrite(value, super.loadMoreRequestState,
        () {
      super.loadMoreRequestState = value;
    });
  }

  final _$statesAtom = Atom(name: 'HomeControllerBase.states');

  @override
  ObservableList<StateDTO> get states {
    _$statesAtom.reportRead();
    return super.states;
  }

  @override
  set states(ObservableList<StateDTO> value) {
    _$statesAtom.reportWrite(value, super.states, () {
      super.states = value;
    });
  }

  final _$getStatesAsyncAction = AsyncAction('HomeControllerBase.getStates');

  @override
  Future<void> getStates() {
    return _$getStatesAsyncAction.run(() => super.getStates());
  }

  final _$loadMoreAsyncAction = AsyncAction('HomeControllerBase.loadMore');

  @override
  Future<void> loadMore() {
    return _$loadMoreAsyncAction.run(() => super.loadMore());
  }

  @override
  String toString() {
    return '''
requestStateGet: ${requestStateGet},
loadMoreRequestState: ${loadMoreRequestState},
states: ${states}
    ''';
  }
}
