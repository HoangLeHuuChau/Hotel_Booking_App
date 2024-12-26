import '../models/payment.dart';
import '../interface/factory.dart';

class PaymentFactory extends Factory<Payment> {
  @override
  Payment create(Map<String, dynamic> data) {
    return Payment(
      paymentId: data['payment_id'] as int?,
      bookingId: data['booking_id'] as int,
      amount: (data['amount'] as num).toDouble(),
      paymentMethod: data['payment_method'] as String,
    );
  }
}
