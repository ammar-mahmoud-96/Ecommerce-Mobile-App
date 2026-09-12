class ProductItemModel {
  const ProductItemModel({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 0,
    this.image,
    this.description,
    this.rating,
    this.reviewCount,
    this.category,
    this.colors = const [],
    this.sizes = const [],
    this.dressStyle,
    this.isNew = false,
    this.isBestSeller = false,
    this.isOnSale = false,
  });

  final int id;
  final String name;
  final double price;
  final String? image;
  final int quantity;
  final String? description;
  final double? rating;
  final int? reviewCount;
  final String? category;
  final List<String> colors;
  final List<String> sizes;
  final String? dressStyle;
  final bool isNew;
  final bool isBestSeller;
  final bool isOnSale;

  @override
  String toString() {
    return 'ProductItemModel(id: $id, name: $name, price: $price, quantity: $quantity, image: $image)';
  }
}
