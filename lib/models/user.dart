class User {
  final String uid;

  User({required this.uid});
}

class UserData {
  final String? uid;
  final String name;
  final String sugars;
  final int amount;

  UserData(
      {this.uid,
      required this.name,
      required this.sugars,
      required this.amount});
}
