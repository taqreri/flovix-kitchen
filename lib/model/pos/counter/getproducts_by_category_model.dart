// category_model.dart
class GetProductByCateGoryModel {
  final bool success;
  final String message;
  final String redirect;
  final List<CategoryData> data;
  final Pagination pagination;

  GetProductByCateGoryModel({
    required this.success,
    required this.message,
    required this.redirect,
    required this.data,
    required this.pagination,
  });

  factory GetProductByCateGoryModel.fromJson(Map<String, dynamic> json) {
    return GetProductByCateGoryModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      redirect: json['redirect'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => CategoryData.fromJson(item))
          .toList() ?? [],
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'redirect': redirect,
      'data': data.map((item) => item.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }
}

class CategoryData {
  final int catId;
  final String catLabel;
  final String catLabelAr;
  final String catImageLink;
  final dynamic pCatId;
  final bool isDefault;
  final dynamic pBranchId;

  CategoryData({
    required this.catId,
    required this.catLabel,
    required this.catLabelAr,
    required this.catImageLink,
    this.pCatId,
    required this.isDefault,
    this.pBranchId,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      catId: json['cat_id'] ?? 0,
      catLabel: json['cat_label'] ?? '',
      catLabelAr: json['cat_label_ar'] ?? '',
      catImageLink: json['cat_image_link'] ?? '',
      pCatId: json['p_cat_id'],
      isDefault: json['is_default'] ?? false,
      pBranchId: json['p_branch_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cat_id': catId,
      'cat_label': catLabel,
      'cat_label_ar': catLabelAr,
      'cat_image_link': catImageLink,
      'p_cat_id': pCatId,
      'is_default': isDefault,
      'p_branch_id': pBranchId,
    };
  }
}

class Pagination {
  final int currentPage;
  final String firstPageUrl;
  final int from;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;
  final int lastPage;

  Pagination({
    required this.currentPage,
    required this.firstPageUrl,
    required this.from,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
    required this.lastPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'] ?? 0,
      firstPageUrl: json['first_page_url'] ?? '',
      from: json['from'] ?? 0,
      nextPageUrl: json['next_page_url'],
      path: json['path'] ?? '',
      perPage: json['per_page'] ?? 0,
      prevPageUrl: json['prev_page_url'],
      to: json['to'] ?? 0,
      total: json['total'] ?? 0,
      lastPage: json['last_page'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'first_page_url': firstPageUrl,
      'from': from,
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'total': total,
      'last_page': lastPage,
    };
  }
}