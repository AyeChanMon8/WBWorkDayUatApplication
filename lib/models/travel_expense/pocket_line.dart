// @dart=2.9
import 'dart:convert';

import 'package:winbrother_hr_app/models/travel_expense/category_model.dart';
import 'package:winbrother_hr_app/models/travel_expense/product_model.dart';

class PocketLine {
  String date;
  CategoryModel categ_id;
  ProductModel product_id;
  String description;
  double qty;
  double price_unit;
  double price_subtotal;
  String attached_file;
  Vehicle_id vehicle_id;
  bool attachment_include;
  int id;
  PocketLine({
    this.date,
    this.categ_id,
    this.product_id,
    this.description,
    this.qty,
    this.price_unit,
    this.price_subtotal,
    this.attached_file,
    this.vehicle_id,this.id,this.attachment_include
  });

  PocketLine copyWith({
    String date,
    CategoryModel categ_id,
    ProductModel product_id,
    String description,
    double qty,
    double price_unit,
    double price_subtotal,
    String attached_file,
    Vehicle_id vehicle_id
  }) {
    return PocketLine(
        date: date ?? this.date,
        categ_id: categ_id ?? this.categ_id,
        product_id: product_id ?? this.product_id,
        description: description ?? this.description,
        qty: qty ?? this.qty,
        price_unit: price_unit ?? this.price_unit,
        price_subtotal: price_subtotal ?? this.price_subtotal,
        attached_file: attached_file ?? this.attached_file,
        vehicle_id: vehicle_id ?? this.vehicle_id
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'categ_id': categ_id?.toMap(),
      'product_id': product_id?.toMap(),
      'description': description,
      'qty': qty,
      'price_unit': price_unit,
      'price_subtotal': price_subtotal,
      'attached_file': attached_file,
      'vehicle_id' : vehicle_id
    };
  }

  factory PocketLine.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PocketLine(
        id: map['id'],
        date: map['date'],
        categ_id: CategoryModel.fromMap(map['categ_id']),
        product_id: ProductModel.fromMap(map['product_id']),
        description: map['description'],
        qty: map['qty'],
        price_unit: map['price_unit'],
        price_subtotal: map['price_subtotal'],
        attached_file: map['attached_file'],
        vehicle_id: map['vehicle_id'] != null ? Vehicle_id.fromJson(map['vehicle_id']) : null,
        attachment_include: map['attachment_include'] !=null? map['attachment_include'] : false
    );
  }

  String toJson() => json.encode(toMap());

  factory PocketLine.fromJson(String source) =>
      PocketLine.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PocketLine(date: $date, categ_id: $categ_id, product_id: $product_id, description: $description, qty: $qty, price_unit: $price_unit, price_subtotal: $price_subtotal, attached_file: $attached_file,vehicle_id: $vehicle_id)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PocketLine &&
        o.date == date &&
        o.categ_id == categ_id &&
        o.product_id == product_id &&
        o.description == description &&
        o.qty == qty &&
        o.price_unit == price_unit &&
        o.price_subtotal == price_subtotal &&
        o.attached_file == attached_file;
  }

  @override
  int get hashCode {
    return date.hashCode ^
    categ_id.hashCode ^
    product_id.hashCode ^
    description.hashCode ^
    qty.hashCode ^
    price_unit.hashCode ^
    price_subtotal.hashCode ^
    attached_file.hashCode;
  }

}
class Vehicle_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Vehicle_id({
    int id,
    String name}){
    _id = id;
    _name = name;
  }

  Vehicle_id.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

}