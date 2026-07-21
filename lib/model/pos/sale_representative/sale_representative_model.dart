/// id : 17
/// name : null
/// short_name : "WK"
/// rep_type : 2
/// com_amount : "ssss"
/// com_type : "Delivery"
/// rep_status : "Active"

class SaleRepresentativeModel {
  SaleRepresentativeModel({
      this.id, 
      this.name, 
      this.shortName, 
     // this.repType,
      this.comAmount, 
      this.comType, 
      this.repStatus,});

  SaleRepresentativeModel.fromJson(dynamic json) {
    id = json['sno']??json['id'];
    name = json['name']??"";
    shortName = json['short_name'];
   // repType = json['rep_type'];
  //  comAmount = json['com_amount'];
   // comType = json['com_type'];
   // repStatus = json['rep_status'];
  }
  int? id;
  dynamic name;
  String? shortName;
//  int? repType;
  String? comAmount;
  String? comType;
  String? repStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['short_name'] = shortName;
    //map['rep_type'] = repType;
    map['com_amount'] = comAmount;
    map['com_type'] = comType;
    map['rep_status'] = repStatus;
    return map;
  }

}