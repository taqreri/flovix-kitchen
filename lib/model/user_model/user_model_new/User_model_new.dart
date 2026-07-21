  class UserModelNew {
  UserModelNew({
      this.sno, 
      this.companySno, 
      this.rolePer, 
      this.empSno, 
      this.branchId, 
      this.clientSno, 
      this.isMaster, 
      this.deviceName,
      this.userid,
      this.email,
      this.lang, 
      this.userdb, 
      this.companyNameEn, 
      this.companyNameAr, 
      this.companyLogo, 
      this.posSessionId, 
      this.token, 
      this.deviceCode, 
      this.deviceId, 
      this.employeeName,});

  UserModelNew.fromJson(dynamic json) {
    sno = json['sno'];
    companySno = json['company_sno'];
    rolePer = json['role_per'];
    empSno = json['emp_sno'];
    branchId = json['branch_id'];
    clientSno = json['client_sno'];
    isMaster = json['is_master'];
    userid = json['userid'];
    email = json['email'];
    lang = json['lang'];
    userdb = json['userdb'];
    companyNameEn = json['company_name_en'];
    companyNameAr = json['company_name_ar'];
    companyLogo = json['company_logo'];
    posSessionId = json['pos_session_id'];
    token = json['token'];
    deviceName = json['device_name'];
    deviceCode = json['device_code'];
    deviceId = json['device_id'];
    employeeName = json['employee_name'];
  }
  int? sno;
  int? companySno;
  int? rolePer;
  int? empSno;
  int? branchId;
  int? clientSno;
  int? isMaster;
  String? userid;
  String? email;
  int? lang;
  String? userdb;
  String? deviceName;
  String? companyNameEn;
  String? companyNameAr;
  String? companyLogo;
  int? posSessionId;
  String? token;
  String? deviceCode;
  int? deviceId;
  String? employeeName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sno'] = sno;
    map['company_sno'] = companySno;
    map['role_per'] = rolePer;
    map['emp_sno'] = empSno;
    map['branch_id'] = branchId;
    map['client_sno'] = clientSno;
    map['is_master'] = isMaster;
    map['userid'] = userid;
    map['email'] = email;
    map['lang'] = lang;
    map['userdb'] = userdb;
    map['device_name'] = deviceName;
    map['company_name_en'] = companyNameEn;
    map['company_name_ar'] = companyNameAr;
    map['company_logo'] = companyLogo;
    map['pos_session_id'] = posSessionId;
    map['token'] = token;
    map['device_code'] = deviceCode;
    map['device_id'] = deviceId;
    map['employee_name'] = employeeName;
    return map;
  }

}