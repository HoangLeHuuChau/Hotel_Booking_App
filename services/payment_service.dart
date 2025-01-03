import '../models/payment.dart';
import '../repositories/payment_repository.dart';
import '../interface/base_service.dart';

class PaymentService implements BaseService<Payment>{
  final PaymentRepository _repository;

  PaymentService(this._repository);

  @override
  Future<void> create(Payment payment) async {
    await _repository.add(payment);
  }

  @override
  Future<List<Payment>> readAll() async {
    return await _repository.getAll();
  }

  @override
  Future<Payment?> readById(int id) async {
    return await _repository.findById(id);
  }

  @override
  Future<void> update(int id, Payment payment) async {
    await _repository.update(id, payment);
  }

  @override
  Future<void> delete(int id) async {
    await _repository.delete(id);
  }
}
