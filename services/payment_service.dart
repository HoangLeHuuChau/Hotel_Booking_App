import '../models/payment.dart';
import '../repositories/payment_repository.dart';
import '../interface/base_service.dart';

// PaymentService cung cấp các phương thức cấp cao để thao tác với PaymentRepository.
class PaymentService implements BaseService<Payment> {
  final PaymentRepository _repository; // Repository để thao tác với database.

  // Constructor khởi tạo PaymentService với một PaymentRepository.
  PaymentService(this._repository);

  // Tạo một thanh toán mới.
  @override
  Future<void> create(Payment payment) async {
    await _repository.add(payment);
  }

  // Lấy danh sách tất cả các thanh toán.
  @override
  Future<List<Payment>> readAll() async {
    return await _repository.getAll();
  }

  // Lấy thông tin một thanh toán dựa vào ID.
  @override
  Future<Payment?> readById(int id) async {
    return await _repository.findById(id);
  }

  // Cập nhật thông tin một thanh toán.
  @override
  Future<void> update(int id, Payment payment) async {
    await _repository.update(id, payment);
  }

  // Xóa một thanh toán dựa vào ID.
  @override
  Future<void> delete(int id) async {
    await _repository.delete(id);
  }
}