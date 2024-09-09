
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';

import 'nav_bar.dart';

class ReviewDetails extends ConsumerStatefulWidget{

  @override
  ConsumerState createState() => ReviewDetailsState();
}

class ReviewDetailsState extends ConsumerState<ReviewDetails>{


  @override
  Widget build(BuildContext context){
    final review = ref.read(ReviewProvider);
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white,size: 40),

        title: Image.asset('images/PngItem_12080.png', height: 38),

        centerTitle: true,
        //automaticallyImplyLeading: false,
        backgroundColor: Color(0XFF232F3E),
        actions:  [
          Padding(
              padding: EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child:Icon(
                  Icons.camera_alt,
                  size: 40,
                  color: Colors.white,
                ),
              )
          )
        ],
      ),

      body:Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Text('Review Details',
                  style: TextStyle(
                    fontFamily: 'Ember',
                    fontSize: 40,
                  ),
                )
              ]
            ),


            Row(
                children:[
                  Text(
                    'Date',
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'Ember Light'
                    ),
                  )
                ]
            ),

            Row(
                children:[
                  Text(
                    review?.FormattedDate ??'dummy test',

                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Ember Light',
                      decoration: TextDecoration.underline,

                    ),
                  )
                ]
            ),



            Row(
                children:[
                  Text(
                    'Product',
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'Ember Light'
                    ),
                  )
                ]
            ),

            Row(
                children:[
                  Text(
                    review?.ProductName ??'dummy test',

                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Ember Light',
                      decoration: TextDecoration.underline,

                    ),
                  )
                ]
            ),

            Row(
                children:[
                  Text(
                    'Customer',
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'Ember Light'
                    ),
                  )
                ]
            ),

            Row(
                children:[
                  Text(
                    review?.CustomerName ??'dummy test',

                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Ember Light',
                      decoration: TextDecoration.underline,

                    ),
                  )
                ]
            ),

            Row(
                children:[
                  Text(
                    'Rating',
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'Ember Light'
                    ),
                  )
                ]
            ),

            Row(
                children:List.generate(review?.ReviewStars ?? 0, (index){
                  return Icon(Icons.star,size: 40,);
                })
            ),

            Row(
                children:[
                  Text(
                    'Description',
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'Ember Light'
                    ),
                  )
                ]
            ),

            Row(
                children:[
                  Expanded(
                  child:SingleChildScrollView(
                    child:Text(
                      review?.ReviewStatement ??'dummy test',

                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Ember Light',
                        decoration: TextDecoration.underline,

                      ),

                    ),
                  )

                  )
                ]
            ),


            SizedBox(height: 20,),





          ],
        ),
      )

    );
  }
}