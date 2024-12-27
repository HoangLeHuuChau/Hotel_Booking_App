import '../interface/base_service.dart';
import '../models/payment.dart';
import '../repositories/payment_respository.dart';

class PaymentService implements BaseService<Payment> {
  final PaymentRepository _repository;

  PaymentService(this._repository);

  @override
  Future<void> create(Payment payment) async {
    // Thêm logic nghiệp vụ nếu cần trước khi lưu vào repository.
    await _repository.add(payment);
  }

  @override
  Future<List<Payment>> readAll() async {
    return await _repository.getAll();
  }

  @override
  Future<Payment?> readById(String id) async {
    return await _repository.findById(id);
  }

  @override
  Future<void> update(String id, Payment payment) async {
    // Thêm logic nghiệp vụ nếu cần trước khi cập nhật.
    await _repository.update(id, payment);
  }

  @override
  Future<void> delete(String id) async {
    // Thêm logic nghiệp vụ nếu cần trước khi xóa.
    await _repository.delete(id);
  }
}
