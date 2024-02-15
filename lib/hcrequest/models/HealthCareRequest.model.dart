class HealthCareRequestlModel {
  late String? painList;
  final String? intensity;
  final String? contact;
  final String? message;
  final DateTime? date;

  HealthCareRequestlModel({
    this.painList,
    this.intensity,
    this.contact,
    this.message,
    this.date,
  });

  Map<String, dynamic> toJson() => {
        'painList': painList,
        'intensity': intensity,
        'contact': contact,
        'message': message,
        'date': date?.toIso8601String(),
      };

  factory HealthCareRequestlModel.fromJson(Map<String, dynamic> json) {
    return HealthCareRequestlModel(
      painList: json['painList'],
      intensity: json['intensity'],
      contact: json['contact'],
      message: json['message'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
    );
  }
}
