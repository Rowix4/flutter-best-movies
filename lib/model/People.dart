class People {
  final int id;
  final String name;

  People({this.id, this.name});

  factory People.fromJson(Map<String, dynamic> json, type) {
    return People(
        id: json['id'],
        name: json['name'],
    );
  }
}