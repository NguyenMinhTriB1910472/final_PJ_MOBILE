import 'package:flutter/foundation.dart';

class UserModel{
  int id;
  String name;
  String email;
  String password;
  int orderCount;
  String phone;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.orderCount,
    required this.phone
  });
  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
        id: json['id'],
        name:json['f_name'] ,
        phone:json['phone'],
        email: json['email'],
        password:json['password'] ,
        orderCount:json['order_count'],
    );
  }
}