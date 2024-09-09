import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/Controllers/cart_controller.dart';
import 'package:task_6_e_commerce_amazon_clone/app_bar.dart';
import 'package:task_6_e_commerce_amazon_clone/bottom_nav.dart';
import 'package:task_6_e_commerce_amazon_clone/place_order.dart';
import 'package:task_6_e_commerce_amazon_clone/product_details.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';

class CustomerCart extends ConsumerStatefulWidget {
  @override
  ConsumerState<CustomerCart> createState() => CustomerCartState();
}

class CustomerCartState extends ConsumerState<CustomerCart> {
  @override
  Widget build(BuildContext context) {
    final customerId = ref.watch(customerDetailsProvider).maybeWhen(
      data: (customer) => customer?.CustomerID,
      orElse: () => null,
    );

    if (customerId == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading...'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final cartProvider = ref.watch(getCartItemsProvider(customerId));

    return Scaffold(
      appBar: CustomAppBar(),
      body: cartProvider.when(
        data: (products) {
          
          final length = products?.length;
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    
                    length != 0 && length !=null? Expanded(
                      child: SizedBox(
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PlaceOrder()),
                            );
                            ref.refresh(getSubTotal(customerId));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0XFFFF9900),
                          ),
                          child: Text(
                            'Proceed to Checkout',
                            style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Ember',
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ) :
                        Expanded(child:
                        Text('It looks like you have nothing in the cart yet!',style: TextStyle(fontSize: 30,fontFamily: 'Ember')),)
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: products?.length,
                  itemBuilder: (context, index) {
                    final product = products?[index];
                    final imageUrl = product?.image != null
                        ? 'http://10.0.2.2:3000/uploads/${product?.image}'
                        : null;

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
                        padding: EdgeInsets.only(left: 30),
                        child: ListTile(
                          onTap: () {
                            ref.read(productProvider.notifier).state = product;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetails(),
                              ),
                            );
                          },
                          leading: imageUrl != null
                              ? Container(
                            height: 80,
                            width: 80,
                            child: Image.network(imageUrl),
                          )
                              : Container(
                            height: 80,
                            width: 80,
                            child: Text('No image'),
                          ),
                          title: Text(
                            '${product?.Name}',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Ember',
                            ),
                          ),
                          subtitle: Text(
                            '${product?.Price} Pkr/- Quantity: ${product?.Quantity}',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Ember',
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () => deleteCartItem(product?.ProductID, customerId),
                            child: Icon(Icons.remove),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          return Text('Error: ${error.toString()}');
        },
        loading: () {
          return CircularProgressIndicator();
        },
      ),
      bottomNavigationBar: BottomNav(),
    );
  }

  Future<void> deleteCartItem(int? productID, int? customerId) async {
    if (productID == null || customerId == null) return;

    final controller = CartController();

    bool result = await controller.deleteCartItem(productID);
    if (result) {
      ref.refresh(getCartItemsProvider(customerId));
      ref.refresh(getSubTotal(customerId));
    }
  }
}
