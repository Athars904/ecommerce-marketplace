class Review{
  final String? CustomerName;
  final int? ReviewID;
  final String ReviewStatement;
  final int ReviewStars;
  final int ProductID;
  final int CustomerID;
  final String? ProductName;
  final int? StoreID;
  final String? FormattedDate;

  Review({
     this.CustomerName,
     this.ReviewID,
    required this.ReviewStatement,
    required this.ReviewStars,
    required this.ProductID,
    required this.CustomerID,
     this.ProductName,
     this.StoreID,
     this.FormattedDate,

});

  factory Review.fromJson(Map<String,dynamic> json){
    return Review(
        CustomerName: json['CustomerName'],
        ReviewID: json['ReviewID'],
        ReviewStatement: json['ReviewStatement'],
        ReviewStars: json['ReviewStars'],
        ProductID: json['ProductID'],
        CustomerID: json['CustomerID'],
        ProductName: json['ProductName'],
        StoreID: json['StoreID'],
        FormattedDate: json['FormattedDate']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'stmt':ReviewStatement,
      'stars':ReviewStars,
      'customerID':CustomerID,
      'productID':ProductID
    };
  }


}