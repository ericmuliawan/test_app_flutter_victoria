import '../helper/dbHelper.dart';

class User {
  int? id;
  String? name;
  int? usia;
  String? gender;

  User(this.id, this.name, this.usia, this.gender);

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    usia = map['usia'];
    gender = map['gender'];
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnUsia: usia,
      DatabaseHelper.columnGender: gender,
    };
  }
}
