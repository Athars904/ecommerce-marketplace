class Order {
  final int OrderID;
  String status;
  final String FormattedDate;
  final String CustomerName;
  final String CustomerAddress;
  final String TotalSum;

  Order({
    required this.OrderID,
    required this.status,
    required this.FormattedDate,
    required this.CustomerName,
    required this.CustomerAddress,
    required this.TotalSum
});


  factory Order.fromJson(Map<String,dynamic> json){
    return Order(
        OrderID: json['OrderID'],
        status: json['status'],
        FormattedDate: json['FormattedDate'],
        CustomerName: json['CustomerName'],
        CustomerAddress: json['CustomerAddress'],
        TotalSum: json['TotalSum']);
  }


}