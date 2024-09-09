import 'package:riverpod/riverpod.dart';
import 'package:task_6_e_commerce_amazon_clone/Controllers/cart_controller.dart';
import 'package:task_6_e_commerce_amazon_clone/Controllers/customer_controller.dart';
import 'package:task_6_e_commerce_amazon_clone/Controllers/order_controller.dart';
import 'package:task_6_e_commerce_amazon_clone/Controllers/product_controller.dart';
import 'package:task_6_e_commerce_amazon_clone/Controllers/review_controller.dart';
import 'package:task_6_e_commerce_amazon_clone/Controllers/seller_controller.dart';
import 'package:task_6_e_commerce_amazon_clone/Controllers/transaction_controller.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/bar_model.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/customer_model.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/product_model.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/seller_model.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/store_controller.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/store_model.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/transaction_model.dart';
import 'package:tuple/tuple.dart';
import 'package:task_6_e_commerce_amazon_clone/Models/review_model.dart';

import 'package:task_6_e_commerce_amazon_clone/Models/order_model.dart';


final SellerControllerProvider = Provider<SellerController>(
    (ref)=>SellerController(),
);

final SellerSignupProvider = FutureProvider.family<bool, Seller>((ref, seller) async {
  final sellerAPI = ref.read(SellerControllerProvider);
  final result = await sellerAPI.SignUpSeller(seller);
  //print('SignUpSeller result: $result');
  return result;
});

final SellerLoginProvider = FutureProvider.family<bool,Tuple2<String,String>>((ref,tuple)async{
  final sellerAPI = ref.read(SellerControllerProvider);
  final email = tuple.item1;
  final pass = tuple.item2;
  final result = await sellerAPI.LoginSeller(email, pass);
  return result;
});

final sellerEmail = StateProvider<String?>((ref)=>null);

final sellerDetailsProvider = FutureProvider<Seller?>((ref) async{
  //print("inside seller Details provider");
  final email = ref.watch(sellerEmail.state).state;
  if(email==null || email.isEmpty){
    print("email was null : (");
    return null;
  }
//  print("email was not null");
  final sellerAPI = ref.read(SellerControllerProvider);
  final result = await sellerAPI.GetSeller(email);
  print(result);
  return result;

});

final TransactionControllerProvider = Provider<TransactionController>((ref)=>TransactionController());

final getAllTransactionsProvider = FutureProvider.family<List<Transaction>?,int>((ref,storeID)async{
  final transactionAPI = ref.read(TransactionControllerProvider);
  final result = await transactionAPI.getAllTransactions(storeID);
  return result;
});




final productControllerProvider = Provider<ProductController>(
(ref)=>ProductController()
);


final getProductsProvider = FutureProvider.family<List<Product>?,int?>(
    (ref,storeID)async{

      final productAPI = ref.read(productControllerProvider);
      final result = await productAPI.getProducts(storeID);
      return result;


    }


);

final getAllProductsProvider = FutureProvider<List<Product>?>(
    (ref) async{
      final productAPI = ref.read(productControllerProvider);
      final result = await productAPI.getAllProducts();
      return result;
    }
);

final productProvider = StateProvider<Product?>(
(ref)=>null,
);

final categoryProvider = StateProvider<int?>((ref)=>null);

final categoryResultsProvider = FutureProvider<List<Product>?>((ref)async{
  int? categoryID = ref.watch(categoryProvider);
  final productAPI =ref.read(productControllerProvider);
  final result = productAPI.getProductsByCategory(categoryID!);
  return result;

});

final searchProvider = StateProvider<String?>((ref)=>null);

final searchResultsProvider = FutureProvider<List<Product>?>((ref)async {
  final searchWord = ref.watch(searchProvider);
  final productAPI = ref.read(productControllerProvider);
  final result = productAPI.getSearchResults(searchWord!);
  return result;

});

final reviewControllerProvider = Provider<ReviewController>((ref)=>ReviewController());

final getAllReviewsProvider = FutureProvider.family<List<Review>?,int>((ref,storeID)async{
  final reviewAPI = ref.read(reviewControllerProvider);
  final result = await reviewAPI.getAllReviews(storeID);
  return result;
});

