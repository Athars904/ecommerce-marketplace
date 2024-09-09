import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:task_6_e_commerce_amazon_clone/Models/order_model.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/product_model.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/bar_model.dart';
import 'package:task_6_e_commerce_amazon_clone/bar_graph/bar_data.dart';

class OrderController {
  final String baseUrl = 'http://10.0.2.2:3000/order';


  Future<List<Order>?> getAllOrders(int storeID)async{

    //print("inside getAllOrders ");
    var response = await http.get(
      Uri.parse('${baseUrl}/getAllOrders/${storeID}'),
      headers: {'Content-type':'application/json'}
    );

    // print("did the get call");

    if(response.statusCode==200){
     // print("status code was 200");
      final json = jsonDecode(response.body);

      print(json);
      final orders = (json['data'] as List).map((item){
        return Order.fromJson(item);
      }).toList();

      // print("orders were fetched successfully");
      return orders;
    }

    //print("status code was not 200");

    return null;

  }
  
  Future<List<Product>?> getOrderDetails(int OrderID)async{
    var response = await http.get(
      Uri.parse('$baseUrl/getOrderDetails/$OrderID'),
      headers: {'Content-type':'application/json'}
    );

    if(response.statusCode == 200){
      final json = jsonDecode(response.body);

      final products = (json['data'] as List).map((item){
        return Product.fromJson2(item);
      }).toList();

      return products;
    }

    else{
      return null;
    }




  }

  Future<bool> setOrderStatus(int OrderID,String status)async{

    Map<String,String> json = {
      'status':status
    };

    var response = await http.put(
      Uri.parse('$baseUrl/setOrderStatus/$OrderID'),
      headers: {'Content-type':'application/json'},
      body: jsonEncode(json)
    );

    if(response.statusCode==201){
      return true;
    }

    else{
      return false;
    }
  }

  Future<bool> setDateDelivered(int OrderID,DateTime time)async{

    String timeString = time.toString();
    Map<String,String> json = {
      'DateDelivered':timeString
    };

    var response = await http.put(
        Uri.parse('$baseUrl/setDateDelivered/$OrderID'),
        headers: {'Content-type':'application/json'},
        body: jsonEncode(json)
    );

    if(response.statusCode==201){
      return true;
    }

    else{
      return false;
    }
  }

  Future<bool> deleteOrder(int OrderID) async{

    var response = await http.delete(
      Uri.parse('$baseUrl/deleteOrder/$OrderID'),
      headers: {'Content-type' : 'application/json'}
    );

    if(response.statusCode==204){
      return true;
    }

    else{
      return false;
    }




  }

  Future<bool> placeOrder(int CustomerID) async{

    Map<String,int> json = {
      'customerID' : CustomerID
    };

    var response = await http.post(
      Uri.parse('$baseUrl/placeOrder/'),
      headers: {'Content-type':'application/json'},
      body: jsonEncode(json)
    );


    if(response.statusCode==201){
      return true;

    }

    else{
      return false;

    }
  }


  Future<List<Order>?> getCustomerOrders(int customerID)async{

    //print("inside getAllOrders ");
    var response = await http.get(
        Uri.parse('${baseUrl}/getCustomerOrders/${customerID}'),
        headers: {'Content-type':'application/json'}
    );

    // print("did the get call");

    if(response.statusCode==200){
      // print("status code was 200");
      final json = jsonDecode(response.body);

      print(json);
      final orders = (json['data'] as List).map((item){
        return Order.fromJson(item);
      }).toList();

      // print("orders were fetched successfully");
      return orders;
    }

    //print("status code was not 200");

    return null;

  }

  Future<int> getTotalUnits(int StoreID) async{

    var response = await http.get(Uri.parse('$baseUrl/getTotalUnits/$StoreID'),
      headers: {'Content-type':'application/json'}
    );

//    print('Inside getTotal Units');

    if(response.statusCode==200){
      final json = jsonDecode(response.body);

      final data = json['data'][0]['Total'];

      if(data==null){
        return 0;
      }
      //
      // print(data.runtimeType);

      final newData = int.parse(data);
    //
    // print(newData);
    //
    // print(newData.runtimeType);

      // print(newData);
      //
      // print(data.runtimeType);

    return newData;
    }

    else{

      print('error fetching orders');
      return 0;
    }

  }

  Future<int> getTodaysUnits(int StoreID) async{

    var response = await http.get(Uri.parse('$baseUrl/getTodaysUnits/$StoreID'),
        headers: {'Content-type':'application/json'}
    );
    //
    // print('Inside getTotal Units');

   // print('before status');

    if(response.statusCode==200){
     // print('status was 200');
      final json = jsonDecode(response.body);

      final data = json['data'][0]['Total'];

      //rint(data);

      if(data==null){
        return 0;
      }


      final newData = int.parse(data);

      // print(newData);
      //
      // print(newData.runtimeType);
      //



      return newData;
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
    // //
    // print('Inside 6 Units');

    if(response.statusCode==200){
      final json = jsonDecode(response.body);

     // print(json);

      final data = json['data'];
      //
      // print(data);

      final barData = BarModel.fromJson(data[0]);

      return barData;



          }

    else{

      print('error fetching orders');
      return null;
    }

  }

}


