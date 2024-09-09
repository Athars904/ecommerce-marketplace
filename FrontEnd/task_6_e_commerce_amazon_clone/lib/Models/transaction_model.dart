import 'package:task_6_e_commerce_amazon_clone/Models/product_model.dart';

class Transaction{
  int? TransactionID;
  final String Amount;
  final String Details;
  final String Date;
  final int OrderID;
  final int? StoreID;
  double? total;

  Transaction({
    this.TransactionID,
    required this.Amount,
    required this.Details,
    required this.Date,
    required this.OrderID,
    required this.StoreID,
    this.total
});

  Map<String,dynamic> toJson(){
    return {
      'amount':Amount,
      'details':Details,
      'date':Date,
      'orderID':OrderID,
      'storeID':StoreID
    };
  }

  factory Transaction.fromJson(Map<String,dynamic> json){
    return Transaction(
        TransactionID: json['TransactionID'],
        Amount: json['Amount'],
        Details: json['Details'],
        Date: json['FormattedDate'],
        OrderID: json['OrderID'],
        StoreID: json['StoreID'],
        total: (json['TotalAmount'] != null) ? double.tryParse(json['TotalAmount'].toString()) : null,
    );
  }
}