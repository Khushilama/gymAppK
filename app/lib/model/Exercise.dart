class Exercise {
  String? id;
  String? image;
  String? name;
  String? sets;

  Exercise({
    this.id,
    this.image,
    this.name,
    this.sets,
  });

  factory Exercise.fromMap(Map<String, dynamic> json) => Exercise(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        sets: json["sets"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
        "name": name,
        "sets": sets,
      };
  Exercise copyWith({
    String? image,
    String? name,
    String? sets,
  }) {
    return Exercise(
      id: id,
      image: image ?? this.image,
      name: name ?? this.name,
      sets: sets ?? this.sets,
    );
  }
}
