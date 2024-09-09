import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:task_6_e_commerce_amazon_clone/Models/product_model.dart';
import 'package:riverpod/riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class ProductController {

  final String baseUrl = 'http://10.0.2.2:3000/product';

  Future<bool> addAProduct(Product product,XFile? image)async{
    // print("inside product controller");


    var req = http.MultipartRequest('POST',Uri.parse('$baseUrl/add'));

    req.fields['name'] = product.Name;
    req.fields['price'] = product.Price.toString();

    req.fields['quantity'] = product.StockQuantity.toString();
    // print(req.fields['quantity']);
    req.fields['store'] = product.StoreID.toString();
    req.fields['category'] = product.CategoryID.toString();
    req.fields['description'] = product.Description;

    final mimetype = mime(image?.path);

    final imageUpload = await http.MultipartFile.fromPath(
      'image',
      image!.path,
      contentType: MediaType.parse(mimetype ?? 'image/jpeg'),
    );

    req.files.add(imageUpload);

    final response = await req.send();


    print("response from request :");
    print(response.statusCode);
    if(response.statusCode==201){
      return true;
    }

    else{
      return false;
    }

  }

  Future<bool> updateImage(int ProductID,XFile image) async{

    var req = http.MultipartRequest('PUT',Uri.parse('$baseUrl/updateImage'));

    req.fields['productID'] = ProductID.toString();

    final mimetype = mime(image.path);

    final imageUpload = await http.MultipartFile.fromPath(
      'image',
      image!.path,
      contentType: MediaType.parse(mimetype ?? 'image/jpeg'),
    );

    req.files.add(imageUpload);

    final response = await req.send();

    if(response.statusCode==201){
      return true;
    }
    else{
      return false;
    }



  }

 Future<List<Product>?> getProducts (int? StoreID) async{

    var response = await http.get(
      Uri.parse('${baseUrl}/getProducts/${StoreID}'),
      headers: {"Content-type":"application/json"},
    );

    if(response.statusCode==200){
//      print(response);

      final json = jsonDecode(response.body);
      //print(map['data']);

      final List<Product> productsList =  (json['data'] as List).map((item)=> Product.fromJson(item)).toList();

  //    print("heres the list of products");
    //  print(productsList);

      return productsList;

    }

    else{
      print("could not fetch the products");
      return null;
    }

 }

 Future<bool> deleteProduct(int productID) async{
    var response = await http.delete(
      Uri.parse('${baseUrl}/deleteProduct/${productID}'),
      headers: {'Content-type':'application/json'}
    );

    if(response.statusCode==204){
      return true;
    }
    else{
      return false;
    }



 }
 
 Future<bool> updateProduct(Product product,int? ProductID) async{
    
    var response = await http.put(
      Uri.parse('${baseUrl}/updateAProduct/${ProductID}'),
      headers: {'Content-type':'application/json'},
      body: jsonEncode(product.toJson())
    );

    if(response.statusCode==201){
      return true;
    }

    else{
      return false;
    }

    
    
 }

 Future<List<Product>?> getAllProducts() async{

    var response = await http.get(
      Uri.parse('$baseUrl/getAllProducts'),
      headers: {'Content-type':'application/json'}
    );

    if(response.statusCode==200){

      print('result was 200');
      final json = jsonDecode(response.body);

      print(json);

      final products = (json['data'] as List).map((item){
        return Product.fromJson(item);
      }).toList();

      print(products);
      return products;

    }
    else{
      return null;
    }
 }


  Future<List<Product>?> getProductsByCategory(int CategoryID) async{


    var response = await http.get(
        Uri.parse('$baseUrl/getProductsByCategory/$CategoryID'),
        headers: {'Content-type':'application/json'}
    );

    if(response.statusCode==200){

      final json = jsonDecode(response.body);

      final products = (json['data'] as List).map((item){
        return Product.fromJson(item);
      }).toList();

      return products;

    }
    else{
      return null;
    }
  }

  Future<List<Product>?> getSearchResults(String word) async{


    var response = await http.get(
        Uri.parse('$baseUrl/getSearchResults/$word'),
        headers: {'Content-type':'application/json'}
    );

    if(response.statusCode==200){

      final json = jsonDecode(response.body);

      final products = (json['data'] as List).map((item){
        return Product.fromJson(item);
      }).toList();

      return products;

    }
    else{
      return null;
    }
  }




}