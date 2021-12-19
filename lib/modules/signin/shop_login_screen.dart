import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout.dart';
import 'package:shopapp/modules/register/register_screen.dart';
import 'package:shopapp/modules/signin/cubit/cubit.dart';
import 'package:shopapp/modules/signin/cubit/states.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/constants/constant.dart';
import 'package:shopapp/shared/network/local.dart';

class SignIn extends StatelessWidget {
  SignIn({Key key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) {
            if (state is ShopLoginSuccessState) {
              if (state.loginModel.status == true) {
                print(state.loginModel.message);
                print(state.loginModel.data.token);
                CacheHelper.saveData(
                        key: 'token', value: state.loginModel.data.token)
                    .then((value) { token =state.loginModel.data.token;navigateAndFinish(context, ShopLayout());});
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
                          Text(
                            'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: Colors.black, fontSize: 25),
                          ),
                          SizedBox(height: 10),
                          Text('Login now to browse our hot offers',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.grey, fontSize: 20)),
                          SizedBox(
                            height: 40,
                          ),
                          defaultTextFormField(
                              label: 'email',
                              controller: emailController,
                              icon: Icons.email,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return ' email must not be empty';
                                }
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          defaultTextFormField(
                              label: 'password',
                              isPassword: true,
                              controller: passwordController,
                              icon: Icons.lock_outline,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return ' password must not be empty';
                                }
                              }),
                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopLoginLoadingState,
                            builder: (context) => defalutButton(
                                name: 'LOGIN',
                                tap: () {
                                  if (formKey.currentState.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                }),
                            fallback: (context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Don\'t have an account ? ',
                                style: TextStyle(fontSize: 17),
                              ),
                              textButton(
                                  function: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterScreen()));
                                  },
                                  name: 'REGISTER')
                            ],
                          ),
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
