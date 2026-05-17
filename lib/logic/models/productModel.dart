class ProductResponse {
  final bool status;
  final CategoryModel category;
  final List<ProductModel> data;
  final PaginationModel pagination;

  ProductResponse({
    required this.status,
    required this.category,
    required this.data,
    required this.pagination,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      status: json['status'] ?? false,
      category: CategoryModel.fromJson(json['category'] ?? {}),
      data: List<ProductModel>.from(
        (json['data'] as List).map((e) => ProductModel.fromJson(e)),
      ),
      pagination: PaginationModel.fromJson(json['pagination'] ?? {}),
    );
  }
}

class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final String image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      image: json['image'] ?? '',
    );
  }
}


class ProductModel {
  final int id;
  final String code;
  final String name;
  final String slug;
  final String shortDescription;
  final String details;
  final String shop;

  final BrandModel brand;

  final String unit;
  final int minQty;

  final double purchasePrice;
  final double discount;
  final String discountType;
  final double discountPercent;

  final double finalUnitPrice;
  final double rating;

  final bool isFavorite;

  final String thumbnail;
  final List<String> images;

  final CategoryModel mainCategory;

  final int currentStock;
  final int totalStock;
  final String availability;

  final List<UnitPriceModel> unitPrices;
  final List<UnitPriceModel> gulfPrices;

  final List<String> colors;
  final List<String> sizes;

  ProductModel({
    required this.id,
    required this.code,
    required this.name,
    required this.slug,
    required this.shortDescription,
    required this.details,
    required this.shop,
    required this.brand,
    required this.unit,
    required this.minQty,
    required this.purchasePrice,
    required this.discount,
    required this.discountType,
    required this.discountPercent,
    required this.finalUnitPrice,
    required this.rating,
    required this.isFavorite,
    required this.thumbnail,
    required this.images,
    required this.mainCategory,
    required this.currentStock,
    required this.totalStock,
    required this.availability,
    required this.unitPrices,
    required this.gulfPrices,
    required this.colors,
    required this.sizes,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      shortDescription: json['short_description'] ?? '',
      details: json['details'] ?? '',
      shop: json['shop'] ?? '',
      brand: BrandModel.fromJson(json['brand'] ?? {}),
      unit: json['unit'] ?? '',
      minQty: json['min_qty'] ?? 0,
      purchasePrice: (json['purchase_price'] ?? 0).toDouble(),
      discount: (json['discount'] ?? 0).toDouble(),
      discountType: json['discount_type'] ?? '',
      discountPercent: (json['discount_percent'] ?? 0).toDouble(),
      finalUnitPrice: (json['final_unit_price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      isFavorite: json['is_favorite'] ?? false,
      thumbnail: json['thumbnail'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      mainCategory: CategoryModel.fromJson(json['main_category'] ?? {}),
      currentStock: json['current_stock'] ?? 0,
      totalStock: json['total_stock'] ?? 0,
      availability: json['availability_instock'] ?? '',
      unitPrices: (json['unit_price'] as List? ?? [])
          .map((e) => UnitPriceModel.fromJson(e))
          .toList(),
      gulfPrices: (json['gulf_prices'] as List? ?? [])
          .map((e) => UnitPriceModel.fromJson(e))
          .toList(),
      colors: List<String>.from(json['colors'] ?? []),
      sizes: List<String>.from(json['sizes'] ?? []),
    );
  }
}

class BrandModel {
  final int id;
  final String name;

  BrandModel({
    required this.id,
    required this.name,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class UnitPriceModel {
  final String countryName;
  final String currencyCode;
  final double price;
  final String formattedPrice;

  UnitPriceModel({
    required this.countryName,
    required this.currencyCode,
    required this.price,
    required this.formattedPrice,
  });

  factory UnitPriceModel.fromJson(Map<String, dynamic> json) {
    return UnitPriceModel(
      countryName: json['country_name'] ?? '',
      currencyCode: json['currency_code'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      formattedPrice: json['formatted_price'] ?? '',
    );
  }
}


class PaginationModel {
  final int total;
  final int perPage;
  final int currentPage;
  final int lastPage;

  PaginationModel({
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      total: json['total'] ?? 0,
      perPage: json['per_page'] ?? 0,
      currentPage: json['current_page'] ?? 0,
      lastPage: json['last_page'] ?? 0,
    );
  }
}