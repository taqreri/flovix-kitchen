/// sno : 1
/// emp_fname : "Ahmed"
/// emp_lname : "Al Johani"

class EmployeeModel {
  EmployeeModel({
      this.sno, 
      this.empFname, 
      this.empLname,});

  EmployeeModel.fromJson(dynamic json) {
    sno = json['sno'];
    empFname = json['emp_fname'];
    empLname = json['emp_lname'];
  }
  int? sno;
  String? empFname;
  String? empLname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sno'] = sno;
    map['emp_fname'] = empFname;
    map['emp_lname'] = empLname;
    return map;
  }

}