import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/settings/cubit/states.dart';
import 'package:shopapp/models/shop_login_model.dart';
import 'package:shopapp/shared/constants/constant.dart';
import 'package:shopapp/shared/network/remote.dart';

//CUBIT FOR update ONLY

class ShopUpdateCubit extends Cubit<ShopUpdateStates> {
  ShopUpdateCubit() : super(InitialUpdateState());

  static ShopUpdateCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel;

  void userUpdate(
      {@required String email,
      @required String name,
      @required String phone}) {
    emit(ShopUpdateLoadingState());
    DioHelper.updateData(url: UPDATE_PROFILE,token: token ,data: {
      'email': email,
      'name': name,
      'phone': phone
    }).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopUpdateSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUpdateErrorState(error.toString()));
    });
  }
}
