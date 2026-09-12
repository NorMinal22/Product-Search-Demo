import '../../config/config_export.dart';

/// Reference the json class of meta json
// Model class for meta
class MetaModel{
  final String createdAt;
  final String updatedAt;
  final String barcode;
  final String qrCode;

  // Constructor
  MetaModel({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  // Link to json
  /// An easy reference path to call JSON and connect to the rest of the code
  factory MetaModel.fromJson(Map<String, dynamic> json){
    return MetaModel(
      createdAt: SafeConverter.toStringValue(json['createdAt']),
      updatedAt: SafeConverter.toStringValue(json['updatedAt']),
      barcode: SafeConverter.toStringValue(json['barcode']),
      qrCode: SafeConverter.toStringValue(json['qrCode']),
    );
  }

  Map<String, dynamic> toJson() => {
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'barcode': barcode,
    'qrCode': qrCode,
  };
}