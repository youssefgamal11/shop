import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/home_data_model.dart';
import 'package:shopapp/models/search_model.dart';
import 'package:shopapp/modules/search/cubit/cubit.dart';
import 'package:shopapp/shared/components/components.dart';
import 'cubit/states.dart';

class SearchScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
              body: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, left: 10, right: 10),
                  child: defaultTextFormField(
                    icon: Icons.search,
                    controller: SearchCubit.get(context).searchController,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'you must enter value';
                      }
                    },
                    label: 'Search',
                    onSubmit: (String text) {
                      SearchCubit.get(context).postDataForSearch(text);
                    },
                    isPassword: false,
                  ),
                ),
                SizedBox(height: 5),
                if(state is SearchSucessState)
                  LinearProgressIndicator(),
                ListView.separated(itemBuilder:(context , index)=> searchOutput(model: cubit.searchModel.data.data[index] ), separatorBuilder:(context,index)=> Container(color: Colors.grey,height: 1), itemCount:cubit.searchModel.data.data.length )
              ],
            ),
          ));
        },
      ),
    );
  }
  Widget searchOutput({Datum model}){
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage(model.image),
              height: 200,
              width: double.infinity,
            ),
            // if (model.discount != 0)
            //   Container(
            //     color: Colors.red,
            //     child: Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            //       child: Text(
            //         'DISCOUNT',
            //         style: TextStyle(color: Colors.white, fontSize: 12),
            //       ),
            //     ),
            //   ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                model.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold, height: 1.1, fontSize: 16),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  // if (model.discount != 0)
                  //   Text(
                  //     '${model.oldPrice.round()}',
                  //     style: TextStyle(
                  //         fontSize: 14,
                  //         color: Colors.grey,
                  //         decoration: TextDecoration.underline),
                  //   ),
                ],
              ),
            ],
          ),
        ),
      ],
    );

  }
}
