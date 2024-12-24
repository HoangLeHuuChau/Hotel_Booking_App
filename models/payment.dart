class Payment {
  final int? paymentId;
  final int bookingId;
  final double amount;
  final String paymentMethod;

  Payment({
    this.paymentId,
    required this.bookingId,
    required this.amount,
    required this.paymentMethod,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      paymentId: json['payment_id'],
      bookingId: json['booking_id'],
      amount: json['amount'],
      paymentMethod: json['payment_method'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payment_id': paymentId,
      'booking_id': bookingId,
      'amount': amount,
      'payment_method': paymentMethod,
    };
  }
}