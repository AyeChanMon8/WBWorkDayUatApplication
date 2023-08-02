// @dart=2.9

/// folder_id : 5
/// folder_name : "HR"

class Document_folder {
  int _folderId;
  String _folderName;

  int get folderId => _folderId;
  String get folderName => _folderName;

  Document_folder({
      int folderId, 
      String folderName}){
    _folderId = folderId;
    _folderName = folderName;
}

  Document_folder.fromJson(dynamic json) {
    _folderId = json["folder_id"];
    _folderName = json["folder_name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["folder_id"] = _folderId;
    map["folder_name"] = _folderName;
    return map;
  }

}