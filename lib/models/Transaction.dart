class Transaction {
  String title;
  DateTime date ;
  double amount;
  String id;
 
  Transaction({this.amount, this.title,this.date,this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount' : amount,
      'date': date.toString(),
    };
  }

}
