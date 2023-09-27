// @dart=2.9

import 'dart:convert';

class PMSattachment {
  int id ;
  String name;
  String attach_file;
  PMSattachment({this.id,this.name,this.attach_file});

  PMSattachment copyWith({
    int id,
    String attach_file,
    String name
  }) {
    return PMSattachment(
      id: id ?? this.id,
      attach_file: attach_file ?? this.attach_file,
      name: name ?? this.name
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'attach_file': attach_file,
      'name': name
    };
  }

  factory PMSattachment.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return PMSattachment(
      id: map['id']??0,
      attach_file: map['attach_file']??'',
      name: map['name']??''
    );
  }

  String toJson() => json.encode(toMap());

  factory PMSattachment.fromJson(String source) => PMSattachment.fromMap(json.decode(source));

  @override
  String toString() => 'PMSattachment(id: $id, attach_file: $attach_file, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is PMSattachment &&
      o.id == id &&
      o.attach_file == attach_file &&
      o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ attach_file.hashCode ^ name.hashCode;
}
