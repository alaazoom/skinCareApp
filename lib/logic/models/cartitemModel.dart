class CartItem {
  final int id;
  final int productId;
  final String name;
  final String image;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: int.tryParse(json['id'].toString()) ?? 0,
      productId: int.tryParse(json['product_id'].toString()) ?? 0,

      name: json['product']?['name']?.toString() ?? '',
      image: json['product']?['thumbnail']?.toString() ?? '',

      price: double.tryParse(json['price'].toString()) ?? 0.0,
      quantity: int.tryParse(json['quantity'].toString()) ?? 0,
    );
  }
}
class CartResponse {
  final List<CartItem> items;
  final CartDetails details;

  CartResponse({
    required this.items,
    required this.details,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      items: (json['cart'] as List)
          .map((e) => CartItem.fromJson(e))
          .toList(),
      details: CartDetails.fromJson(json['cart_details']),
    );
  }
}
class CartDetails {
  final double subTotal;
  final double totalCost;
  final double deliveryFee;

  CartDetails({
    required this.subTotal,
    required this.totalCost,
    required this.deliveryFee,
  });

  factory CartDetails.fromJson(Map<String, dynamic> json) {
    return CartDetails(
      subTotal: (json['sub_total'] as num).toDouble(),
      totalCost: (json['total_cost'] as num).toDouble(),
      deliveryFee: (json['delivery_fee'] as num).toDouble(),
    );
  }
}