final getProductReviewsProvider = FutureProvider.family<List<Review>?,int>((ref,customerID)async{
  final reviewAPI = ref.read(reviewControllerProvider);
  final result = await reviewAPI.getProductReviews(customerID);
  return result;
});



final ReviewProvider = StateProvider<Review?>((ref)=>null);


final OrderControllerProvider = Provider<OrderController>((ref)=>OrderController());

final getAllOrdersProvider  = FutureProvider.family<List<Order>?,int>((ref,storeID)async{

  final orderAPI = ref.read(OrderControllerProvider);
//  print("inside orders provider 2");
  final result = await orderAPI.getAllOrders(storeID);
  //print("called the getAllOrders");
  return result;
});


final getAllUnits = FutureProvider.family<int,int>((ref,StoreID)async{
  final orderAPI = ref.read(OrderControllerProvider);
  final result = await orderAPI.getTotalUnits(StoreID);
  return result;

});


final getTodaysUnits = FutureProvider.family<int,int>((ref,StoreID)async{
  print('inside provider 1');
  final orderAPI = ref.read(OrderControllerProvider);
  final result = await orderAPI.getTodaysUnits(StoreID);
  print('inside provider 2');
  print(result);
  return result;

});

final get6Units = FutureProvider.family<BarModel?,int>((ref,StoreID)async{
  final orderAPI = ref.read(OrderControllerProvider);
  final result = await orderAPI.get6Units(StoreID);
  return result;

});


final get6Amounts = FutureProvider.family<BarModel?,int>((ref,StoreID)async{
  final transactionAPI = ref.read(TransactionControllerProvider);
  final result = await transactionAPI.get6Units(StoreID);
  return result;

});

final optionProvider = StateProvider<int>((ref)=>1);



final getTotalAmount = FutureProvider.family<int,int>((ref,StoreID)async{
  final transactionAPI = ref.read(TransactionControllerProvider);
  final result = await transactionAPI.getTotalAmount(StoreID);
  return result;

});


final getTodaysAmount = FutureProvider.family<int,int>((ref,StoreID)async{
  final transactionAPI = ref.read(TransactionControllerProvider);
  final result = await transactionAPI.getTodaysAmount(StoreID);
  return result;

});




final OrderProvider = StateProvider<Order?>((ref)=>null);

final OrderDetailsProvider = FutureProvider.family<List<Product>?,int>((ref,OrderID)async{
  final orderAPI = ref.read(OrderControllerProvider);
  final result = await orderAPI.getOrderDetails(OrderID);
  return result;
});


final getCustomerOrdersProvider  = FutureProvider.family<List<Order>?,int>((ref,customerID)async{

  final orderAPI = ref.read(OrderControllerProvider);
//  print("inside orders provider 2");
  final result = await orderAPI.getCustomerOrders(customerID);
  //print("called the getAllOrders");
  return result;
});

final StoreControllerProvider = Provider<StoreController>((ref)=>StoreController());

final getStoreProvider = FutureProvider.family<Store?,int>((ref,StoreID) async{
  final StoreAPI = ref.read(StoreControllerProvider);

  final result = await StoreAPI.getStore(StoreID);
  return result;

});

final customerEmailProvider = StateProvider<String?>((ref)=>null);

final customerDetailsProvider = FutureProvider<Customer?>((ref) async {
  final customerAPI = CustomerController();
  final Email = ref.read(customerEmailProvider);

  final result =  await customerAPI.fetchCustomerDetails(Email!);
  return result;

});


final cartControllerProvider = Provider<CartController>((ref)=>CartController());

final getCartItemsProvider= FutureProvider.family<List<Product>?,int>((ref,CustomerID)async {

final cartAPI = ref.read(cartControllerProvider);
final result = await cartAPI.getCartItems(CustomerID);
return result;

});

final getSubTotal = FutureProvider.family<double,int>((ref,CustomerID) async{
  final cartAPI = ref.read(cartControllerProvider);
  final result = await cartAPI.getSubTotal(CustomerID);
  return result;

});
