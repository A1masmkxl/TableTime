class Restaurant {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final String address;
  final String cuisine;
  final String priceRange; // $, $$, $$$
  final double rating;
  final List<String> photos;
  final String phone;
  final String workingHours;
  final bool hasPromotion;
  final String? promotionText;

  Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.address,
    required this.cuisine,
    required this.priceRange,
    this.rating = 4.5,
    this.photos = const [],
    this.phone = '',
    this.workingHours = '10:00 - 23:00',
    this.hasPromotion = false,
    this.promotionText,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      description: json['description'] ?? '',
      address: json['address'] ?? '',
      cuisine: json['cuisine'] ?? '',
      priceRange: json['priceRange'] ?? '\$\$',
      rating: (json['rating'] ?? 4.5).toDouble(),
      photos: List<String>.from(json['photos'] ?? []),
      phone: json['phone'] ?? '',
      workingHours: json['workingHours'] ?? '10:00 - 23:00',
      hasPromotion: json['hasPromotion'] ?? false,
      promotionText: json['promotionText'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'address': address,
      'cuisine': cuisine,
      'priceRange': priceRange,
      'rating': rating,
      'photos': photos,
      'phone': phone,
      'workingHours': workingHours,
      'hasPromotion': hasPromotion,
      'promotionText': promotionText,
    };
  }
}