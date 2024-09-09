import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/nav_bar.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';
import 'package:task_6_e_commerce_amazon_clone/review_details.dart';

class Reviews extends ConsumerStatefulWidget {

  @override
  ConsumerState<Reviews> createState() => ReviewsState();
}

class ReviewsState extends ConsumerState<Reviews>{

  @override
  Widget build(BuildContext context){
   var seller = ref.watch(sellerDetailsProvider);
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

      body:seller.when(
          data: (seller){
            int? StoreID = seller?.StoreID;
            int number = 0;


            return Column(
                children: [

                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Customer Reviews',
                          style: TextStyle(
                            fontFamily: 'Ember',
                            fontSize: 30,
                          ),
                        )
                      ],
                    ),
                  ),



                  Container(
                    height: 50,
                  ),

                  ref.watch(getAllReviewsProvider(StoreID!)).when(
                      data: (reviews){
                        return Expanded(
                        child :ListView.builder(
                        itemCount: reviews?.length,

                        itemBuilder: (context,index){
                          final review = reviews?[index];
                          number++;
                          return Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: Colors.black,
                                          width: 1
                                      )
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                              ),

                              child: Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: ListTile(



                                    onTap: (){
                                      ref.read(ReviewProvider.state).state=review;
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewDetails()));
                                    },

                                    title: Transform.translate(offset: Offset(-40,0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Review ${number}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'Ember'
                                            ),
                                          ),

                                          Text(
                                            'Product: ${review?.ProductName}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Ember'
                                            ),
                                          ),

                                          Text(
                                            'Customer: ${review?.CustomerName}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Ember'
                                            ),
                                          ),


                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children:
                                              List.generate(review?.ReviewStars?? 0, (index){
                                               return Icon(Icons.star);
                                              }),

                                          )

                                        ],
                                      ),
                                    ),


                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.date_range),

                                        Container(
                                          width: 5,
                                        ),

                                        Text('''${review?.FormattedDate}''',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Ember'
                                          ),)
                                      ],
                                    ),


                                  )


                              )


                          );

                        })
                        );

                        },
                        error: (error,stackTree){
                        return Text("Error occured in fetching reviews");
                        },
                        loading: (){
                        return CircularProgressIndicator();
            }),






                ]
            );
          },
          error: (error,stackTree){
            return Text("Eroor occured");
          },
          loading: (){
            return CircularProgressIndicator();
          })

         );

  }
}