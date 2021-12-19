// To parse this JSON data, do
//
//     final favouritesModel = favouritesModelFromJson(jsonString);

import 'dart:convert';

FavouritesModel favouritesModelFromJson(String str) => FavouritesModel.fromJson(json.decode(str));

String favouritesModelToJson(FavouritesModel data) => json.encode(data.toJson());

class FavouritesModel {
  FavouritesModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory FavouritesModel.fromJson(Map<String, dynamic> json) => FavouritesModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.product,
  });

  int id;
  Products product;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    product: Products.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product": product.toJson(),
  };
}

class Products {
  Products({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
  });

  int id;
  int price;
  int oldPrice;
  int discount;
  String image;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    id: json["id"],
    price: json["price"],
    oldPrice: json["old_price"],
    discount: json["discount"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "old_price": oldPrice,
    "discount": discount,
    "image": image,
  };
}
