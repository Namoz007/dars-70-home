
class CardModel {
  final String id;
  String fullName;
  String cardName;
  int number;
  DateTime expiryDate;
  double balance;

  CardModel({
    required this.id,
    required this.fullName,
    required this.cardName,
    required this.number,
    required this.expiryDate,
    required this.balance,
  });

  factory CardModel.fromJson(Map<String, dynamic> mp) {
    return CardModel(
      id: mp['id'],
      fullName: mp['fullName'],
      cardName: mp['cardName'],
      number: int.parse(mp['number'].toString()),
      expiryDate: DateTime.parse(mp['expiryDate'].toString()),
      balance: double.parse(mp['balance'].toString()),
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "id": id,
      "fullName": fullName,
      "cardName": cardName,
      "number": number.toString(),
      "expiryDate": expiryDate.toString(),
      "balance": balance.toString(),
    };
  }
}
