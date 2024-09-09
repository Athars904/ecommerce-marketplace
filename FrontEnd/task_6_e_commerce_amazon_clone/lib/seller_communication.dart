import 'package:flutter/material.dart';

class SellerCommunication extends StatefulWidget{

  @override
  State<SellerCommunication> createState()=> SellerCommunicationState();
}

class SellerCommunicationState extends State<SellerCommunication>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person,color: Colors.white,size:40),
            Container(
              width: 10,
            ),
            Text('Ahmad',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Ember',
              color: Colors.white

            ),)
          ],
        ),
        leading:

        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: Colors.white, size: 30,),
        ),
        //centerTitle: true,
        //automaticallyImplyLeading: false,
        backgroundColor: Color(0XFF232F3E),

      ),

      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person,size: 60,),
            title:Container(

              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(15),
                color:Color(0XFF232F3E) ,

              ),

              child: Padding(
                padding: EdgeInsets.all(15),
                child:Text(
                  'I want to place an order',
                  style: TextStyle(
                      fontFamily: 'Ember',
                      fontSize: 15,
                      color: Colors.white
                  ),
                ),
              )

            )
          )
        ],
      ),

      bottomNavigationBar: Container(

        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:Color(0XFF232F3E) ,
        ),

        child: Padding(
          padding: EdgeInsets.only(top: 0,bottom:5,left: 10,right: 10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Type a message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send,color: Colors.white,),
                onPressed: () {
                  // Your send message logic here
                },
              ),
            ],
          ),
        )

      ),

    );

  }

}