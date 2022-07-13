class Transaction {
  String title;
  String id;
  double amount;
  DateTime dt;
  Transaction({
    required this.amount,
    required this.dt,
    required this.id,
    required this.title,
  });
}
