// @dart=2.9

import 'package:winbrother_hr_app/models/document.dart';
import 'package:winbrother_hr_app/models/employee.dart';
import 'package:winbrother_hr_app/models/insurance.dart';
import 'package:winbrother_hr_app/models/leave_line.dart';

enum OTPValiationResults {
  VALID,
  NON_VALID,
}

enum ValiationResult {
  VALID,
  INVALID,
}

class Validator {
  ValiationResult checkListNotEmpty(List list) {
    if (list != null && list.length > 0) {
      return ValiationResult.VALID;
    } else {
      return ValiationResult.INVALID;
    }
  }

  ValiationResult checkEmp(Employee emp) {
    if (emp.name == 'Kyaw Zay Ya') {
      return ValiationResult.VALID;
    } else {
      ValiationResult.INVALID;
    }
  }

    /*ValiationResult checkDoc(Documents doc) {
    if (doc.id == 6) {
      return ValiationResult.VALID;
    } else {
      ValiationResult.INVALID;
    }
  }*/

  ValiationResult checkEmpID(int emp_id) {
    if (emp_id!=0) {
      return ValiationResult.VALID;
    } else {
      ValiationResult.INVALID;
    }
  }

  ValiationResult checkPinCode(String pinCode) {
    if (pinCode == '') {
      return ValiationResult.INVALID;
    } else {
      return ValiationResult.VALID;
    }
  }

  ValiationResult checkIdReturn(int id) {
    if (id != null) {
      return ValiationResult.VALID;
    } else {
      return ValiationResult.INVALID;
    }
  }

  ValiationResult checkSuccessCreate(bool created) {
    if (created) {
      return ValiationResult.VALID;
    } else {
      return ValiationResult.INVALID;
    }
  }

  ValiationResult checkempIDReturn(int empid) {
    if (empid != null) {
      return ValiationResult.VALID;
    } else {
      return ValiationResult.INVALID;
    }
  }

  ValiationResult checkStringIfEmpty(String role) {
    if (role != null && role.isNotEmpty) {
      return ValiationResult.VALID;
    } else {
      return ValiationResult.INVALID;
    }
  }

  ValiationResult checkLeaveLineNotEmpty(LeaveLine leaveLine) {
    if (leaveLine != null) {
      return ValiationResult.VALID;
    } else {
      ValiationResult.INVALID;
    }
  }

  ValiationResult checkInsurance(Insurance emp) {
    if (emp.name == 'Hnin Nandar Linn') {
      return ValiationResult.VALID;
    } else {
      ValiationResult.INVALID;
    }
  }
}
