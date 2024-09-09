import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/Controllers/order_controller.dart';
import 'package:task_6_e_commerce_amazon_clone/add_a_product.dart';
import 'package:task_6_e_commerce_amazon_clone/bar_graph/my_bar_graph.dart';
import 'package:task_6_e_commerce_amazon_clone/manage_orders.dart';
import 'package:task_6_e_commerce_amazon_clone/manage_products.dart';
import 'package:task_6_e_commerce_amazon_clone/nav_bar.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';
import 'package:task_6_e_commerce_amazon_clone/reviews.dart';
import 'package:task_6_e_commerce_amazon_clone/seller_contacts.dart';
import 'package:task_6_e_commerce_amazon_clone/transaction_history.dart';

class SellerHome extends ConsumerStatefulWidget {

  @override
  ConsumerState<SellerHome> createState() => SellerHomeState();

}

class SellerHomeState extends ConsumerState<SellerHome>{

  String? selectedValue1 = 'Units Sold';

//  String? selectedValue2;

  List<String> _itemsList1 = [
    'Units Sold',
    'Amount made'
  ];

  // List<String> _itemsList2 = [
  //   'Last 12 Months',
  //   'Last 6 Months',
  //   'This Month',
  //   'Life Time'
  // ];

  @override
  Widget build(BuildContext context){

    var seller = ref.watch(sellerDetailsProvider);


    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white,size: 40),

        title: Image.asset('images/PngItem_12080.png',height: 38),
        centerTitle: true,
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
        body:seller.when(data: (seller){

          int? storeID = seller?.StoreID;

          if(selectedValue1=='Units Sold'){
            return Column(
                children: [

                  SizedBox(height: 20,),
                  Container(

                      width: 350,
                      decoration: BoxDecoration(
                          border:Border.all()
                      ),

                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Expanded(child: Padding(
                              padding: EdgeInsets.only(left: 20,right: 10),
                              child: DropdownButton<String>(

                                hint:Text('Measure',style: TextStyle(fontSize: 20,fontFamily: 'Ember'),),
                                value: selectedValue1 ,

                                isExpanded: true,

                                items: _itemsList1.map((String item) {
                                  return DropdownMenuItem<String>(
                                    child: Text(item),
                                    value:item,
                                  );
                                }).toList(),


                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValue1= newValue;
                                    if(selectedValue1=='Units Sold'){
                                      ref.read(optionProvider.state).state=1;
                                    }else{
                                      ref.read(optionProvider.state).state=2;
                                    }
                                  });
                                },


                              ),),
                            )
                          ]
                      )
                  ),


