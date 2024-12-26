import 'base_repository.dart';
import '../models/payment.dart';

class PaymentRepository extends BaseRepository<Payment> {
  final List<Payment> _payments = [];

  @override
  Future<void> add(Payment payment) async {
    _payments.add(payment);
  }

  @override
  Future<List<Payment>> getAll() async {
    return _payments;
  }

  @override
  Future<void> delete(String id) async {
    _payments.removeWhere((payment) => payment.paymentId == id);
  }

  @override
  Future<void> update(String id, Payment payment) async {
    final index = _payments.indexWhere((p) => p.paymentId == id);
    if (index != -1) {
      _payments[index] = payment;
    }
  }

  @override
  Future<Payment?> findById(String id) async {
    try{
      return _payments.firstWhere((payment) => payment.paymentId == id);
    }catch (e) {
      return null;
    }
  }
}
