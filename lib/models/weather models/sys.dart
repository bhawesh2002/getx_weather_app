class Sys {
  Sys({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  final num type;
  final num id;
  final String country;
  final num sunrise;
  final num sunset;

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      type: json["type"] ?? 0,
      id: json["id"] ?? 0,
      country: json["country"] ?? "",
      sunrise: json["sunrise"] ?? 0,
      sunset: json["sunset"] ?? 0,
    );
  }
}
