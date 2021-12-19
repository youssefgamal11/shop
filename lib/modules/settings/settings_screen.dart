import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/settings/cubit/cubit.dart';
import 'package:shopapp/modules/settings/cubit/states.dart';
import 'package:shopapp/layout/shop_layout.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/constants/constant.dart';
import 'package:shopapp/shared/network/local.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key key}) : super(key: key);

  var emailController = TextEditingController();
  var userNameController = TextEditingController();
  var phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopUpdateCubit(),
        child: BlocConsumer<ShopUpdateCubit, ShopUpdateStates>(
          listener: (context, state) {
            if (state is ShopUpdateSuccessState) {
              if (state.loginModel.status) {
                print(state.loginModel.message);
                print(state.loginModel.data.token);
                CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data.token)
                    .then((value) => navigateAndFinish(context, ShopLayout()));
              } else {
                print(state.loginModel.message);
                showToast(
                    state: ToastState.ERROR,
                    message: state.loginModel.message);
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(state is ShopUpdateLoadingState)
                            LinearProgressIndicator(),
                          SizedBox(height: 20,),
                          defaultTextFormField(
                              label: 'user name',
                              controller: userNameController,
                              icon: Icons.person,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'email must not be empty';
                                }
                                return null ;
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          defaultTextFormField(
                              label: 'email',
                              controller: emailController,
                              icon: Icons.email,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return ' email must not be empty';
                                }
                                return null ;

                              }),
                          SizedBox(
                            height: 15,
                          ),
                          defaultTextFormField(
                              label: 'phone',
                              controller: phoneController,
                              icon: Icons.phone,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return ' phone must not be empty';
                                }
                                return null ;

                              }),
                          SizedBox(
                            height: 30,
                          ),
                          defalutButton(
                              name: 'Update',
                              tap: () {
                                if (formKey.currentState.validate()) {
                                  ShopUpdateCubit.get(context).userUpdate(
                                    email: emailController.text,
                                    name: userNameController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              }),
                          SizedBox(height: 10,),
                          defalutButton(
                              name: 'sign out',
                              tap: () {
                                signOut(context);
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
