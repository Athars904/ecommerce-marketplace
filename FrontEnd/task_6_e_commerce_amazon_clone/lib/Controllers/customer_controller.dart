import 'dart:convert';

import 'package:task_6_e_commerce_amazon_clone/Models/customer_model.dart';
import 'package:http/http.dart' as http;

class CustomerController {

  final String baseUrl = 'http://10.0.2.2:3000/customer';

  Future<bool> SignUpCustomer(Customer customer) async{



  var response = await http.post(
    Uri.parse('$baseUrl/signup/'),
    headers: {'Content-type':'application/json'},
    body: jsonEncode(customer.toJson())
  );


  if(response.statusCode==201){
    return true;
  }

  else{
    return false;
  }
  }

  Future<bool> LoginCustomer(String email,String pass) async{
    Map<String,String> json = {
      'email':email,
      'pass':pass
    };

    var response = await http.post(
      Uri.parse('$baseUrl/login/'),
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

  Future<Customer?> fetchCustomerDetails(String Email) async{

    var response = await http.get(
      Uri.parse('$baseUrl/fetchCustomerDetails/$Email'),
      headers: {'Content-Type': 'application/json'},
    );

    if(response.statusCode==200){

      final json = jsonDecode(response.body);

      final customer = Customer.fromJson(json['data'][0]);


      return customer;
    }

    else{
      print('response was not okay');
      return null;
    }


  }

  Future<bool> updateCustomer(Customer customer,String newEmail) async{

    Map<String,dynamic> customerUpdate = customer.toJson();
    customerUpdate['newEmail'] = newEmail;
    print(customerUpdate);

    print('before response');

    var response = await http.put(
        Uri.parse('${baseUrl}/updateCustomerDetails'),
        headers: {"Content-type":"application/json"},
        body: jsonEncode(customerUpdate)
    );

    if(response.statusCode==201){
      print("response was 200");
      return true;
    }
    print('response wasnt 200');

    return false;


  }





}