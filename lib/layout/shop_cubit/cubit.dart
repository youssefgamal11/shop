import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_cubit/states.dart';
import 'package:shopapp/models/category_model.dart';
import 'package:shopapp/models/favourites_model.dart';
import 'package:shopapp/models/home_data_model.dart';
import 'package:shopapp/modules/categories/categories_screen.dart';
import 'package:shopapp/modules/favourites/favourites_screen.dart';
import 'package:shopapp/modules/products/products_screen.dart';
import 'package:shopapp/modules/settings/settings_screen.dart';
import 'package:shopapp/shared/constants/constant.dart';
import 'package:shopapp/shared/network/remote.dart';

class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(InitialAppState());
  static ShopAppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];
  Map<int, bool> myFavourites = {};

  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  HomeModel homeModel;
  void getHomeData() {
    emit(ShopAppLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      emit(ShopAppSuccessState());
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        myFavourites.addAll({element.id: element.inFavorites});
      });
      print(myFavourites);
    }).catchError((onError) {
      emit(ShopAppFailedState());
      print(onError.toString());
    });
  }

  CategoryModel categoryModel;
  void getCategoryData() {
    emit(ShopAppLoadingState());
    DioHelper.getData(url: CATEGORY, token: token).then((value) {
      emit(CategoriesAppSuccessState());
      categoryModel = CategoryModel.fromJson(value.data);
    }).catchError((onError) {
      emit(CategoriesAppFailedState());
      print(onError.toString());
    });
  }

  FavouritesModel favouritesModel;




  void changeFavourites(var productId) {
    myFavourites[productId] =! myFavourites[productId];
    emit(FavouritesAppSuccessState());
    DioHelper.postData(
            url: FAVOURITE, data: {'product_id': productId}, token: token ,)
        .then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);
      print(value.data);
      emit(FavouritesAppSuccessState());
    }).catchError((onError) {
      print(onError);
      // myFavourites[productId] =! myFavourites[productId];
      emit(FavouritesAppFailedState());
    });
  }
}
