class MealModel {
  final String? photoUrl;
  final String name;
  final String description;
  final String location;
  final double latitude;
  final double longitude;

  MealModel({
    required this.photoUrl,
    required this.name,
    required this.description,
    required this.location,
    required this.latitude,
    required this.longitude,
  });
}
