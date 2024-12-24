import 'i_repository.dart';
import '../models/payment.dart';
import '../data/database_config.dart';

class PaymentRepository implements IRepository<Payment> {
  final DatabaseConfig _dbConfig;

  PaymentRepository(this._dbConfig);

  @override
  Future<List<Payment>> getAll() async {
    final db = await _dbConfig.database;
    final results = await db.query('payments');
    return results.map((row) => Payment.fromJson(row)).toList();
  }

  @override
  Future<void> add(Payment payment) async {
    final db = await _dbConfig.database;
    await db.insert(
      'payments',
      payment.toJson(),
    );
  }
}