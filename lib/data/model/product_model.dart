import '../../config/config_export.dart';
import 'model_export.dart';

// Model class for product (obtain from product api json format)
class ProductDemoModel{
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final double weight;
  final DimensionsModel dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<ReviewsModel> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final MetaModel meta;
  final List<String> images;
  final String thumbnail;

  // Constructor
  ProductDemoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  // Link to json
  /// An easy reference path to call JSON and connect to the rest of the code
  factory ProductDemoModel.fromJson(Map<String, dynamic> json){
    return ProductDemoModel(
      id: SafeConverter.toInt(json['id']),
      title: SafeConverter.toStringValue(json['title']),
      description: SafeConverter.toStringValue(json['description']),
      category: SafeConverter.toStringValue(json['category']),
      price: SafeConverter.toDouble(json['price']),
      discountPercentage: SafeConverter.toDouble(json['discountPercentage']),
      rating: SafeConverter.toDouble(json['rating']),
      stock: SafeConverter.toInt(json['stock']),
      brand: SafeConverter.toStringValue(json['brand']),
      sku: SafeConverter.toStringValue(json['sku']),
      weight: SafeConverter.toDouble(json['weight']),
      warrantyInformation: SafeConverter.toStringValue(json['warrantyInformation']),
      shippingInformation: SafeConverter.toStringValue(json['shippingInformation']),
      availabilityStatus: SafeConverter.toStringValue(json['availabilityStatus']),
      returnPolicy: SafeConverter.toStringValue(json['returnPolicy']),
      minimumOrderQuantity: SafeConverter.toInt(json['minimumOrderQuantity']),
      thumbnail: SafeConverter.toStringValue(json['thumbnail']),

      tags: List<String>.from(json['tags']),
      dimensions: DimensionsModel.fromJson(json['dimensions']),
      reviews: (json['reviews'] as List)
          .map((review) => ReviewsModel.fromJson(review)).toList(),
      meta: MetaModel.fromJson(json['meta']),
      images: List<String>.from(json['images']),
    );
  }

  // Map so it can safely call
  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'brand': brand,
      'sku': sku,
      'weight': weight,
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'thumbnail': thumbnail,
      'images': images,

      'tags': tags,
      'dimensions': dimensions.toJson(),
      'reviews': reviews.map((e) => e.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }
}