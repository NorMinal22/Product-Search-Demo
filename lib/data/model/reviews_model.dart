/// Reference the json class of review json
// Model class for review
class ReviewsModel{
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;

  // Constructor
  ReviewsModel({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  // Link to json
  /// An easy reference path to call JSON and connect to the rest of the code
  factory ReviewsModel.fromJson(Map<String, dynamic> json){
    return ReviewsModel(
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      date: json['date'] ??'',
      reviewerName: json['reviewerName'] ?? '',
      reviewerEmail: json['reviewerEmail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'rating': rating,
    'comment': comment,
    'date': date,
    'reviewerName': reviewerName,
    'reviewerEmail': reviewerEmail,
  };
}