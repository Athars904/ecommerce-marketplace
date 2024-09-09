import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/Controllers/order_controller.dart';
import 'package:task_6_e_commerce_amazon_clone/Controllers/transaction_controller.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/transaction_model.dart';
import 'package:task_6_e_commerce_amazon_clone/nav_bar.dart';
import 'package:task_6_e_commerce_amazon_clone/order_details.dart';
import 'package:task_6_e_commerce_amazon_clone/providers.dart';
import 'package:intl/intl.dart';

class ManageOrders extends ConsumerStatefulWidget {
  @override
  ConsumerState<ManageOrders> createState() => ManageOrdersState();
}

class ManageOrdersState extends ConsumerState<ManageOrders> {
  String? statusSelected;
  List<String> statusOptions = [
    'Accepted',
    'Processed',
    'Delivered',
    'Done',
    'Pending'
  ];

  @override
  Widget build(BuildContext context) {
    var seller = ref.watch(sellerDetailsProvider);
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: 40),
        title: Image.asset('images/PngItem_12080.png', height: 38),
        centerTitle: true,
        backgroundColor: Color(0XFF232F3E),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.camera_alt,
                size: 40,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: seller.when(
        data: (seller) {
          int? storeID = seller?.StoreID;
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Manage Your Orders',
                      style: TextStyle(
                        fontFamily: 'Ember',
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 20,
              ),
              ref.watch(getAllOrdersProvider(storeID!)).when(
                data: (orders) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: orders?.length,
                      itemBuilder: (context, index) {
                        final order = orders?[index];
                        List<String> orderStatusOptions = (order?.status ==
                            'Done')
                            ? ['Done']
                            : statusOptions;

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
                                ref
                                    .read(OrderProvider.state)
                                    .state = order;
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => OrderDetails()));
                              },
                              title: Text(
                                'Order ${order?.OrderID}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Ember',
                                ),
                              ),
                              subtitle: Text(
                                'Total: ${order?.TotalSum}Pkr',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Ember',
                                ),
                              ),
                              trailing: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5, right: 2),
                                  child: DropdownButton<String>(
                                    value: order?.status,
                                    hint: Text('Status'),
                                    items: orderStatusOptions.map((
                                        String item) {
                                      return DropdownMenuItem(
                                        child: Text(item),
                                        value: item,
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) async {
                                      final controller = OrderController();
                                      if (newValue == 'Rejected') {
                                        bool result = await controller
                                            .deleteOrder(order!.OrderID);
                                        if (result == true) {
                                          ref.refresh(getAllOrdersProvider(
                                              storeID));
                                        }
                                      } else {
                                        controller.setOrderStatus(
                                            order!.OrderID, newValue!);
                                        if (newValue == 'Done' &&
                                            order?.status != 'Done') {
                                          DateTime time = DateTime.now();
                                          controller.setDateDelivered(order!
                                              .OrderID, time);
                                          Transaction transaction = Transaction(
                                            Amount: order!.TotalSum,
                                            Details: 'Incoming',
                                            Date: time.toString(),
                                            OrderID: order!.OrderID,
                                            StoreID: seller!.StoreID,
                                          );
                                          final transactionController = TransactionController();
                                          transactionController
                                              .createTransaction(transaction);
                                          ref.refresh(
                                              getAllTransactionsProvider(
                                                  storeID));
                                        };

                                        ref.refresh(get6Units(storeID));
                                        ref.refresh(get6Amounts(storeID));
                                        ref.refresh(getTodaysUnits(storeID));
                                        ref.refresh(getTotalAmount(storeID));
                                        ref.refresh(getTodaysAmount(storeID));
                                        ref.refresh(getAllUnits(storeID));



                                      }
                                      setState(() {
                                        order?.status = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                error: (error, stackTree) {
                  return Text('Error occured while fetching orders');
                },
                loading: () {
                  return CircularProgressIndicator();
                },
              ),
            ],
          );
        },
        error: (error, stackTree) {
          return Text('error occured');
        },
        loading: () {
          return CircularProgressIndicator();
        },
      ),
    );
  }
}