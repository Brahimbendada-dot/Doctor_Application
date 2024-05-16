class Chat {
  String id;
  String doctorId;
  String patientId;
  String message;
  String read;
  String dateSent;

  Chat({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.message,
    required this.dateSent,
    required this.read,
  });
  Chat.fromJson(Map json)
      : id = json['id'],
        doctorId = json['doctorId'],
        patientId = json['patientId'],
        message = json['message'],
        read = json['read'],
        dateSent = json['dateSent'];

  toJson() {
    return {
      "id ": id,
      "doctorId": doctorId,
      "patientId": patientId,
      "message": message,
      "read": read,
      "dateSent": dateSent
    };
  }
}
