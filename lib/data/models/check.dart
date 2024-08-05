class Check {
  int sendCard;
  int acceptCard;
  double sum;
  DateTime date;

  Check({
    required this.sendCard,
    required this.acceptCard,
    required this.sum,
    required this.date,
  });

  // fromJson factory
  factory Check.fromJson(Map<String, dynamic> json) {
    return Check(
      sendCard: int.parse(json['sendCard'].toString()),
      acceptCard: int.parse(json['acceptCard'].toString()),
      sum: double.parse(json['sum'].toString()),
      date: DateTime.parse(json['date'].toString()),
    );
  }

  // toJson method
  Map<String, dynamic> toMap() {
    return {
      'sendCard': sendCard,
      'acceptCard': acceptCard,
      'sum': sum,
      'date': date.toIso8601String(),
    };
  }
}
