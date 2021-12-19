import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_cubit/cubit.dart';
import 'package:shopapp/layout/shop_cubit/states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shopapp/models/category_model.dart';
import 'package:shopapp/models/favourites_model.dart';
import 'package:shopapp/models/home_data_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
        builder: (context, state) {
          var cubit = ShopAppCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: ConditionalBuilder(
              condition: cubit.homeModel != null && cubit.categoryModel != null,
              builder: (context) =>
                  sliderBuilder(cubit.homeModel, cubit.categoryModel , context),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        },
        listener: (context, state) {});
  }

  Widget sliderBuilder(HomeModel model, CategoryModel categoryModel , BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model.data.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 150,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                scrollDirection: Axis.horizontal,
                autoPlayCurve: Curves.fastOutSlowIn,
                viewportFraction: 1,
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Categories',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ),
          Container(
              height: 120,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      categoryShape(categoryModel.data.data[index]),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: categoryModel.data.data.length)),
          SizedBox(height: 8),
          Text(
            'New Products',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          SizedBox(height: 5),
          Container(
            color: Colors.white,
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.49,
              children: List.generate(
                model.data.products.length,
                (index) => gridBuilder(model: model.data.products[index] ,context:  context),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget gridBuilder({Product model ,BuildContext context , FavouritesModel model2} ) {
    return Column(
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
            if (model.discount != 0)
              Container(
                color: Colors.red,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
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
                  if (model.discount != 0)
                    Text(
                      '${model.oldPrice.round()}',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          decoration: TextDecoration.underline),
                    ),
                  Spacer(),
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        ShopAppCubit.get(context).changeFavourites(model.id);
                        print(model.id);
                      },
                      icon: CircleAvatar(
                          backgroundColor: ShopAppCubit.get(context).myFavourites[model.id] ? Colors.red : Colors.grey,
                          child: Icon(Icons.favorite_border ,color: Colors.white,)))
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget categoryShape(Datum model) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          width: 120,
          height: 120,
          child: Image(
            fit: BoxFit.fill,
            image: NetworkImage(model.image),
          ),
        ),
        Container(
            width: 120,
            color: Colors.black.withOpacity(0.8),
            child: Text(
              model.name,
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ))
      ],
    );
  }

  Widget myDivider() {
    return SizedBox(
      width: 10,
    );
  }
}
