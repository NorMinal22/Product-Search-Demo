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
      width: json['width'] ?? 0.0,
      height: json['height'] ?? 0.0,
      depth: json['depth'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'width': width,
    'height': height,
    'depth': depth,
  };
}