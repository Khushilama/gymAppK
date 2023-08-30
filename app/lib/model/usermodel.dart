class userModel {
  String? id;
  String? name;
  String? phone;
  String? roll;
  String? email;

  userModel({
    this.id,
    this.roll,
    this.name,
    this.phone,
    this.email,
  });

  factory userModel.fromMap(Map<String, dynamic> json) => userModel(
        id: json["id"],
        roll: json["roll"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "roll": roll,
        "name": name,
        "phone": phone,
        "email": email,
      };
}
