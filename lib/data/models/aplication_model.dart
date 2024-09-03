class Aplication {
  String? version;
  String? releaseDate;

  Aplication({
    this.version,
    this.releaseDate,
  });

  factory Aplication.fromJson(Map<String, dynamic> json) {
    return Aplication(
      version: json['version'] as String?,
      releaseDate: json['releaseDate'] as String?,
    );
  }
}
