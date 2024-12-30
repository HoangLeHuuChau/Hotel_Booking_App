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

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      paymentID: json['paymentID'],
      bookingID: json['bookingID'],
      paymentDate: DateTime.parse(json['paymentDate']),
      paymentMethod: json['paymentMethod'],
      amount: json['amount'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentID': paymentID,
      'bookingID': bookingID,
      'paymentDate': paymentDate.toIso8601String(),
      'paymentMethod': paymentMethod,
      'amount': amount,
    };
  }
}
