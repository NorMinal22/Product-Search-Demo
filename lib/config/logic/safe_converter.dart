// Help convert to selected type
class SafeConverter {
  // Convert anything to int safely
  static int toInt(dynamic value){
    if(value == null) return 0;
    if(value is int) return value;
    if(value is double) return value.toInt();
    if(value is String){
      // If it is whole value
      final intValue = int.tryParse(value);
      if(intValue != null) return intValue;

      // If it is in decimal
      final doubleValue = double.tryParse(value);
      if(doubleValue != null) return doubleValue.round();

      return 0;
    }
    return 0;
  }

  // Convert anything to double safely
  static double toDouble(dynamic value) {
    if (value == null) return 0.0;

    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }

    return 0.0;
  }

  // Convert anything to string safely
  static String toStringValue(dynamic value){
    return value?.toString() ?? '';
  }

  // Convert coma-separate string to list of int
  // Example: "1,2,3" -> [1,2,3]
  static List<int> toIntList(String? value, {String separator = ','}){
    if (value == null || value.isEmpty) return [];
    return value.split(separator).map((entry) => toInt(entry.trim())).toList();
  }

  // Convert coma-separate string to list of String
  // Example: "apple,banana,orange" -> ["apple", "banana", "orange"]
  static List<String> toStringList(String? value, {String separator = ','}){
    if (value == null || value.isEmpty) return [];
    return value.split(separator).map((entry) => entry.trim()).toList();
  }
}