import 'package:flutter/material.dart';
import '../models/payment.dart';
import '../services/payment_service.dart';

class PaymentProvider extends ChangeNotifier {
  final PaymentService _paymentService;
  List<Payment> _payments = [];

  PaymentProvider(this._paymentService);

  List<Payment> get payments => _payments;

  Future<void> fetchPayments() async {
    _payments = await _paymentService.readAll();
    notifyListeners();
  }

  Future<void> addPayment(Payment payment) async {
    await _paymentService.create(payment);
    await fetchPayments();
  }

  Future<void> updatePayment(String id, Payment payment) async {
    await _paymentService.update(id, payment);
    await fetchPayments();
  }

  Future<void> deletePayment(String id) async {
    await _paymentService.delete(id);
    await fetchPayments();
  }
}
