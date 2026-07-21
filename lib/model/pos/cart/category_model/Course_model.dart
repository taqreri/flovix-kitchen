class CourseModel {
  final int id;
  final int timeInMinutes;

  CourseModel({
    required this.id,
    required this.timeInMinutes,
  });

  Map<String, dynamic> toJson() {

    return {
      'id': id,
      'timeInMinutes': timeInMinutes,
    };
  }

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? 0,
      timeInMinutes: json['timeInMinutes'] ?? 0,
    );
  }
}

