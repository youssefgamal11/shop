import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/search_model.dart';
import 'package:shopapp/modules/search/cubit/states.dart';
import 'package:shopapp/shared/constants/constant.dart';
import 'package:shopapp/shared/network/remote.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  SearchModel searchModel;
  void postDataForSearch(String text) {
    DioHelper.postData(
            url: SEARCH,
            data: {
              'text': text,
            },
            token: token)
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSucessState());
    }).catchError((onError) {
      emit(SearchFailedState());
      print(onError);
    });
  }
}
