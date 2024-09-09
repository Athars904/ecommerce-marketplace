class Store{
  int? SellerID;
  final int StoreID;
  final String StoreName;

  Store({
    this.SellerID,
    required this.StoreID,
    required this.StoreName

});

  factory Store.fromJson(Map<String,dynamic> json) {
    return Store(
        StoreID: json['StoreID'],
        StoreName: json['StoreName']);
  }

  Map<String,dynamic> toJson() {
    return {
      'StoreID' : StoreID,
      'StoreName':StoreName
    };
  }


}