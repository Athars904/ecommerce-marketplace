import 'package:flutter/cupertino.dart';

class Customer {
  int? CustomerID;
  final String Name;
  final String  Email;
  final String Address;
  final String Phone;
  final String Pass;


  Customer({
    this.CustomerID,
    required this.Name,
    required this.Email,
    required this.Address,
    required this.Phone,
    required this.Pass,
});

  Map<String,dynamic> toJson(){
    return {
      'name':Name,
      'email':Email,
      'address':Address,
      'phone':Phone,
      'pass':Pass
    };
    

    

  }

  factory Customer.fromJson(Map<String,dynamic> json) {
    return Customer(
        CustomerID: json['CustomerID'],
        Name: json['Name'],
        Email: json['Email'],
        Address: json['Address'],
        Phone: json['Phone'],
        Pass: json['Password']);
  }



}