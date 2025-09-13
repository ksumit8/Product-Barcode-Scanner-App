class Product {
  final int id;
  final String name;
  final double price;
  final String image; // main image
  final String thumbnail; // thumbnail image

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.thumbnail,
  });

  // Convert JSON map to Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['title'] ?? '',
      price: (json['price'] as num).toDouble(),
      image: (json['images'] as List).isNotEmpty ? json['images'][0] : '',
      thumbnail: json['thumbnail'] ?? '',
    );
  }

  // Convert Product to JSON map for saving in SharedPreferences
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
      'price': price,
      'image': image,
      'thumbnail': thumbnail,
    };
  }
}
