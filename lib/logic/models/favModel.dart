class FavoriteModel {
  final int id;
  final String name;
  final String thumbnail;
  final double price;
  final bool isFavorite;

  FavoriteModel({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.price,
    required this.isFavorite,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'],
      name: json['name'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      price: (json['final_unit_price'] ?? 0).toDouble(),
      isFavorite: json['is_favorite'] ?? false,
    );
  }
}