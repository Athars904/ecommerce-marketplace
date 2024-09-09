import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';

import 'nav_bar.dart';

class OrderDetails extends ConsumerStatefulWidget{

  @override
  ConsumerState<OrderDetails> createState()=> OrderDetailsState();
}

class OrderDetailsState extends ConsumerState<OrderDetails>{




  @override
  Widget build(BuildContext context){
    final order = ref.read(OrderProvider);
    int? OrderID = order?.OrderID;
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
      body: Column(
        children: [

          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Order ${order?.OrderID} Details',
                  style: TextStyle(
                    fontFamily: 'Ember',
                    fontSize: 30,
                  ),
                )
              ],
            ),
          ),

          Container(
            height: 20,
          ),

          Padding(padding: EdgeInsets.only(left:30,right: 30),
          child:Row(

            children: [
              Text('Date: ${order?.FormattedDate}',
                style: TextStyle(
                  fontFamily: 'Ember',
                  fontSize: 20,
                ),
              ),

              SizedBox(
                width: 30,
              ),
              Text('Total: ${order?.TotalSum}',
                style: TextStyle(
                  fontFamily: 'Ember',
                  fontSize: 20,
                ),
              )

            ],
          )

            ,),

          Padding(padding: EdgeInsets.only(left:30,right: 30,top: 5),
            child:Row(

              children: [
                Text('Customer: ${order?.CustomerName}',
                  style: TextStyle(
                    fontFamily: 'Ember',
                    fontSize: 20,
                  ),
                ),



              ],
            )

            ,),

          Padding(padding: EdgeInsets.only(left:30,right: 30,top: 5),
            child:Row(

              children: [
                Text('Address: ${order?.CustomerAddress}',
                  style: TextStyle(
                    fontFamily: 'Ember',
                    fontSize: 20,
                  ),
                ),



              ],
            )

            ,),


          Padding(padding: EdgeInsets.only(left:30,right: 30,top: 5),
            child:Row(

              children: [
                Text('Status: ${order?.status}',
                  style: TextStyle(
                    fontFamily: 'Ember',
                    fontSize: 20,
                  ),
                ),


              ],
            )

            ,),

          SizedBox(height: 10,),

          Text('Products Ordered',
            style: TextStyle(
              fontFamily: 'Ember',
              fontSize: 30,
            ),
          ),

          SizedBox(height: 10,),

          ref.watch(OrderDetailsProvider(OrderID!)).when(
              data: (products){
                return Expanded(
                  child: ListView.builder(
                      itemCount: products?.length,

                      itemBuilder: (context,index){
                        final product = products?[index];
                        String? image = product?.image;
                        final imageUrl = 'http://10.0.2.2:3000/uploads/${product?.image}';

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
                                child:ListTile(
                                leading: image!=null ?
                                Container(
                                height: 80,
                                width: 80,
                                child: Image.network(imageUrl,)


                            )
                              : Container(
                          height: 80,
                          width: 80,
                          child: Text('no image'),
                        ),

                        title: Text(
                                    '${product?.Name}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Ember'
                                    ),
                                  ),

                                  subtitle: Text(
                                    'Price ${product?.Price}Pkr Quantity:${product?.StockQuantity}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Ember'
                                    ),



                                  ),




                                )


                            )



                        );


                      })
                  ,
                );
              },
              error: (error,stackTree){
                return Text("Erorr occured while fetching products");
              },
              loading: (){
                return CircularProgressIndicator();
              })


        ],


      ),


    );
}



}