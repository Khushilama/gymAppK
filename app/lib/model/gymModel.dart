class GymModel {
  String? id;
  String? image;
  String? name;
  String? description;
  GymModel({
    this.id,
    this.image,
    this.name,
    this.description,
  });
  factory GymModel.fromMap(Map<String, dynamic> json) => GymModel(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
        "name": name,
        "description": description,
      };
}
