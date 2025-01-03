import '../models/payment.dart';
import '../interface/factory.dart';

// PaymentFactory là một lớp Factory, được sử dụng để tạo các đối tượng Payment từ dữ liệu dạng Map.
class PaymentFactory extends Factory<Payment> {
  @override
  Payment create(Map<String, dynamic> data) {
    // Tạo một đối tượng Payment từ dữ liệu Map với các trường được ánh xạ tương ứng.
    return Payment(
      paymentID: data['paymentID'] as int, // ID của thanh toán.
      bookingID: data['bookingID'] as int, // ID của đặt chỗ liên quan.
      paymentDate: DateTime.parse(data['paymentDate'] as String), // Ngày thực hiện thanh toán.
      paymentMethod: data['paymentMethod'] as String, // Phương thức thanh toán (ví dụ: thẻ, tiền mặt).
      amount: (data['amount'] as num).toDouble(), // Số tiền thanh toán (float).
    );
  }
}