import '../../config/config_export.dart';

/// Reference the json class of dimension json
// Model class for dimension
class DimensionsModel{
  final double width;
  final double height;
  final double depth;

  // Constructor
  DimensionsModel({
    required this.width,
    required this.height,
    required this.depth,
  });

  // Link to json
  /// An easy reference path to call JSON and connect to the rest of the code
  factory DimensionsModel.fromJson(Map<String, dynamic> json){
    return DimensionsModel(
      width: SafeConverter.toDouble(json['width']),
      height: SafeConverter.toDouble(json['height']),
      depth: SafeConverter.toDouble(json['depth']),
    );
  }

  Map<String, dynamic> toJson() => {
    'width': width,
    'height': height,
    'depth': depth,
  };
}