import 'image_item_model.dart';

class FeedbackFormData {
  String? state;
  String? district;
  String? block;
  String? roadName;
  String? staticRoadName;
  String? categoryOfComplaint;
  String? feedback;

  FeedbackFormData({
    this.state,
    this.district,
    this.block,
    this.roadName,
    this.staticRoadName,
    this.categoryOfComplaint,
    this.feedback,
  });

  // Convert a FeedbackFormData into a Map (for saving to DB)
  Map<String, dynamic> toMap() {
    return {
      'state': state,
      'district': district,
      'block': block,
      'roadName': roadName,
      'staticRoadName': staticRoadName,
      'categoryOfComplaint': categoryOfComplaint,
      'feedback': feedback,
    };
  }

  // Create a FeedbackFormData from a Map (when reading from DB)
  factory FeedbackFormData.fromMap(Map<String, dynamic> map) {
    return FeedbackFormData(
      state: map['state'],
      district: map['district'],
      block: map['block'],
      roadName: map['roadName'],
      staticRoadName: map['staticRoadName'],
      categoryOfComplaint: map['categoryOfComplaint'],
      feedback: map['feedback'],
    );
  }
}
