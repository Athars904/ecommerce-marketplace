import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';
import 'package:task_6_e_commerce_amazon_clone/search_results.dart';

class CustomAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget{

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);


  @override
  ConsumerState<CustomAppBar> createState() => CustomAppBarState();
}

class CustomAppBarState extends ConsumerState<CustomAppBar>{

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context){
    // searchController.text = '';

    return AppBar(
      title: Container(

        padding: EdgeInsets.only(left: 10,right: 10),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),

        child: Row(

          children: [

            SizedBox(width: 15,),

            Expanded(
                child:TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                      hintText: 'Search Amazon.com ...',
                      hintStyle: TextStyle(
                        fontFamily: 'Ember',
                      ),
                      border: InputBorder.none


                  ),
                )
            ),

            GestureDetector(
              onTap: (){
                if(searchController.text.toString() != ''){
                      ref.read(searchProvider.state).state = searchController.text.toString();
                      print(ref.read(searchProvider));
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchResults()));
                }

              },
              child: Icon((Icons.search)),

            ),

            SizedBox(
              width: 8,
            ),
          ],
        ),
      ),


      centerTitle: true,
      backgroundColor: Color(0XFF91DDD8),
      automaticallyImplyLeading: false,
    );

  }
}