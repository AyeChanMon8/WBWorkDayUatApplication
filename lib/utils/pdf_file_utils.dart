import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

Future<String> createPDFFileFromString(String encodedStr) async {
  //final encodedStr = "put base64 encoded string here";
  Uint8List bytes = base64.decode(encodedStr);
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file =
      File("$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
  await file.writeAsBytes(bytes);
  return file.path.toString();
}


Future<String> createExcelFileFromString(String encodedStr) async {
  //final encodedStr = "put base64 encoded string here";
  Uint8List bytes = base64.decode(encodedStr);
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file =
      File("$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".xls");
  await file.writeAsBytes(bytes);
  return file.path.toString();
}

Future<String> createWordFileFromString(String encodedStr) async {
  //final encodedStr = "put base64 encoded string here";
  Uint8List bytes = base64.decode(encodedStr);
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file =
      File("$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".doc");
  await file.writeAsBytes(bytes);
  return file.path.toString();
}

Future<String> createDocxWordFileFromString(String encodedStr) async {
  //final encodedStr = "put base64 encoded string here";
  Uint8List bytes = base64.decode(encodedStr);
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file =
      File("$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".docx");
  await file.writeAsBytes(bytes);
  return file.path.toString();
}

Future<String> createExFileFromString(String encodedStr) async {
  //final encodedStr = "put base64 encoded string here";
  Uint8List bytes = base64.decode(encodedStr);
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file =
      File("$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".xlsx");
  await file.writeAsBytes(bytes);
  return file.path.toString();
}
