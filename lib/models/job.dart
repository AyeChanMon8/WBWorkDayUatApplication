// @dart=2.9

import 'package:flutter/material.dart';

class Job{
  final int id;
  final String name;

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Job({
     this.id,
     this.name,
  });

  Job copyWith({
    int id,
    String name,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name))) {
      return this;
    }

    return new Job(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'Job{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Job &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  factory Job.fromMap(Map<String, dynamic> map) {
    return new Job(
      id: map['id'] as int??0,
      name: map['name'] as String??'',
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
    } as Map<String, dynamic>;
  }

  //</editor-fold>


}