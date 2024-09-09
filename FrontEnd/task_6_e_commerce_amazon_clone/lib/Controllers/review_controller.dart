import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_6_e_commerce_amazon_clone/Models/review_model.dart';


class ReviewController{

  final String baseUrl = 'http://10.0.2.2:3000/review';

  Future<List<Review>?> getAllReviews(int StoreID) async{

    var response = await http.get(
      Uri.parse('${baseUrl}/getAllReviews/${StoreID}'),
      headers: {'Content-type':'application/json'}
    );

    if(response.statusCode==200){
      final json = jsonDecode(response.body);

      final reviewsList = (json['data'] as List).map((item){
        return Review.fromJson(item);
      }).toList();

      return reviewsList;


    }
    else {
      return null;
    }

  }


  Future<List<Review>?> getProductReviews(int ProductID) async{

    var response = await http.get(
        Uri.parse('${baseUrl}/getProductReviews/${ProductID}'),
        headers: {'Content-type':'application/json'}
    );

    if(response.statusCode==200){
      final json = jsonDecode(response.body);

      final reviewsList = (json['data'] as List).map((item){
        return Review.fromJson(item);
      }).toList();

      return reviewsList;


    }
    else {
      return null;
    }

  }


Future<bool> dropReview(Review review)async{

    var response = await http.post(
      Uri.parse('$baseUrl/dropReview/'),
      headers: {'Content-type':'application/json'},
      body: jsonEncode(review.toJson())
    );

    if(response.statusCode==201){
      return true;
    }

    else{
      return false;
    }

}





}