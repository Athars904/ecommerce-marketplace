import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_6_e_commerce_amazon_clone/Models/cartItem_model.dart';

import '../Models/product_model.dart';

class CartController {
  final String baseUrl = 'http://10.0.2.2:3000/cart';

  Future<bool> AddCartItem(CartItem item) async{



    var response = await http.post(
      Uri.parse('${baseUrl}/addCartItem'),
      headers: {'Content-type':'application/json'},
      body: jsonEncode(item.toJson())
    );

    if(response.statusCode==201){
      return true;
    }

    else{
      return false;
    }






  }
  Future<List<Product>?> getCartItems(int CustomerID) async {

    var response = await http.get(
        Uri.parse('$baseUrl/getCartItems/$CustomerID'),
        headers: {'Content-type':'application/json'}
    );

    if(response.statusCode==200){



      final json = jsonDecode(response.body);


      final products = (json['data'] as List).map((item){
        return Product.fromJson3(item);

      }).toList();


      return products;


    }
    else{
      return null;
    }


  }

  Future<bool> deleteCartItem (int ProductID) async{

    var response = await http.delete(
      Uri.parse('$baseUrl/deleteCartItem/$ProductID'),
      headers: {'Content-type' : 'application/json'}
    );

    if(response.statusCode==204){
      return true;
    }

    else return false;

  }

  Future<double> getSubTotal (int CustomerID)async{
    var response = await http.get(
      Uri.parse('$baseUrl/getSubTotal/$CustomerID'),
      headers: {'Content-type':'application/json'}
    );

  //  print('inside getSubTotal');

    if(response.statusCode==200){

//      print('status code was ok');
      final json = jsonDecode(response.body);

      final result1 = json['data'][0];
      // print(result1['TotalSum']);
      //
      // print(result1['TotalSum']);
      //
      // print(result1['TotalSum'].runtimeType);

      if(result1['TotalSum']==null){
        return 0;
      }


      double result2 = double.parse(result1['TotalSum']);


      return result2;
    }

    return 0;


  }




}
