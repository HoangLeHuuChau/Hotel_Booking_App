import 'package:flutter/material.dart';
import '../models/payment.dart';
import '../services/payment_service.dart';

// PaymentProvider là một ChangeNotifier, được sử dụng để quản lý trạng thái liên quan đến thanh toán trong ứng dụng.
class PaymentProvider extends ChangeNotifier {
  final PaymentService _paymentService; // PaymentService để thực hiện các thao tác CRUD với dữ liệu thanh toán.
  List<Payment> _payments = []; // Danh sách các thanh toán hiện tại.

  // Constructor của PaymentProvider, yêu cầu một PaymentService để khởi tạo.
  PaymentProvider(this._paymentService);

  // Getter để lấy danh sách các thanh toán hiện tại.
  List<Payment> get payments => _payments;

  // Phương thức fetchPayments để lấy tất cả các thanh toán từ PaymentService.
  Future<void> fetchPayments() async {
    _payments = await _paymentService.readAll(); // Lấy danh sách thanh toán từ dịch vụ.
    notifyListeners(); // Thông báo cho các widget lắng nghe để cập nhật giao diện.
  }

  // Phương thức addPayment để thêm một thanh toán mới.
  Future<void> addPayment(Payment payment) async {
    await _paymentService.create(payment); // Thêm thanh toán mới thông qua dịch vụ.
    await fetchPayments(); // Tải lại danh sách thanh toán để cập nhật.
  }

  // Phương thức updatePayment để cập nhật thông tin thanh toán đã có.
  Future<void> updatePayment(int id, Payment payment) async {
    await _paymentService.update(id, payment); // Cập nhật thanh toán thông qua dịch vụ.
    await fetchPayments(); // Tải lại danh sách thanh toán để cập nhật.
  }

  // Phương thức deletePayment để xóa một thanh toán dựa trên ID.
  Future<void> deletePayment(int id) async {
    await _paymentService.delete(id); // Xóa thanh toán thông qua dịch vụ.
    await fetchPayments(); // Tải lại danh sách thanh toán để cập nhật.
  }
}