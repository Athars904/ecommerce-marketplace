import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/Controllers/cart_controller.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/cartItem_model.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/product_model.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/store_model.dart';
import 'package:task_6_e_commerce_amazon_clone/add_review.dart';
import 'package:task_6_e_commerce_amazon_clone/app_bar.dart';
import 'package:task_6_e_commerce_amazon_clone/bottom_nav.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';

class ProductDetails extends ConsumerStatefulWidget {
  @override
  ConsumerState<ProductDetails> createState() => ProductDetailsState();
}

class ProductDetailsState extends ConsumerState<ProductDetails> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    Product? product = ref.read(productProvider);
    int? StoreID = product?.StoreID;

    final store = ref.watch(getStoreProvider(StoreID!));
    var customerProvider = ref.watch(customerDetailsProvider);
    int? reviewProductID = product?.ProductID;
    var reviewsProvider = ref.watch(getProductReviewsProvider(reviewProductID!));

    String? image = product?.image;
    final imageUrl = 'http://10.0.2.2:3000/uploads/${product?.image}';


    return Scaffold(
      appBar: CustomAppBar(),
      body: customerProvider.when(
        data: (customer) {
          return store.when(
            data: (store) {
              return ListView(
                children: [
                  
                  Padding(padding: EdgeInsets.all(10),
                  child: Image.network(imageUrl)
                  ),
                  
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Text(
                          '${product?.Name}',
                          style: TextStyle(
                            fontSize: 35,
                            fontFamily: 'Ember',
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              'Price : ',
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Ember',
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Text(
                              '${product?.Price}',
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Ember',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description : ',
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Ember',
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${product?.Description}',
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Ember',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              'Store Name : ',
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Ember',
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${store?.StoreName}',
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Ember',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: product?.StockQuantity == 0
                                ? Center(
                              child: Text(
                                "Out of stock",
                                style: TextStyle(
                                  fontFamily: 'Ember',
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                            )
                                : Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      quantity++;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.black,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    width: 50,
                                    child: Icon(
                                      Icons.add,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 45),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Quantity : ",
                                        style: TextStyle(
                                          fontFamily: 'Ember',
                                          fontSize: 30,
                                        ),
                                      ),
                                      Text(
                                        '$quantity',
                                        style: TextStyle(
                                          fontFamily: 'Ember',
                                          fontSize: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (quantity != 0) {
                                        setState(() {
                                          quantity--;
                                        });
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      width: 50,
                                      child: Icon(
                                        Icons.remove,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (quantity != 0) {
                                int? CustomerID = customer?.CustomerID;
                                CartItem item = CartItem(
                                  CustomerID: CustomerID!,
                                  ProductID: (product?.ProductID)!,
                                  Quantity: quantity,
                                );
                                final controller = CartController();
                                bool result = await controller.AddCartItem(item);
                                if (result == true) {
                                  ref.refresh(getCartItemsProvider(CustomerID));
                                  print('success');
                                } else {
                                  print('false');
                                }
                              }
                            },
                            child: Text(
                              'Add to Cart',
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
                        SizedBox(height: 20),
                        SizedBox(
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AddReview()));
                            },
                            child: Text(
                              'Drop a Review',
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
                  ),
                  SizedBox(height: 20),

                  Padding(padding: EdgeInsets.all(20),child:
                    Text('Customer Reviews',style: TextStyle(
                      fontSize: 35,
                      fontFamily: 'Ember'
                    ),),),
                  reviewsProvider.when(
                    data: (reviews) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: reviews?.length,
                        itemBuilder: (context, index) {
                          final review = reviews?[index];

                          return Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Customer: ${review?.CustomerName}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Ember',
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '${review?.ReviewStatement}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Ember',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(review?.ReviewStars ?? 0, (index) {
                                    return Icon(Icons.star);
                                  }),
                                ),
                              ),
                            ),
                          );
                        },
                      );


                    },
                    error: (error, stackTrace) {
                      return Text("Error occurred while fetching reviews");
                    },
                    loading: () {
                      return CircularProgressIndicator();
                    },
                  ),

                  SizedBox(height: 20,)
                ],
              );
            },
            error: (error, stackTrace) {
              return Text("Error occurred");
            },
            loading: () {
              return CircularProgressIndicator();
            },
          );
        },
        error: (error, stackTrace) {
          return Text('Error occurred while fetching customer');
        },
        loading: () {
          return CircularProgressIndicator();
        },
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
