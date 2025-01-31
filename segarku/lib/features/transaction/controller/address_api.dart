class Village {
  final String id;
  final String name;

  Village({required this.id, required this.name});

  factory Village.fromJson(Map<String, dynamic> json) {
    return Village(
      id: json['id'],
      name: json['name'],
    );
  }
}