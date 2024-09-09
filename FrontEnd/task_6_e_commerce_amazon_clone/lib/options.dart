import 'package:flutter/material.dart';
import 'package:task_6_e_commerce_amazon_clone/customer_login_page.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';
import 'package:task_6_e_commerce_amazon_clone/seller_login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/seller_model.dart';
import 'package:task_6_e_commerce_amazon_clone/seller_signup_page.dart';

class Options extends ConsumerStatefulWidget {

  @override
  ConsumerState<Options> createState() => OptionsState();

}

class OptionsState extends ConsumerState<Options>{





  @override
  Widget build (BuildContext context){


    return Scaffold(
      body:Stack(
        children: [
          Image.asset('images/amazon-png-logo-vector-6695.png'),

           Padding(
            padding: EdgeInsets.only(top:200),
            child:Column(
                children:[
                 const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("WELCOME",
                        style: TextStyle(
                        fontFamily: 'Ember',
                        fontSize: 40,
                      ),),
                  ]
            ),

                  Container(
                    height: 100,
                  ),

                  const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("I am a",
                        style: TextStyle(
                          fontFamily: 'Ember Light',
                          fontSize: 40,
                        ),),
                      ]
                  ),

                  Container(
                    height:50,
                  ),

                  Container(
                  width: 350,
                  height: 100,
                  child:ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerLoginPage()));
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF9900),

                      ),
                      child: const Text('Customer',
                      style: TextStyle(
                        fontFamily: 'Ember Light',
                        fontSize: 35,
                        color: Colors.black,
                      ),
                      )

                  )
                  ),

                  Container(
                    height:10,
                  ),

                  Container(
                      width: 350,
                      height: 100,
                      child:ElevatedButton(
                          onPressed: () =>{
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>SellerLoginPage()) )
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFF9900),

                          ),
                          child: const Text('Seller',
                            style: TextStyle(
                              fontFamily: 'Ember Light',
                              fontSize: 35,
                              color: Colors.black,
                            ),
                          )

                      )
                  )

                ]
          ),
          ),








        ],
      )

       );
  }
}