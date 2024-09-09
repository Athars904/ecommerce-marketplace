import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/Controllers/review_controller.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/product_model.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/review_model.dart';
import 'package:task_6_e_commerce_amazon_clone/app_bar.dart';
import 'package:task_6_e_commerce_amazon_clone/bottom_nav.dart';
import 'package:task_6_e_commerce_amazon_clone/customer_home.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';

class AddReview extends ConsumerStatefulWidget{
  @override
  ConsumerState<AddReview> createState() => AddReviewState();
}


class AddReviewState extends ConsumerState<AddReview>{



  int stars = 1;
  List<int> starsList = [1,2,3,4,5];
  TextEditingController statementController = TextEditingController();

  @override
  Widget build(BuildContext context){

    int? customerId = ref.watch(customerDetailsProvider).maybeWhen(
      data: (customer) => customer?.CustomerID,
      orElse: () => null,
    );

    if (customerId == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading...'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    Product? product = ref.read(productProvider);
    final productID = product?.ProductID;
    return Scaffold(
      appBar: CustomAppBar(),

      body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Text(
              'Drop a Review',
              style: TextStyle(fontSize: 40, fontFamily: 'Ember'),
            ),

            SizedBox(height: 50,),
            Text(
              'Stars',
              style: TextStyle(
                fontFamily: 'Ember',
                fontSize: 30,
              ),
            ),
            Container(
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: DropdownButton<int>(
                  isExpanded: true,
                  hint: Text(
                    'Stars',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Ember',
                    ),
                  ),
                  value: stars,
                  items: starsList.map((int item) {
                    return DropdownMenuItem<int>(
                      child: Text(item.toString()),
                      value: item,
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    setState(() {
                      if(newValue!=null) {

                        stars = newValue;

                      }
                    });
                  },
                ),
              ),
            ),

            Text(
              'Description',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Ember',
              ),
            ),
            TextField(
              maxLines: 5,
              controller: statementController,
              decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: TextStyle(
                  fontFamily: 'Ember',
                  fontSize: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),

            SizedBox(height: 50,),

            SizedBox(
              height: 70,
              child: ElevatedButton(
                onPressed: () async{
                     if(statementController.text.toString() != ''){
                       Review review = Review(ReviewStatement: statementController.text.toString(),
                           ReviewStars: stars,
                           ProductID: productID!,
                           CustomerID: customerId);

                       final controller = ReviewController();

                       bool result = await controller.dropReview(review);

                       if(result==true){
                         ref.refresh(getProductReviewsProvider(productID!));
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerHome()));
                       }
                       else{
                         print('couldnt submit review');
                       }
                     }
                     else{
                       print('empty review');
                     }

                  },
                child: Text(
                  'Submit Review',
                  style: TextStyle(
                      fontFamily: 'Ember',
                      fontSize: 30,
                      color: Colors.black
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFFFF9900),

                ),


              )
              ,


            ),


          ]
      ),
      bottomNavigationBar: BottomNav(),
    );


  }
}