class CustomerDetailModel {
  CustomerDetailModel({
      this.sno, 
      this.cusSubId, 
      this.ctypeId, 
      this.customerNo, 
      this.cusName, 
      this.firstName, 
      this.lastName, 
      this.cusEmail, 
      this.password, 
      this.gender, 
      this.photo, 
      this.theme, 
      this.lang, 
      this.cusAddress, 
      this.cusAddressL2, 
      this.cusShippingAddress, 
      this.plotNo, 
      this.city, 
      this.town, 
      this.statPro, 
      this.branch, 
      this.locationId, 
      this.latitude, 
      this.longitude, 
      this.postCode, 
      this.poNumber, 
      this.country, 
      this.dialCode, 
      this.mobile, 
      this.phone, 
      this.dob, 
      this.warehouse, 
      this.companyName, 
      this.jobTitle, 
      this.department, 
      this.fbUrl, 
      this.twitUrl, 
      this.instaUrl, 
      this.whatsappNo, 
      this.otherSocialUrl, 
      this.notes, 

      this.companyId, 
      this.clientId, 
      this.userSno, 
      this.regDate, 
      this.isCustomer, 
      this.status, 
      this.dateCreated, 
      this.openingBalance, 
      this.custTaxNo, 
      this.totalCredit, 
      this.buildingNo, 
      this.districtName, 
      this.customerGroup, 
      this.cusImg, 
      this.isBusiness, 
      this.resetToken, 
      this.tokenDatetime, 
      this.coRegNo, 
      this.creditEnable, 
      this.shopCustomer, 
      this.idNumber, 
      this.oldFileNo, 
      this.age, 
      this.job, 
      this.eligiblity, 
      this.insuranceCardNo, 
      this.idCardExpiryDate, 
      this.insuranceNoEndDate, 
      this.policyNumber, 
      this.insuranceClassId, 
      this.insuranceCompanyId, 
      this.idNoPhoto, 
      this.cardNoPhoto, 
      this.maritalStatus, 
      this.nameAr, 
      this.updatedAt, 
      this.sallaCustomerId, 
      this.isBlacklist, 
      this.tag, 
      this.loyaltyOffers,});

