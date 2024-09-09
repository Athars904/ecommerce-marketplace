import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/add_a_product.dart';
import 'package:task_6_e_commerce_amazon_clone/manage_orders.dart';
import 'package:task_6_e_commerce_amazon_clone/manage_products.dart';
import 'package:task_6_e_commerce_amazon_clone/options.dart';
import 'package:task_6_e_commerce_amazon_clone/reviews.dart';
import 'package:task_6_e_commerce_amazon_clone/seller_contacts.dart';
import 'package:task_6_e_commerce_amazon_clone/seller_home.dart';
import 'package:task_6_e_commerce_amazon_clone/seller_login_page.dart';
import 'package:task_6_e_commerce_amazon_clone/seller_profile.dart';
import 'package:task_6_e_commerce_amazon_clone/transaction_history.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';

class NavBar extends ConsumerWidget{

  @override
  Widget build(BuildContext context,WidgetRef ref){
    var sellerDetails = ref.watch(sellerDetailsProvider);
    return Drawer(

      child:Padding(
          padding: EdgeInsets.zero,

      child:ListView(
        padding: EdgeInsets.zero,

        children: [

         sellerDetails.when(data: (seller){
           return UserAccountsDrawerHeader(
              accountName: Text(
                seller?.Name?? 'Dayyan',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Ember'
                ),),

              accountEmail: Text(
                seller?.Email?? 'dayyan@gmail.com',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Ember'
                ),),

              decoration: BoxDecoration(
                color: Color(0XFF232F3E),
              ),



            );

          },
          error: (error,stackTree){
            return Text("error occured");
          }, loading: (){
            return CircularProgressIndicator();
              }),


          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 2,
                )
              )
            ),
            child:ListTile(
              leading: Icon(Icons.person,size: 40,),
              title:Text('Profile',
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Ember'
                ),),

              onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>SellerProfile())),
            )

          ),

          Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2,
                      )
                  )
              ),
              child:ListTile(
                leading: Icon(Icons.home,size: 40,),
                title:Text('Home',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Ember'
                  ),),

                onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>SellerHome())),
              )

          ),


          Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2,
                      )
                  )
              ),
              child:ListTile(
                leading: Icon(Icons.add,size: 40,),
                title:Text('Add a Product',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Ember'
                  ),),

                onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>AddAProduct())),
              )

          ),

          Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2,
                      )
                  )
              ),
              child:ListTile(
                leading: Icon(Icons.manage_search,size: 40,),
                title:Text('Manage Products',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Ember'
                  ),),

                onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>ManageProducts())),
              )

          ),

          Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2,
                      )
                  )
              ),
              child:ListTile(
                leading: Icon(Icons.manage_search,size: 40,),
                title:Text('Manage Orders',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Ember'
                  ),),

                onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>ManageOrders())),
              )

          ),

          Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2,
                      )
                  )
              ),
              child:ListTile(
                leading: Icon(Icons.monetization_on,size: 40,),
                title:Text('Payments',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Ember'
                  ),),

                onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>TransactionHistory())),
              )

          ),




          Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2,
                      )
                  )
              ),
              child:ListTile(
                leading: Icon(Icons.feedback,size: 40,),
                title:Text('Reviews',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Ember'
                  ),),

                onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>Reviews())),
              )

          ),

          Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2,
                      )
                  )
              ),
              child:ListTile(
                leading: Icon(Icons.logout,size: 40,),
                title:Text('Logout',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Ember'
                  ),),

                onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>SellerLoginPage())),
              )

          ),




        ],
      ),
      )


    );
  }


}