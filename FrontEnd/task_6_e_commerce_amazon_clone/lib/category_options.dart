import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/app_bar.dart';
import 'package:task_6_e_commerce_amazon_clone/bottom_nav.dart';
import 'package:task_6_e_commerce_amazon_clone/category_results.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';

class CategoryOptions extends ConsumerStatefulWidget{

  @override
  ConsumerState<CategoryOptions> createState() => CategoryOptionsState();
}

class CategoryOptionsState extends ConsumerState<CategoryOptions>{
  String? selectedDept;
  int? selectedCategory;

  List<String> DeptOptions = ['Computers', 'Baby', 'Personal Beauty'];
  List<String> ComputersOptions = ['Components', 'Accessories'];
  List<String> BabyOptions = ['Apparel', 'Care'];
  List<String> PersonalOptions = ['Skincare', 'Haircare'];

  Map<String,int> categoryMap = {
    'Components' : 1,
    'Accessories' : 2,
    'Apparel' : 3,
    'Care' : 4,
    'Skincare':5,
    'Haircare':6



  };

  @override
  Widget build(BuildContext context){
    List<String> options2 = [];
    if (selectedDept == 'Computers') {
      options2 = ComputersOptions;
    } else if (selectedDept == 'Baby') {
      options2 = BabyOptions;
    } else if (selectedDept == 'Personal Beauty') {
      options2 = PersonalOptions;
    }

    return Scaffold(
      appBar: CustomAppBar(),

      body: Column(
        children: [
          SizedBox(height: 20,),
          Text(
            'Shop by Category',
            style: TextStyle(
              fontFamily: 'Ember',
              fontSize: 30,
            ),
          ),
          SizedBox(height: 20,),
          Text(
            'Department',
            style: TextStyle(
              fontFamily: 'Ember',
              fontSize: 30,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text(
                        'Department',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Ember',
                        ),
                      ),
                      value: selectedDept,
                      items: DeptOptions.map((String item) {
                        return DropdownMenuItem<String>(
                          child: Text(item),
                          value: item,
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDept = newValue;
                          selectedCategory = null;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 10,
          ),
          Text(
            'Category',
            style: TextStyle(
              fontFamily: 'Ember',
              fontSize: 30,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton<int>(
                      isExpanded: true,
                      hint: Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Ember',
                        ),
                      ),
                      value: selectedCategory,
                      items: options2.map((String item) {
                        return DropdownMenuItem<int>(
                          child: Text(item),
                          value: categoryMap[item],
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          //print(newValue);
                          selectedCategory = newValue;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 100,
          ),

          SizedBox(
            height: 80,
            width: 250,
            child: ElevatedButton(
              onPressed: () {
                if(selectedCategory!=null ){
                  print(selectedCategory);
                  ref.read(categoryProvider.state).state=selectedCategory;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryResults()));

                }
                 },
              child: Text(
                'Shop Now!',
                style: TextStyle(
                  fontFamily: 'Ember',
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0XFFFF9900),
              ),
            ),
          ),

        ],
      ),
      bottomNavigationBar: BottomNav(),


    );
  }
}