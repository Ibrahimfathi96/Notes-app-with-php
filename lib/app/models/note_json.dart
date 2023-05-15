import 'note.dart';

/// status : "success"
/// data : [{"notes_id":11,"notes_title":"Note 1","notes_content":"Content 1","notes_image":"","notes_users":3},{"notes_id":12,"notes_title":"Note 2","notes_content":"Content 2","notes_image":"","notes_users":3}]

class NoteMd {
  NoteMd({
      required this.status,
      required this.noteMD,});

  NoteMd.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      noteMD = [];
      json['data'].forEach((v) {
        noteMD?.add(NoteMD.fromJson(v));
      });
    }
  }
  String? status;
  List<NoteMD>? noteMD;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (noteMD != null) {
      map['data'] = noteMD?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}