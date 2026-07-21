import 'Printer_model.dart';

/// file_path : "https://taqreri.com/temp/kot1900g0.pdf"
/// copies : 0
/// printer : {"sno":105,"name":"junaids place","branch_sno":0,"is_active":1,"available_printer":"any available printer","printer_type":"network","product_id":"123","vendor_id":"123","ip_address":"192.168.100.240","printer_port":"9100","is_app":1}

class PdfFilesModel {
  PdfFilesModel({
    this.filePath,
    this.copies,
    this.printer,
  });

  PdfFilesModel.fromJson(dynamic json) {
    filePath = json['link'] ?? "";
    copies = json['copies'] ?? 1;

    if (json['printer'] != null && json['printer'] is Map) {
      final rawPrinter = json['printer'] as Map;

      // Clean the JSON by keeping only string keys that are not numeric
      final cleanJson = <String, dynamic>{};
      rawPrinter.forEach((key, value) {
        if (key is String && int.tryParse(key) == null) {
          cleanJson[key] = value;
        }
      });

      printer = PrinterModel.fromJson(cleanJson);
    } else {
      printer = null;
    }
  }

  String? filePath;
  int? copies;
  PrinterModel? printer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['link'] = filePath;
    map['copies'] = copies;
    if (printer != null) {
      map['printer'] = printer?.toJson();
    }
    return map;
  }
}