  CustomerDetailModel.fromJson(dynamic json) {
    sno = json['sno'];
    cusSubId = json['cus_sub_id'];
    ctypeId = json['ctype_id'];
    customerNo = json['customer_no'];
    cusName = json['cus_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    cusEmail = json['cus_email'];
    password = json['password'];
    gender = json['gender'];
    photo = json['photo'];
    theme = json['theme'];
    lang = json['lang'];
    cusAddress = json['cus_address'];
    cusAddressL2 = json['cus_address_l2'];
    cusShippingAddress = json['cus_shipping_address'];
    plotNo = json['plot_no'];
    city = json['city'];
    town = json['town'];
    statPro = json['stat_pro'];
    branch = json['branch'];
    locationId = json['location_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    postCode = json['post_code'];
    poNumber = json['po_number'];
    country = json['country'];
    dialCode = json['dial_code'];
    mobile = json['mobile'];
    phone = json['phone'];
    dob = json['dob'];
    warehouse = json['warehouse'];
    companyName = json['company_name'];
    jobTitle = json['job_title'];
    department = json['department'];
    fbUrl = json['fb_url'];
    twitUrl = json['twit_url'];
    instaUrl = json['insta_url'];
    whatsappNo = json['whatsapp_no'];
    otherSocialUrl = json['other_social_url'];
    notes = json['notes'];

    companyId = json['company_id'];
    clientId = json['client_id'];
    userSno = json['user_sno'];
    regDate = json['reg_date'];
    isCustomer = json['is_customer'];
    status = json['status'];
    dateCreated = json['date_created'];
    openingBalance = json['opening_balance'];
    custTaxNo = json['cust_tax_no'];
    totalCredit = json['total_credit'];
    buildingNo = json['building_no'];
    districtName = json['district_name'];
    customerGroup = json['customer_group'];
    cusImg = json['cus_img'];
    isBusiness = json['is_business'];
    resetToken = json['reset_token'];
    tokenDatetime = json['token_datetime'];
    coRegNo = json['co_reg_no'];
    creditEnable = json['credit_enable'];
    shopCustomer = json['shop_customer'];
    idNumber = json['id_number'];
    oldFileNo = json['old_file_no'];
    age = json['age'];
    job = json['job'];
    eligiblity = json['eligiblity'];
    insuranceCardNo = json['insurance_card_no'];
    idCardExpiryDate = json['id_card_expiry_date'];
    insuranceNoEndDate = json['insurance_no_end_date'];
    policyNumber = json['policy_number'];
    insuranceClassId = json['insurance_class_id'];
    insuranceCompanyId = json['insurance_company_id'];
    idNoPhoto = json['id_no_photo'];
    cardNoPhoto = json['card_no_photo'];
    maritalStatus = json['marital_status'];
    nameAr = json['name_ar'];
    updatedAt = json['updated_at'];
    sallaCustomerId = json['salla_customer_id'];
    isBlacklist = json['is_blacklist'];
    tag = json['tag'].toString();
    loyaltyOffers = json['loyalty_offers'] != null ? json['loyalty_offers'].cast<int>() : [];
  }
  int? sno;
  int? cusSubId;
  int? ctypeId;
  String? customerNo;
  String? cusName;
  String? firstName;
  String? lastName;
  String? cusEmail;
  dynamic password;
  int? gender;
  dynamic photo;
  String? theme;
  int? lang;
  String? cusAddress;
  String? cusAddressL2;
  String? cusShippingAddress;
  String? plotNo;
  String? city;
  String? town;
  dynamic statPro;
  int? branch;
  int? locationId;
  String? latitude;
  String? longitude;
  String? postCode;
  int? poNumber;
  int? country;
  int? dialCode;
  String? mobile;
  String? phone;
  dynamic dob;
  int? warehouse;
  dynamic companyName;
  dynamic jobTitle;
  dynamic department;
  dynamic fbUrl;
  dynamic twitUrl;
  dynamic instaUrl;
  dynamic whatsappNo;
  dynamic otherSocialUrl;
  dynamic notes;

  int? companyId;
  int? clientId;
  int? userSno;
  String? regDate;
  int? isCustomer;
  int? status;
  dynamic dateCreated;
  int? openingBalance;
  String? custTaxNo;
  dynamic totalCredit;
  String? buildingNo;
  String? districtName;
  int? customerGroup;
  String? cusImg;
  int? isBusiness;
  dynamic resetToken;
  dynamic tokenDatetime;
  String? coRegNo;
  int? creditEnable;
  int? shopCustomer;
  dynamic idNumber;
  dynamic oldFileNo;
  dynamic age;
  int? job;
  dynamic eligiblity;
  dynamic insuranceCardNo;
  dynamic idCardExpiryDate;
  dynamic insuranceNoEndDate;
  dynamic policyNumber;
  dynamic insuranceClassId;
  dynamic insuranceCompanyId;
  dynamic idNoPhoto;
  dynamic cardNoPhoto;
  dynamic maritalStatus;
  dynamic nameAr;
  String? updatedAt;
  dynamic sallaCustomerId;
  int? isBlacklist;
  String? tag;
  List<int>? loyaltyOffers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sno'] = sno;
    map['cus_sub_id'] = cusSubId;
    map['ctype_id'] = ctypeId;
    map['customer_no'] = customerNo;
    map['cus_name'] = cusName;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['cus_email'] = cusEmail;
    map['password'] = password;
    map['gender'] = gender;
    map['photo'] = photo;
    map['theme'] = theme;
    map['lang'] = lang;
    map['cus_address'] = cusAddress;
    map['cus_address_l2'] = cusAddressL2;
    map['cus_shipping_address'] = cusShippingAddress;
    map['plot_no'] = plotNo;
    map['city'] = city;
    map['town'] = town;
    map['stat_pro'] = statPro;
    map['branch'] = branch;
    map['location_id'] = locationId;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['post_code'] = postCode;
    map['po_number'] = poNumber;
    map['country'] = country;
    map['dial_code'] = dialCode;
    map['mobile'] = mobile;
    map['phone'] = phone;
    map['dob'] = dob;
    map['warehouse'] = warehouse;
    map['company_name'] = companyName;
    map['job_title'] = jobTitle;
    map['department'] = department;
    map['fb_url'] = fbUrl;
    map['twit_url'] = twitUrl;
    map['insta_url'] = instaUrl;
    map['whatsapp_no'] = whatsappNo;
    map['other_social_url'] = otherSocialUrl;
    map['notes'] = notes;

    map['company_id'] = companyId;
    map['client_id'] = clientId;
    map['user_sno'] = userSno;
    map['reg_date'] = regDate;
    map['is_customer'] = isCustomer;
    map['status'] = status;
    map['date_created'] = dateCreated;
    map['opening_balance'] = openingBalance;
    map['cust_tax_no'] = custTaxNo;
    map['total_credit'] = totalCredit;
    map['building_no'] = buildingNo;
    map['district_name'] = districtName;
    map['customer_group'] = customerGroup;
    map['cus_img'] = cusImg;
    map['is_business'] = isBusiness;
    map['reset_token'] = resetToken;
    map['token_datetime'] = tokenDatetime;
    map['co_reg_no'] = coRegNo;
    map['credit_enable'] = creditEnable;
    map['shop_customer'] = shopCustomer;
    map['id_number'] = idNumber;
    map['old_file_no'] = oldFileNo;
    map['age'] = age;
    map['job'] = job;
    map['eligiblity'] = eligiblity;
    map['insurance_card_no'] = insuranceCardNo;
    map['id_card_expiry_date'] = idCardExpiryDate;
    map['insurance_no_end_date'] = insuranceNoEndDate;
    map['policy_number'] = policyNumber;
    map['insurance_class_id'] = insuranceClassId;
    map['insurance_company_id'] = insuranceCompanyId;
    map['id_no_photo'] = idNoPhoto;
    map['card_no_photo'] = cardNoPhoto;
    map['marital_status'] = maritalStatus;
    map['name_ar'] = nameAr;
    map['updated_at'] = updatedAt;
    map['salla_customer_id'] = sallaCustomerId;
    map['is_blacklist'] = isBlacklist;
    map['tag'] = tag;
    map['loyalty_offers'] = loyaltyOffers;
    return map;
  }

}