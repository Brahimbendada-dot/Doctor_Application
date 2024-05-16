class Specialty {
  String name;
  String image;

  Specialty(this.name, this.image);

  Specialty.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        image = json["image"];

  toJson() {
    return {'name': name};
  }
}
