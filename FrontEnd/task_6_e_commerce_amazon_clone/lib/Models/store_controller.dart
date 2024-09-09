import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_6_e_commerce_amazon_clone/Models/store_model.dart';


class StoreController {
  final String baseUrl = 'http://10.0.2.2:3000/store';

  Future<Store?> getStore (int StoreID) async{


    if(StoreID == null || StoreID == 0){
      return null;
    }

    var response = await http.get(
      Uri.parse('${baseUrl}/getStore/$StoreID'),
      headers: {'Content-type':'application/json'}
    );

    if(response.statusCode==200){

      final json = jsonDecode(response.body);

      final store = Store.fromJson(json['data'][0]);


      return store;


    }

    else{
      return null;
    }


  }


}