class Message {
  String fromId;
  String toId;
  String message;
  String sent;
  String read;
  Type type;

  Message({
    required this.fromId,
    required this.toId,
    required this.message,
    required this.sent,
    required this.read,
    required this.type,
  });

  Message.fromJson(Map? json)
      : fromId = json!['fromId'].toString(),
        toId = json['toId'].toString(),
        message = json['message'].toString(),
        sent = json['sent'].toString(),
        read = json['read'].toString(),
        type =
            json['type'].toString() == Type.image.name ? Type.image : Type.text;

  toJson() {
    return {
      'fromId': fromId,
      'toId': toId,
      'message': message,
      'sent': sent,
      'read': read,
      'type': type.name,
    };
  }
}

enum Type { text, image }
