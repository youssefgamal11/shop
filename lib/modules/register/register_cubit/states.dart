import 'package:shopapp/models/shop_login_model.dart';

abstract class ShopRegisterStates {}
class InitialRegisterState extends ShopRegisterStates {}
class ShopRegisterSuccessState extends ShopRegisterStates{

  final ShopLoginModel loginModel ;
  ShopRegisterSuccessState(this.loginModel);


}
class ShopRegisterErrorState extends ShopRegisterStates{
  final String  error ;
  ShopRegisterErrorState(this.error);

}
class ShopRegisterLoadingState extends ShopRegisterStates {}