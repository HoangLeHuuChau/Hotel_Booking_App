import '../models/payment.dart';
import '../interface/factory.dart';

// Factory cho Payment
class PaymentFactory extends Factory<Payment> {
  @override
  Payment create(Map<String, dynamic> data) {
    return Payment(
      paymentID: data['paymentID'] as int,
      bookingID: data['bookingID'] as int,
      paymentDate: DateTime.parse(data['paymentDate'] as String),
      paymentMethod: data['paymentMethod'] as String,
      amount: (data['amount'] as num).toDouble(),
    );
  }
}
