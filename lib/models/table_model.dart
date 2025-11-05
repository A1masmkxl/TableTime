class RestaurantTable {
  final String id;
  final String restaurantId;
  final int number;
  final int capacity;
  final double x; // позиция на карте (процент от ширины)
  final double y; // позиция на карте (процент от высоты)
  final TableShape shape;
  bool isBooked;
  String? bookingId;

  RestaurantTable({
    required this.id,
    required this.restaurantId,
    required this.number,
    required this.capacity,
    required this.x,
    required this.y,
    this.shape = TableShape.circle,
    this.isBooked = false,
    this.bookingId,
  });

  factory RestaurantTable.fromJson(Map<String, dynamic> json) {
    return RestaurantTable(
      id: json['id'] ?? '',
      restaurantId: json['restaurantId'] ?? '',
      number: json['number'] ?? 0,
      capacity: json['capacity'] ?? 2,
      x: (json['x'] ?? 0).toDouble(),
      y: (json['y'] ?? 0).toDouble(),
      shape: TableShape.values.firstWhere(
            (e) => e.toString() == 'TableShape.${json['shape']}',
        orElse: () => TableShape.circle,
      ),
      isBooked: json['isBooked'] ?? false,
      bookingId: json['bookingId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'number': number,
      'capacity': capacity,
      'x': x,
      'y': y,
      'shape': shape.toString().split('.').last,
      'isBooked': isBooked,
      'bookingId': bookingId,
    };
  }

  RestaurantTable copyWith({
    bool? isBooked,
    String? bookingId,
  }) {
    return RestaurantTable(
      id: id,
      restaurantId: restaurantId,
      number: number,
      capacity: capacity,
      x: x,
      y: y,
      shape: shape,
      isBooked: isBooked ?? this.isBooked,
      bookingId: bookingId ?? this.bookingId,
    );
  }
}

enum TableShape {
  circle,
  square,
  rectangle,
}