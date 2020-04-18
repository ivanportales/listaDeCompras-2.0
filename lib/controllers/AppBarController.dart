import 'package:mobx/mobx.dart';

part 'AppBarController.g.dart';

class AppBarController = _AppBarController with _$AppBarController;

abstract class _AppBarController with Store {

  @observable
  bool isSearching = false;
  
  @action
  changeStatus() {
    isSearching = !isSearching;
  }
}
