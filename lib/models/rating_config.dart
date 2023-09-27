// @dart=2.9

import 'dart:convert';

class RatingConfig {
  int id ;
  String rating_description;
  String name;
  RatingConfig({this.id,this.rating_description,this.name});

  RatingConfig copyWith({
    int id,
    String rating_description,
    String name
  }) {
    return RatingConfig(
      id: id ?? this.id,
      rating_description: rating_description ?? this.rating_description,
      name: name ?? this.name
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rating_description': rating_description,
      'name': name
    };
  }

  factory RatingConfig.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return RatingConfig(
      id: map['id']??0,
      rating_description: map['rating_description']??'',
      name: map['name']??''
    );
  }

  String toJson() => json.encode(toMap());

  factory RatingConfig.fromJson(String source) => RatingConfig.fromMap(json.decode(source));

  @override
  String toString() => 'RatingConfig(id: $id, rating_description: $rating_description, name : $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is RatingConfig &&
      o.id == id &&
      o.rating_description == rating_description &&
      o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ rating_description.hashCode ^ name.hashCode;
}
