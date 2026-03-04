class VitalRecord {
  final int? id;
  final String subjectId;
  final int heartRate;
  final String bloodPressure;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool highHeartRateAlert;

  VitalRecord({
    this.id,
    required this.subjectId,
    required this.heartRate,
    required this.bloodPressure,
    this.createdAt,
    this.updatedAt,
    this.highHeartRateAlert = false,
  });

  factory VitalRecord.fromJson(Map<String, dynamic> json) {
    return VitalRecord(
      id: json['id'],
      subjectId: json['subjectId'],
      heartRate: json['heartRate'],
      bloodPressure: json['bloodPressure'],
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : null,
      highHeartRateAlert: json['highHeartRateAlert'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjectId': subjectId,
      'heartRate': heartRate,
      'bloodPressure': bloodPressure,
    };
  }
}
