import 'package:shopapp/models/shop_login_model.dart';

abstract class ShopUpdateStates {}

class InitialUpdateState extends ShopUpdateStates {}

class ShopUpdateSuccessState extends ShopUpdateStates {
  final ShopLoginModel loginModel;
  ShopUpdateSuccessState(this.loginModel);
}

class ShopUpdateErrorState extends ShopUpdateStates {
  final String error;
  ShopUpdateErrorState(this.error);
}

class ShopUpdateLoadingState extends ShopUpdateStates {}
