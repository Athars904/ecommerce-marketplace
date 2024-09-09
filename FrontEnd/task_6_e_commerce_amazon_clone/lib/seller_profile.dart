import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/nav_bar.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';
import 'package:task_6_e_commerce_amazon_clone/seller_edit_profile.dart';

class SellerProfile extends ConsumerStatefulWidget{

  @override
  ConsumerState<SellerProfile> createState()=> SellerProfileState();

}

class SellerProfileState extends ConsumerState<SellerProfile>{

  @override
  Widget build(BuildContext context){
    var sellerDetails1 = ref.watch(sellerDetailsProvider);
    return sellerDetails1.when(
      data: (seller){
        return Scaffold(
            drawer:NavBar(),
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
                          seller?.Email ??'dummyemail@gmail.com',

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
                          seller?.Name??'Dummy Name',

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
                          seller?.Phone??'00000000000',

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
                          'Bank Account Number',
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
                         seller?.BankAccount?? '00000000000',

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
                       'Store Name',
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
                          seller?.StoreName?? 'Dummy Store',

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
                                      Navigator.push(context,MaterialPageRoute(builder: (context)=>SellerEditProfile()))
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

            )
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