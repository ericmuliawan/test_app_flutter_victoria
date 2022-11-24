class photo {
  late int? id = 0;
  late String? photoName = "";
  late String? reviewName = "";
  late String? date = "";
  late String? note = "";

  photo(String imgString, String nameString, String dateString,
      String noteString) {
    this.photoName = imgString;
    this.reviewName = nameString;
    this.date = dateString;
    this.note = noteString;
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'photoName': photoName,
      'reviewName': reviewName,
      'date': date,
      'note': note,
    };
    return map;
  }

  photo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    photoName = map['photoName'];
    reviewName = map['reviewName'];
    date = map['date'];
    note = map['note'];
  }
}
