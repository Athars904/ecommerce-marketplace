import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:task_6_e_commerce_amazon_clone/Models/order_model.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/product_model.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/transaction_model.dart';

import '../Models/bar_model.dart';


class TransactionController{
  final String baseUrl = 'http://10.0.2.2:3000/transaction';


  Future<bool> createTransaction(Transaction transaction) async{

    var response = await http.post(
      Uri.parse('$baseUrl/createTransaction'),
      headers: {'Content-type':'application/json'},
      body: jsonEncode(transaction.toJson())
    );

    if(response.statusCode == 201){
      return true;
    }

    else{
      return false;
    }


  }

  Future<List<Transaction>?> getAllTransactions(int StoreID) async{

    var response = await http.get(
      Uri.parse('$baseUrl/getAllTransactions/$StoreID'),
      headers: {'Content-type':'application/json'},

    );

    if(response.statusCode==200){

      final json = jsonDecode(response.body);
      print(json);
      final transactions = (json['data'] as List).map((item){
        return Transaction.fromJson(item);
      }).toList();
      print("after transactions listing");


      return transactions;


    }

    else{
      return null;
    }

  }


  Future<int> getTotalAmount(int StoreID) async{

    var response = await http.get(Uri.parse('$baseUrl/getTotalAmount/$StoreID'),
        headers: {'Content-type':'application/json'}
    );

//    print('Inside getTotal Units');

    if(response.statusCode==200){
      final json = jsonDecode(response.body);

      final data = json['data'][0]['TotalAmount'];

      if(data==null){
        return 0;
      }



      return data;
    }

    else{

      print('error fetching orders');
      return 0;
    }

  }


  Future<int> getTodaysAmount(int StoreID) async{

    var response = await http.get(Uri.parse('$baseUrl/getTodaysAmount/$StoreID'),
        headers: {'Content-type':'application/json'}
    );

//    print('Inside getTotal Units');

    if(response.statusCode==200){
      final json = jsonDecode(response.body);

      final data = json['data'][0]['TotalAmount'];

      if(data==null){
        return 0;
      }

      // print(data);
      //
      // print(data.runtimeType);

      return data;
    }

    else{

      print('error fetching orders');
      return 0;
    }

  }

  Future<BarModel?> get6Units(int StoreID) async{

    var response = await http.get(Uri.parse('$baseUrl/get6Units/$StoreID'),
        headers: {'Content-type':'application/json'}
    );
    //
    print('Inside 6 Units');

    if(response.statusCode==200){
      final json = jsonDecode(response.body);

      // print(json);

      final data = json['data'];

      print(data[0]);

      print(data[0]['Month1'].runtimeType);


      final barData = BarModel.fromJson2(data[0]);

      return barData;



    }

    else{

      print('error fetching orders');
      return null;
    }

  }

}





