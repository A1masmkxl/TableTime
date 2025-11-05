enum BookingStatus { pending, confirmed, cancelled }

class Booking {
  final String id;
  final String restaurantId;
  final String? tableId;
  final String userId;
  final String userName;
  final String userPhone;
  final int peopleCount;
  final DateTime date;
  final String? specialRequests;
  final BookingStatus status;
  final DateTime createdAt;

  Booking({
    required this.id,
    required this.restaurantId,
    this.tableId,
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.peopleCount,
    required this.date,
    this.specialRequests,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'tableId': tableId,
      'userId': userId,
      'userName': userName,
      'userPhone': userPhone,
      'peopleCount': peopleCount,
      'date': date.toIso8601String(),
      'specialRequests': specialRequests,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'] ?? '',
      restaurantId: map['restaurantId'] ?? '',
      tableId: map['tableId'],
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      userPhone: map['userPhone'] ?? '',
      peopleCount: map['peopleCount'] ?? 1,
      date: DateTime.parse(map['date']),
      specialRequests: map['specialRequests'],
      status: BookingStatus.values.firstWhere(
            (e) => e.name == map['status'],
        orElse: () => BookingStatus.pending,
      ),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
