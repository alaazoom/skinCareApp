class ProductDetailsModel {
  final int id;
  final String name;
  final String slug;
  final String shortDescription;
  final String details;
  final String thumbnail;
  final List<String> images;
  final double price;
  final List<String> tags;

  ProductDetailsModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.shortDescription,
    required this.details,
    required this.thumbnail,
    required this.images,
    required this.price,
    required this.tags,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    final product = json['product'];

    return ProductDetailsModel(
      id: product['id'],
      name: product['name'] ?? '',
      slug: product['slug'] ?? '',
      shortDescription: product['short_description'] ?? '',
      details: product['details'] ?? '',
      thumbnail: product['thumbnail'] ?? '',
      images: List<String>.from(product['images'] ?? []),
      price: (product['final_unit_price'] ?? 0).toDouble(),

      tags: _generateTags(
        product['name'] ?? '',
        product['short_description'] ?? '',
      ),
    );
  }

  static List<String> _generateTags(String name, String desc) {
    final words = [...name.split(" "), ...desc.split(" ")];
    return words
        .where((w) => w.length > 4)
        .take(6)
        .toSet()
        .toList();
  }
}