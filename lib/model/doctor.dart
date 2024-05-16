class Doctor {
  String id;
  String firstName;
  String lastName;
  String photo;
  DateTime dateCreatAccount;
  String email;
  String about;
  String phone;
  String address;
  String specialty;
  String token;

  Doctor(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.photo,
      required this.email,
      required this.about,
      required this.dateCreatAccount,
      required this.address,
      required this.specialty,
      required this.phone,
      required this.token});
  Doctor.fromJson(Map? json)
      : firstName = json!["firstName"],
        lastName = json["lastName"],
        photo = json["photo"],
        id = json["id"],
        email = json["email"],
        about = json['about'],
        specialty = json["specialty"],
        dateCreatAccount = json["dateCreatAccount"].toDate(),
        address = json["address"],
        phone = json["phone"],
        token = json["token"];
  toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "id": id,
      "email": email,
      "about": about,
      "address": address,
      "specialty": specialty,
      "dateCreatAccount": dateCreatAccount,
      "phone": phone,
      "photo": photo,
      "token": token,
    };
  }
}
