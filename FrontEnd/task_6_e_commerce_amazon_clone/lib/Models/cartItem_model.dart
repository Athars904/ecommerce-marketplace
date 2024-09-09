class CartItem {
    int? CartItemID ;
    final int CustomerID;
    final int ProductID;
    final int Quantity;

    CartItem({
      this.CartItemID,
      required this.CustomerID,
      required this.ProductID,
      required this.Quantity
});

    Map<String,dynamic> toJson(){
      return {
        'customerID' : CustomerID,
        'productID' : ProductID,
        'quantity' : Quantity
      };
    }



}