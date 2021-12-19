import 'package:flutter/material.dart';

class ShopLoginModel {
   bool status;
   String message;
  UserData data;
  ShopLoginModel(
      {@required this.data, @required this.message, @required this.status});
  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
   int id;
   String name;
   String email;
   String phone;
   String image;
   String token;
  UserData(
      {@required this.email,
      @required this.token,
      @required this.image,
      @required this.id,
      @required this.name,
      @required this.phone});
  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
  }
}
