import '../interface/base_repository.dart';
import '../models/payment.dart';

class PaymentRepository implements BaseRepository<Payment> {
  final List<Payment> _payments = [];

  @override
  Future<void> add(Payment payment) async {
    try {
      _payments.add(payment);
      print('Payment added: ${payment.paymentID}');
    } catch (e) {
      throw Exception('Failed to add payment: $e');
    }
  }

  @override
  Future<List<Payment>> getAll() async {
    try {
      return _payments;
    } catch (e) {
      throw Exception('Failed to fetch payments: $e');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      final initialLength = _payments.length;
      _payments.removeWhere((payment) => payment.paymentID.toString() == id);
      if (_payments.length == initialLength) {
        throw Exception('Payment with ID $id not found for deletion');
      }
      print('Payment deleted: $id');
    } catch (e) {
      throw Exception('Failed to delete payment: $e');
    }
  }

  @override
  Future<void> update(String id, Payment payment) async {
    try {
      final index = _payments.indexWhere((p) => p.paymentID.toString() == id);
      if (index == -1) {
        throw Exception('Payment with ID $id not found for update');
      }
      _payments[index] = payment;
      print('Payment updated: $id');
    } catch (e) {
      throw Exception('Failed to update payment: $e');
    }
  }

  @override
  Future<Payment?> findById(String id) async {
    try {
      return _payments.firstWhere((payment) => payment.paymentID.toString() == id);
    } catch (e) {
      print('Payment with ID $id not found');
      return null;
    }
  }
}
