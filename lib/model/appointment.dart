class AppointmentModel {
  String doctorId;
  String patientId;
  DateTime dateTime;
  bool validation;

  AppointmentModel({
    required this.doctorId,
    required this.patientId,
    required this.dateTime,
    required this.validation
  });

  AppointmentModel.fromJson(Map? json)
      : doctorId = json!['doctorId'],
        patientId = json['patientId'],
        dateTime = json['dateTime'].toDate(),
        validation = json['validation'];

  toJson() {
    return {
      'doctorId': doctorId,
      'patientId': patientId,
      'dateTime': dateTime,
      'validation':validation,
    };
  }
}
