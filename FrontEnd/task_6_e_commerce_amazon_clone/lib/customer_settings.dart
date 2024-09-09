import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/app_bar.dart';
import 'package:task_6_e_commerce_amazon_clone/bottom_nav.dart';
import 'package:task_6_e_commerce_amazon_clone/category_options.dart';
import 'package:task_6_e_commerce_amazon_clone/customer_login_page.dart';
import 'package:task_6_e_commerce_amazon_clone/customer_orders.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';

class CustomerSettings extends ConsumerStatefulWidget{
  @override
  ConsumerState<CustomerSettings> createState()=>CustomerSettingsState();
}

class CustomerSettingsState extends ConsumerState<CustomerSettings>{

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

    String? customerName = ref.watch(customerDetailsProvider).maybeWhen(
      data: (customer) => customer?.Name,
      orElse: () => null,
    );

    if (customerName == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading...'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }



    return Scaffold(
      appBar: CustomAppBar(),

      body: ListView(
        padding: EdgeInsets.only(top: 20,bottom: 20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Hello $customerName ',
              style: TextStyle(
                fontFamily: 'Ember',
                fontSize: 30
              ),)
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('How are you doing today? ',
                style: TextStyle(
                    fontFamily: 'Ember',
                    fontSize: 20
                ),)
            ],
          ),

          SizedBox(height: 20,),

          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.black,
                  width: 1
                ),
                bottom: BorderSide(
              color: Colors.black,
                  width: 1
              )
            ),
          ),

            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>CustomerOrders()));
              },

              child: Row(
                children: [
                  SizedBox(width: 20,),

                  Text('Track Your Orders',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Ember'
                  ),
                  ),

                  SizedBox(width: 150,),

                  Icon(Icons.arrow_forward),
                ],
              )
            ),
          ),

          Container(
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: Colors.black,
                      width: 1
                  ),
                  bottom: BorderSide(
                      color: Colors.black,
                      width: 1
                  )
              ),
            ),

            padding: EdgeInsets.all(10),
            child: GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>CategoryOptions()));
                },

                child: Row(
                  children: [
                    SizedBox(width: 20,),

                    Text('Shop by Category',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Ember'
                      ),
                    ),

                    SizedBox(width: 150,),

                    Icon(Icons.arrow_forward),
                  ],
                )
            ),
          ),

          Container(
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: Colors.black,
                      width: 1
                  ),
                  bottom: BorderSide(
                      color: Colors.black,
                      width: 1
                  )
              ),
            ),

            padding: EdgeInsets.all(10),
            child: GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>CustomerLoginPage()));
                },

                child: Row(
                  children: [
                    SizedBox(width: 20,),

                    Text('Logout',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Ember'
                      ),
                    ),

                    SizedBox(width: 250,),

                    Icon(Icons.logout),
                  ],
                )
            ),
          ),




        ],
      ),



      bottomNavigationBar: BottomNav(),
    );
  }


}