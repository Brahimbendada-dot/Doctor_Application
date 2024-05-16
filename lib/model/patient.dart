class Patient {
  String id;
  String firstName;
  String lastName;
  String photo;
  DateTime dateCreatAccount;
  String email;
  String phone;
  String address;
  String token;
  Patient(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.photo,
      required this.dateCreatAccount,
      required this.email,
      required this.address,
      required this.phone,
      required this.token});
  Patient.fromJson(Map? json)
      : firstName = json!["firstName"],
        lastName = json["lastName"],
        photo = json["photo"],
        id = json["id"],
        dateCreatAccount = json["dateCreatAccount"].toDate(),
        email = json["email"],
        address = json["address"],
        phone = json["phone"],
        token = json["token"];
  toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "id": id,
      "email": email,
      "address": address,
      "dateCreatAccount": dateCreatAccount,
      "phone": phone,
      "photo": photo,
      "token": token,
    };
  }
}
