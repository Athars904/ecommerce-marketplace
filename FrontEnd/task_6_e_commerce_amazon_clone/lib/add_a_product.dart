import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/Controllers/product_controller.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/product_model.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';
import 'package:task_6_e_commerce_amazon_clone/nav_bar.dart';
import 'package:image_picker/image_picker.dart';

class AddAProduct extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddAProduct> createState() => AddAProductState();
}

class AddAProductState extends ConsumerState<AddAProduct> {

  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  XFile? selectedImage;
  var imagePicker = ImagePicker();


  Future pickImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.gallery);

    if(image==null){
      return;
    }
    setState(() {
      selectedImage = image;
    });
  }






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
  Widget build(BuildContext context) {
    List<String> options2 = [];
    if (selectedDept == 'Computers') {
      options2 = ComputersOptions;
    } else if (selectedDept == 'Baby') {
      options2 = BabyOptions;
    } else if (selectedDept == 'Personal Beauty') {
      options2 = PersonalOptions;
    }

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
      body: Padding(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: ListView(
          children: [
            Text(
              'Add a Product',
              style: TextStyle(fontSize: 40, fontFamily: 'Ember'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 140,
                  child: GestureDetector(
                    onTap: () => pickImage(),
                    child: selectedImage!=null ? Image.file(File(selectedImage!.path))  : Icon(Icons.camera_alt, size: 170),
                  ),
                )
              ],
            ),

            Text(
              'Department',
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
                      padding: EdgeInsets.only(left: 10),
                      child: DropdownButton<String>(
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
                      padding: EdgeInsets.only(left: 10),
                      child: DropdownButton<int>(
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
              height: 10,
            ),
            Text(
              'Title',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Ember',
              ),
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(
                  fontFamily: 'Ember',
                  fontSize: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),


            Container(
              height: 10,
            ),
            Text(
              'Price',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Ember',
              ),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                hintText: 'Price',
                hintStyle: TextStyle(
                  fontFamily: 'Ember',
                  fontSize: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              height: 10,
            ),
            Text(
              'Quantity',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Ember',
              ),
            ),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(
                hintText: 'Quantity',
                hintStyle: TextStyle(
                  fontFamily: 'Ember',
                  fontSize: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              height: 10,
            ),
            Text(

              'Description',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Ember',
              ),
            ),
            TextField(
              controller: descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: TextStyle(
                  fontFamily: 'Ember',
                  fontSize: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 70,
                    child: ElevatedButton(
                      onPressed: () async {

                        final SellerDetails = await ref.read(sellerDetailsProvider.future);

                        final Store = SellerDetails?.StoreID;


                        if(
                            selectedCategory!=null
                            && titleController.text.toString() != null && titleController.text.toString() != ''
                            && priceController.text.toString() != null && priceController.text.toString() != ''
                            && quantityController.text.toString() != null && quantityController.text.toString() != ''
                            && descriptionController.text.toString() != null && descriptionController.text.toString() != ''
                            && Store != null && Store != ''  && selectedImage !=null){


                          final Title = titleController.text.toString();
                          final Price = int.parse(priceController.text.toString());
                          final Quantity = int.parse(quantityController.text.toString());
                          final Description = descriptionController.text.toString();



                          Product product = Product(Name: Title, Price: Price, StockQuantity: Quantity, StoreID: Store, CategoryID: selectedCategory, Description: Description);

                          final productController = ProductController();
                          bool result = await productController.addAProduct(product,selectedImage);

                          if(result==true){
                            ref.refresh(getProductsProvider(Store));
                            Navigator.pop(context);
                          }
                          else{
                            print("Could not add the product");
                          }

                        }
                        else {
                          print("All fields are required");
                        }
                        },
                      child: Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'Ember',
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0XFFFF9900),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
