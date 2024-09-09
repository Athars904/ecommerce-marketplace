import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/app_bar.dart';
import 'package:task_6_e_commerce_amazon_clone/bottom_nav.dart';
import 'package:task_6_e_commerce_amazon_clone/customer_orders.dart';

class Thanks extends ConsumerStatefulWidget{
  @override
  ConsumerState<Thanks> createState() => ThanksState();
}

class ThanksState extends ConsumerState<Thanks>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: CustomAppBar(),

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your order has been placed !',
            style: TextStyle(
              fontFamily: 'Ember',
              fontSize: 25
            ),),


            Padding(padding: EdgeInsets.all(20),
            child: Row(

              children: [

                Expanded(
                  child: SizedBox(

                    height: 70,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerOrders()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0XFFFF9900),
                      ),
                      child: Text(
                        'Track your order',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Ember',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),)
          ],
        )
      ),

      bottomNavigationBar: BottomNav(),
    );
  }
}