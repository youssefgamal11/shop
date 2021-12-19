import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/shop_login_model.dart';
import 'package:shopapp/modules/register/register_cubit/states.dart';
import 'package:shopapp/modules/signin/cubit/states.dart';
import 'package:shopapp/shared/constants/constant.dart';
import 'package:shopapp/shared/network/remote.dart';

//CUBIT FOR LOGIN ONLY

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(InitialRegisterState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel;

  void userRegister(
      {@required String email,
      @required String password,
      @required String name,
        @required String phone}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone
    }).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
}
