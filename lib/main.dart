import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_cubit/cubit.dart';
import 'package:shopapp/modules/on_boarding/on_boarding_screen.dart';
import 'package:shopapp/modules/signin/shop_login_screen.dart';
import 'package:shopapp/shared/network/local.dart';
import 'package:shopapp/shared/network/remote.dart';
import 'layout/shop_layout.dart';
import 'modules/signin/cubit/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  String token = CacheHelper.getData(key: 'token');
  print(token);
   Widget widget;
  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else
      widget = OnBoarding();
  }
  print(onBoarding);
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({@required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopAppCubit()..getHomeData()..getCategoryData(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0,
          ),
          fontFamily: 'Tajawal',
          textTheme: TextTheme(),
        ),
        darkTheme: ThemeData(),

        // themeMode: ThemeData.light()

        home: startWidget,
      ),
    );
  }
}
