import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_6_e_commerce_amazon_clone/Models/seller_model.dart';


class SellerController {
  final String baseUrl = 'http://10.0.2.2:3000/seller';

  Future<bool> SignUpSeller(Seller seller) async {
    try {
      print('Attempting to sign up seller: ${seller.toJson()}');

      var response = await http.post(
        Uri.parse('${baseUrl}/signup/'),
        headers: {'Content-type': 'application/json'},
        body: jsonEncode(seller.toJson()),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        print('Data created successfully');
        return true;
      } else {
        print('Failed to create data, status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception occurred: $e');
      return false;
    }
  }

  Future<bool> LoginSeller(String email,String pass) async{
    Map<String,String> json= {
      'email':email,
      'pass':pass
    };

    final String baseUrl = 'http://10.0.2.2:3000/seller';

    var response = await http.post(
      Uri.parse('${baseUrl}/login/'),
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(json),
    );

    if(response.statusCode==201){
      return true;
    }

    return false;

  }

  Future<Seller?> GetSeller(String? email) async {
    var response = await http.get(
      Uri.parse('${baseUrl}/fetchSellerDetails/${email}'),
      headers: {'Content-Type': 'application/json'},


    );

    if(response.statusCode==200){
   //  print("i am controller");
      Map<String,dynamic> json = jsonDecode(response.body);
     // print(json['data']);
      //print(response.body);
      //Seller test = Seller.fromJson(json);
     // print(Seller.fromJson(json['data']));
      return Seller.fromJson(json['data']);
    }

    return null;
  }

  Future<bool> updateSeller(Seller seller,String newEmail) async{

    Map<String,dynamic> sellerUpdate = seller.toJson();
    sellerUpdate['newEmail'] = newEmail;
    print(sellerUpdate);

    var response = await http.put(
      Uri.parse('${baseUrl}/updateSellerDetails'),
      headers: {"Content-type":"application/json"},
      body: jsonEncode(sellerUpdate)
    );

    if(response.statusCode==201){
      return true;
    }

    return false;
    
    
  }


}
