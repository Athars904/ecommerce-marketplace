import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/app_bar.dart';
import 'package:task_6_e_commerce_amazon_clone/bottom_nav.dart';
import 'package:task_6_e_commerce_amazon_clone/customer_edit_profile.dart';
import 'package:task_6_e_commerce_amazon_clone/nav_bar.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';
import 'package:task_6_e_commerce_amazon_clone/seller_edit_profile.dart';

class CustomerProfile extends ConsumerStatefulWidget{

  @override
  ConsumerState<CustomerProfile> createState()=> CustomerProfileState();

}

class CustomerProfileState extends ConsumerState<CustomerProfile>{

  @override
  Widget build(BuildContext context){
    var customerDetails1 = ref.watch(customerDetailsProvider);
    return customerDetails1.when(
        data: (customer){
          return Scaffold(
              drawer:NavBar(),
              appBar: CustomAppBar(),

              body:Padding(
                padding: EdgeInsets.only(top: 20,left: 30),

                child: Column(
                  children: [

                    Row(
                        children: [
                          Text(
                            'Your Profile',
                            style: TextStyle(
                                fontSize: 40,
                                fontFamily: 'Ember'
                            ),

                          ),
                        ]
                    ),


                    Row(
                        children:[
                          Text(
                            'Email',
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
                            customer?.Email ??'dummyemail@gmail.com',

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
                            'Name',
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
                            customer?.Name??'Dummy Name',

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
                            'Phone Number',
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
                            customer?.Phone??'00000000000',

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
                            'Address',
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
                            customer?.Address?? '00000000000',

                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Ember Light',
                              decoration: TextDecoration.underline,

                            ),
                          )
                        ]
                    ),


                    Row(
                        children:[Expanded(
                          child:
                          Padding(
                              padding: EdgeInsets.only(top: 40,right: 30),


                              child:Container(
                                  height: 80,
                                  child:ElevatedButton(
                                      onPressed: (() =>{
                                        Navigator.push(context,MaterialPageRoute(builder: (context)=>CustomerEditProfile()))
                                      }),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color((0xFFFF9900)),

                                      ),
                                      child: const Text('Edit',
                                        style: TextStyle(
                                          fontFamily: 'Ember Light',
                                          fontSize: 35,
                                          color: Colors.black,
                                        ),
                                      )

                                  )
                              )
                          )
                          ,
                        )
                        ]
                    )


                  ],
                ),

              ),

            bottomNavigationBar: BottomNav(),
          );



        },
        loading: (){
          return Center(child: CircularProgressIndicator());
        },
        error: (error,stackTree){
          print("error occured in fetching seller data " );
          print(error);
          return Center(child:Text("Error occured"));
        }

    );

  }

}