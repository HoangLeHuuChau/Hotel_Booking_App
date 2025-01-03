class Payment {
  final int paymentID;
  final int bookingID;
  final DateTime paymentDate;
  final String paymentMethod;
  final double amount;

  Payment({
    required this.paymentID,
    required this.bookingID,
    required this.paymentDate,
    required this.paymentMethod,
    required this.amount,
  });

  // Deserialize from database map
  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      paymentID: map['paymentID'],
      bookingID: map['bookingID'],
      paymentDate: DateTime.parse(map['paymentDate']),
      paymentMethod: map['paymentMethod'],
      amount: map['amount'].toDouble(),
    );
  }

  // Serialize to database map
  Map<String, dynamic> toMap() {
    return {
      'paymentID': paymentID,
      'bookingID': bookingID,
      'paymentDate': paymentDate.toIso8601String(),
      'paymentMethod': paymentMethod,
      'amount': amount,
    };
  }
}
