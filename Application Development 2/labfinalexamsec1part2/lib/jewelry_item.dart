class JewelryItem {
  final int id;
  final String title;
  final double price;
  final String description;
  final String imageUrl;
  final double ratingRate;
  final int ratingCount;

  JewelryItem({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.ratingRate,
    required this.ratingCount,
  });

  factory JewelryItem.fromJson(Map<String, dynamic> json) {
    return JewelryItem(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      imageUrl: json['image'],
      ratingRate: json['rating']['rate'].toDouble(),
      ratingCount: json['rating']['count'].toInt(),
    );
  }
}
