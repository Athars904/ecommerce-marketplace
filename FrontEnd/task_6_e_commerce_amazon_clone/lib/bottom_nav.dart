import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/customer_cart.dart';
import 'package:task_6_e_commerce_amazon_clone/customer_home.dart';
import 'package:task_6_e_commerce_amazon_clone/customer_profile.dart';
import 'package:task_6_e_commerce_amazon_clone/customer_settings.dart';

class BottomNav extends ConsumerWidget{

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerHome()));
            },
            child: Icon(Icons.home, size: 40),
          ),

          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerProfile()));
            },
            child: Icon(Icons.person, size: 40),
          ),

          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerCart()));
            },
            child: Icon(Icons.shopping_cart, size: 40),
          ),

          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerSettings()));
            },
            child: Icon(Icons.menu, size: 40),
          )
        ],
      ),
    );
  }
}