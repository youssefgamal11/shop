import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_cubit/cubit.dart';
import 'package:shopapp/layout/shop_cubit/states.dart';
import 'package:shopapp/models/category_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
        builder: (context, state) {
          var cubit = ShopAppCubit.get(context);

          return ListView.separated(
            itemBuilder: (context, index) => myWidget(model: cubit.categoryModel.data.data[index]),
            itemCount:cubit.categoryModel.data.data.length ,
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Container(
                height: 1,
                color: Colors.grey,
              ),
            ),
          );
        },
        listener: (context, state) {});
  }

  Widget myWidget({Datum model}) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            child: Image(
              fit: BoxFit.fill,
              image: NetworkImage(
                  model.image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              model.name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 30,
          ),
        ],
      ),
    );
  }
}
