//end point for login

import 'package:shopapp/modules/signin/shop_login_screen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local.dart';

const String LOGIN = 'login';
const String REGISTER = 'register';
const String UPDATE_PROFILE ='update-profile';
const String HOME ='home';
const String CATEGORY ='categories';
const String FAVOURITE ='favorites';
const String SEARCH ='products/search';
 String token = '';


void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) { if(value = true){ navigateAndFinish(context, SignIn());}});
}