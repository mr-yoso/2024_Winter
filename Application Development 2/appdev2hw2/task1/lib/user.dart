import 'dbhelper.dart';

class User {
  final int? id; // Nullable because the database will generate it
  final String firstName;
  final String lastName;

  User({this.id, required this.firstName, required this.lastName});

  User.fromMap(Map<String, dynamic> map)
      : id = map[DatabaseHelper.columnId],
        firstName = map[DatabaseHelper.columnFirstName],
        lastName = map[DatabaseHelper.columnLastName];

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnFirstName: firstName,
      DatabaseHelper.columnLastName: lastName,
    };
  }
}
