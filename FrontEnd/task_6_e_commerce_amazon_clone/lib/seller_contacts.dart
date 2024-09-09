import 'package:flutter/material.dart';
import 'package:task_6_e_commerce_amazon_clone/nav_bar.dart';
import 'package:task_6_e_commerce_amazon_clone/seller_communication.dart';

class SellerContacts extends StatefulWidget{
  @override
  State<SellerContacts> createState() => SellerContacatsState();
}

class SellerContacatsState extends State<SellerContacts>{

  @override
  Widget build(BuildContext context){
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

      body:ListView(
        children: [

          Container(
            //height: 100,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 2
                )

              ),
            ),

            child: ListTile(
              onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => SellerCommunication())) ,
              leading: Icon(Icons.person,size: 70,),
              title: Text('Ahmad',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Ember'
              ),),

              subtitle:Text('I want to place an order',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Ember'
                ),),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.date_range),
                  Text('22/2/2024',
                  style: TextStyle(
                    fontFamily: 'Ember',
                    fontSize: 10
                  ),)
                ],
              ),


            ),
          ),


          Container(
            //height: 100,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.black,
                      width: 2
                  )

              ),
            ),

            child: ListTile(
              leading: Icon(Icons.person,size: 70,),
              title: Text('Ahmad',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Ember'
                ),),

              subtitle:Text('I want to place an order',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Ember'
                ),),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.date_range),
                  Text('22/2/2024',
                    style: TextStyle(
                        fontFamily: 'Ember',
                        fontSize: 10
                    ),)
                ],
              ),


            ),
          ),



          Container(
            //height: 100,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.black,
                      width: 2
                  )

              ),
            ),

            child: ListTile(
              leading: Icon(Icons.person,size: 70,),
              title: Text('Ahmad',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Ember'
                ),),

              subtitle:Text('I want to place an order',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Ember'
                ),),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.date_range),
                  Text('22/2/2024',
                    style: TextStyle(
                        fontFamily: 'Ember',
                        fontSize: 10
                    ),)
                ],
              ),


            ),
          ),

          Container(
            //height: 100,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.black,
                      width: 2
                  )

              ),
            ),

            child: ListTile(
              leading: Icon(Icons.person,size: 70,),
              title: Text('Ahmad',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Ember'
                ),),

              subtitle:Text('I want to place an order',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Ember'
                ),),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.date_range),
                  Text('22/2/2024',
                    style: TextStyle(
                        fontFamily: 'Ember',
                        fontSize: 10
                    ),)
                ],
              ),


            ),
          ),

          Container(
            //height: 100,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.black,
                      width: 2
                  )

              ),
            ),

            child: ListTile(
              leading: Icon(Icons.person,size: 70,),
              title: Text('Ahmad',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Ember'
                ),),

              subtitle:Text('I want to place an order',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Ember'
                ),),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.date_range),
                  Text('22/2/2024',
                    style: TextStyle(
                        fontFamily: 'Ember',
                        fontSize: 10
                    ),)
                ],
              ),


            ),
          ),

          Container(
            //height: 100,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.black,
                      width: 2
                  )

              ),
            ),

            child: ListTile(
              leading: Icon(Icons.person,size: 70,),
              title: Text('Ahmad',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Ember'
                ),),

              subtitle:Text('I want to place an order',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Ember'
                ),),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.date_range),
                  Text('22/2/2024',
                    style: TextStyle(
                        fontFamily: 'Ember',
                        fontSize: 10
                    ),)
                ],
              ),


            ),
          ),

          Container(
            //height: 100,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.black,
                      width: 2
                  )

              ),
            ),

            child: ListTile(
              leading: Icon(Icons.person,size: 70,),
              title: Text('Ahmad',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Ember'
                ),),

              subtitle:Text('I want to place an order',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Ember'
                ),),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.date_range),
                  Text('22/2/2024',
                    style: TextStyle(
                        fontFamily: 'Ember',
                        fontSize: 10
                    ),)
                ],
              ),


            ),
          ),

          Container(
            //height: 100,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.black,
                      width: 2
                  )

              ),
            ),

            child: ListTile(
              leading: Icon(Icons.person,size: 70,),
              title: Text('Ahmad',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Ember'
                ),),

              subtitle:Text('I want to place an order',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Ember'
                ),),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.date_range),
                  Text('22/2/2024',
                    style: TextStyle(
                        fontFamily: 'Ember',
                        fontSize: 10
                    ),)
                ],
              ),


            ),
          ),

          Container(
            //height: 100,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.black,
                      width: 2
                  )

              ),
            ),

            child: ListTile(
              leading: Icon(Icons.person,size: 70,),
              title: Text('Ahmad',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Ember'
                ),),

              subtitle:Text('I want to place an order',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Ember'
                ),),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.date_range),
                  Text('22/2/2024',
                    style: TextStyle(
                        fontFamily: 'Ember',
                        fontSize: 10
                    ),)
                ],
              ),


            ),
          ),

          Container(
            //height: 100,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.black,
                      width: 2
                  )

              ),
            ),

            child: ListTile(
              leading: Icon(Icons.person,size: 70,),
              title: Text('Ahmad',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Ember'
                ),),

              subtitle:Text('I want to place an order',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Ember'
                ),),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.date_range),
                  Text('22/2/2024',
                    style: TextStyle(
                        fontFamily: 'Ember',
                        fontSize: 10
                    ),)
                ],
              ),


            ),
          ),

          Container(
            //height: 100,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.black,
                      width: 2
                  )

              ),
            ),

            child: ListTile(
              leading: Icon(Icons.person,size: 70,),
              title: Text('Ahmad',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Ember'
                ),),

              subtitle:Text('I want to place an order',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Ember'
                ),),


              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.date_range),
                  Text('22/2/2024',
                    style: TextStyle(
                        fontFamily: 'Ember',
                        fontSize: 10
                    ),)
                ],
              ),


            ),
          ),




        ],
      )



    );


  }

}