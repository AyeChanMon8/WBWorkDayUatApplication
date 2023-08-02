// @dart=2.9

class Attachment {
  String _type;
  String _data;

  String get type => _type;

  String get data => _data;

  Attachment({
    String type,
    String data}) {
    _type = type;
    _data = data;
  }

  Attachment.fromJson(dynamic json) {
    _type = json['type'];
    _data = json['data'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['type'] = _type;
    map['data'] = _data;
    return map;
  }
}
