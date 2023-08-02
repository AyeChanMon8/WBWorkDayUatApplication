// @dart=2.9

/// expense_line_id : 172
/// attachments : ["base64","base64","base64"]

class Expense_attachment {
  int _expenseLineId;
  List<String> _attachments;
  bool _attachment_exist;

  int get expenseLineId => _expenseLineId;
  List<String> get attachments => _attachments;

  Expense_attachment({
      int expenseLineId, 
      List<String> attachments,bool attachment_exist}){
    _expenseLineId = expenseLineId;
    _attachments = attachments;
    _attachment_exist = attachment_exist;
}

  Expense_attachment.fromJson(dynamic json) {
    _expenseLineId = json['expense_line_id'];
    _attachment_exist = json['attachment_exist'];
    if (json["attachments"] != null) {
      _attachments = [];
      json["attachments"].forEach((v) {
        print("attData");
        print(v);
        if(v=="false"||v==false){
          print("falseData");
        }else{
          _attachments.add(v);
        }

      });
    }

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['expense_line_id'] = _expenseLineId;
    map['attachments'] = _attachments;
    return map;
  }

}