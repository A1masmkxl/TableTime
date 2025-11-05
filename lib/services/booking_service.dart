import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tabletime/models/booking_model.dart';

class BookingService {
  final _bookings = FirebaseFirestore.instance.collection('bookings');

  Future<bool> createBooking(Booking booking) async {
    try {
      final doc = _bookings.doc();
      await doc.set({
        ...booking.toMap(),
        'id': doc.id,
      });
      return true;
    } catch (e) {
      print('Error creating booking: $e');
      return false;
    }
  }

  Future<List<Booking>> getUserBookings(String userId) async {
    final query = await _bookings
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    return query.docs.map((doc) => Booking.fromMap(doc.data())).toList();
  }
}
