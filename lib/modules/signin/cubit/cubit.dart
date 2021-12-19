import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/shop_login_model.dart';
import 'package:shopapp/modules/signin/cubit/states.dart';
import 'package:shopapp/shared/constants/constant.dart';
import 'package:shopapp/shared/network/remote.dart';

//CUBIT FOR LOGIN ONLY

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(InitialLoginState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel;

  void userLogin({@required String email, @required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
      emit(ShopLoginSuccessState(loginModel));
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }
}
