/// notes_id : 11
/// notes_title : "Note 1"
/// notes_content : "Content 1"
/// notes_image : ""
/// notes_users : 3

class NoteMD {
  NoteMD({
      required this.notesId,
      required this.notesTitle,
      required this.notesContent,
      required this.notesImage,
      required this.notesUsers,});

  NoteMD.fromJson(dynamic json) {
    notesId = json['notes_id'];
    notesTitle = json['notes_title'];
    notesContent = json['notes_content'];
    notesImage = json['notes_image'];
    notesUsers = json['notes_users'];
  }
  num? notesId;
  String? notesTitle;
  String? notesContent;
  String? notesImage;
  num? notesUsers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['notes_id'] = notesId;
    map['notes_title'] = notesTitle;
    map['notes_content'] = notesContent;
    map['notes_image'] = notesImage;
    map['notes_users'] = notesUsers;
    return map;
  }

}