                  SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.only(top: 10,left: 20,right: 20),
                    child: Row(
                      children: [

                        ref.watch(getAllUnits(storeID!)).when(
                            data: (total){

                              return Container(
                                height: 70,
                                width: 165,
                                decoration: BoxDecoration(
                                    border:Border.all()
                                ),

                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('$total',
                                          style: TextStyle(
                                            fontFamily: 'Ember',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),),

                                        Container(
                                          width: 5,
                                        ),





                                      ],
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Total Sold ',
                                          style: TextStyle(
                                            fontFamily: 'Ember',
                                            fontSize: 20,
                                          ),
                                        )
                                      ],
                                    )


                                  ],
                                ),
                              );

                            }, error: (error,stackTree){
                          return Text('Error occured');
                        }, loading: (){
                          return CircularProgressIndicator();
                        }),



                        Container(
                          height: 70,
                          width: 20,
                        ),

                        Container(
                          height: 70,
                          width: 165,
                          decoration: BoxDecoration(
                              border:Border.all()
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ref.watch(getTodaysUnits(storeID)).when(
                                      data: (total){
                                        return Text('$total',
                                          style: TextStyle(
                                            fontFamily: 'Ember',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),);
                                      },
                                      error: (error,stackTree){
                                        return Text('error occured');
                                      },
                                      loading: (){
                                        return CircularProgressIndicator();
                                      })





                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Units Today',
                                    style: TextStyle(
                                      fontFamily: 'Ember',
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              )


                            ],
                          ),

                        ),

                      ],


                    ),
                  ),




                  Padding(
                      padding: EdgeInsets.only(top: 29),
                      child:SizedBox(
                        height: 200,
                        width: 1000,
                        child:MyBarGraph(),
                      )
                  ),

                  Expanded(
                      child:Padding(padding: EdgeInsets.only(top:20),
                          child:ListView(
                            //children:[Row(
                            //children: [
                            //    Expanded(child:ListView(

                              children: [

                                GestureDetector(
                                  onTap: (()=>{
                                    Navigator.push(context,MaterialPageRoute(builder: (context) => AddAProduct()))
                                  }),
                                  child:Container(

                                    decoration: const BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.black,
                                                width: 1
                                            )
                                        )
                                    ),
                                    child: const ListTile(
                                      leading: Icon(Icons.add),
                                      title: Text('Add a Product',
                                        style: TextStyle(
                                            fontFamily: 'Ember Light',
                                            fontSize: 20
                                        ),),

                                      trailing: Icon(Icons.arrow_forward),

                                    ),
                                  ),
                                ),



                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context,MaterialPageRoute(builder: (context) =>ManageProducts()));
                                  },
                                  child: Container(

                                    decoration:const  BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.black,
                                                width: 1
                                            )
                                        )
                                    ),
                                    child: const ListTile(
                                      leading: Icon(Icons.manage_search),
                                      title: Text('Manage Products',
                                        style: TextStyle(
                                            fontFamily: 'Ember Light',
                                            fontSize: 20
                                        ),),

                                      trailing: Icon(Icons.arrow_forward),
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => ManageOrders())),
                                  child:Container(

                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.black,
                                                width: 1
                                            )
                                        )
                                    ),
                                    child: ListTile(
                                      leading: Icon(Icons.manage_search),
                                      title: Text('Manage Orders',
                                        style: TextStyle(
                                            fontFamily: 'Ember Light',
                                            fontSize: 20
                                        ),),

                                      trailing: Icon(Icons.arrow_forward),
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () => Navigator.push(context,MaterialPageRoute(builder: (contet) => TransactionHistory())),
                                  child: Container(

                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.black,
                                                width: 1
                                            )
                                        )
                                    ),
                                    child: ListTile(
                                      leading: Icon(Icons.monetization_on),
                                      title: Text('Payments',
                                        style: TextStyle(
                                            fontFamily: 'Ember Light',
                                            fontSize: 20
                                        ),),

                                      trailing: Icon(Icons.arrow_forward),
                                    ),
                                  ),

                                ),


                                GestureDetector(
                                  onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => Reviews())),
                                  child:
                                  Container(

                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.black,
                                                width: 1
                                            )
                                        )
                                    ),
                                    child: ListTile(
                                      leading: Icon(Icons.feedback),
                                      title: Text('Reviews',
                                        style: TextStyle(
                                            fontFamily: 'Ember Light',
                                            fontSize: 20
                                        ),),

                                      trailing: Icon(Icons.arrow_forward),
                                    ),
                                  ),
                                )



                              ]

                          )

                      )
                  )


                  //    ],
                  //)
                ]
            );

          }
          else{
             return Column(
                children: [

                  SizedBox(height: 20,),
                  Container(

                      width: 350,
                      decoration: BoxDecoration(
                          border:Border.all()
                      ),

                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Expanded(child: Padding(
                              padding: EdgeInsets.only(left: 20,right: 10),
                              child: DropdownButton<String>(

                                hint:Text('Measure',style: TextStyle(fontSize: 20,fontFamily: 'Ember'),),
                                value: selectedValue1 ,

                                isExpanded: true,

                                items: _itemsList1.map((String item) {
                                  return DropdownMenuItem<String>(
                                    child: Text(item),
                                    value:item,
                                  );
                                }).toList(),


                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValue1= newValue;
                                    if(selectedValue1=='Units Sold'){
                                      ref.read(optionProvider.state).state=1;
                                    }else{
                                      ref.read(optionProvider.state).state=2;
                                    }
                                  });
                                },


                              ),),
                            )
                          ]
                      )
                  ),


                  SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.only(top: 10,left: 20,right: 20),
                    child: Row(
                      children: [

                        ref.watch(getTotalAmount(storeID!)).when(
                            data: (total){

                              return Container(
                                height: 70,
                                width: 165,
                                decoration: BoxDecoration(
                                    border:Border.all()
                                ),

                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('$total Pkr.',
                                          style: TextStyle(
                                            fontFamily: 'Ember',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),),

                                        Container(
                                          width: 5,
                                        ),





                                      ],
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Total Earned',
                                          style: TextStyle(
                                            fontFamily: 'Ember',
                                            fontSize: 20,
                                          ),
                                        )
                                      ],
                                    )


                                  ],
                                ),
                              );

                            }, error: (error,stackTree){
                          return Text('Error occured');
                        }, loading: (){
                          return CircularProgressIndicator();
                        }),



                        Container(
                          height: 70,
                          width: 20,
                        ),

                        Container(
                          height: 70,
                          width: 165,
                          decoration: BoxDecoration(
                              border:Border.all()
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ref.watch(getTodaysAmount(storeID)).when(
                                      data: (total){
                                        return Text('$total Pkr.',
                                          style: TextStyle(
                                            fontFamily: 'Ember',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),);
                                      },
                                      error: (error,stackTree){
                                        return Text('error occured');
                                      },
                                      loading: (){
                                        return CircularProgressIndicator();
                                      })





                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Earned Today',
                                    style: TextStyle(
                                      fontFamily: 'Ember',
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              )


                            ],
                          ),

                        ),

                      ],


                    ),
                  ),




                  Padding(
                      padding: EdgeInsets.only(top: 29),
                      child:SizedBox(
                        height: 200,
                        width: 1000,
                        child:MyBarGraph(),
                      )
                  ),

                  Expanded(
                      child:Padding(padding: EdgeInsets.only(top:20),
                          child:ListView(
                            //children:[Row(
                            //children: [
                            //    Expanded(child:ListView(

                              children: [

                                GestureDetector(
                                  onTap: (()=>{
                                    Navigator.push(context,MaterialPageRoute(builder: (context) => AddAProduct()))
                                  }),
                                  child:Container(

                                    decoration: const BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.black,
                                                width: 1
                                            )
                                        )
                                    ),
                                    child: const ListTile(
                                      leading: Icon(Icons.add),
                                      title: Text('Add a Product',
                                        style: TextStyle(
                                            fontFamily: 'Ember Light',
                                            fontSize: 20
                                        ),),

                                      trailing: Icon(Icons.arrow_forward),

                                    ),
                                  ),
                                ),



                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context,MaterialPageRoute(builder: (context) =>ManageProducts()));
                                  },
                                  child: Container(

                                    decoration:const  BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.black,
                                                width: 1
                                            )
                                        )
                                    ),
                                    child: const ListTile(
                                      leading: Icon(Icons.manage_search),
                                      title: Text('Manage Products',
                                        style: TextStyle(
                                            fontFamily: 'Ember Light',
                                            fontSize: 20
                                        ),),

                                      trailing: Icon(Icons.arrow_forward),
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => ManageOrders())),
                                  child:Container(

                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.black,
                                                width: 1
                                            )
                                        )
                                    ),
                                    child: ListTile(
                                      leading: Icon(Icons.manage_search),
                                      title: Text('Manage Orders ',
                                        style: TextStyle(
                                            fontFamily: 'Ember Light',
                                            fontSize: 20
                                        ),),

                                      trailing: Icon(Icons.arrow_forward),
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () => Navigator.push(context,MaterialPageRoute(builder: (contet) => TransactionHistory())),
                                  child: Container(

                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.black,
                                                width: 1
                                            )
                                        )
                                    ),
                                    child: ListTile(
                                      leading: Icon(Icons.monetization_on),
                                      title: Text('Payments',
                                        style: TextStyle(
                                            fontFamily: 'Ember Light',
                                            fontSize: 20
                                        ),),

                                      trailing: Icon(Icons.arrow_forward),
                                    ),
                                  ),

                                ),






                                GestureDetector(
                                  onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => Reviews())),
                                  child:
                                  Container(

                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.black,
                                                width: 1
                                            )
                                        )
                                    ),
                                    child: ListTile(
                                      leading: Icon(Icons.feedback),
                                      title: Text('Reviews',
                                        style: TextStyle(
                                            fontFamily: 'Ember Light',
                                            fontSize: 20
                                        ),),

                                      trailing: Icon(Icons.arrow_forward),
                                    ),
                                  ),
                                )



                              ]

                          )

                      )
                  )


                  //    ],
                  //)
                ]
            );
            ;
          }

                },

            error: (error,stackTree){
              return Text("error occured fetching seller details");
            }, loading: (){
              return CircularProgressIndicator();
            })
          );

      //
      //   ]
      //   )
      // );






  }


}