
import 'package:flovix_kitchen/model/pos/cart/product_model/Default_batch.dart';
import 'package:flovix_kitchen/model/pos/cart/product_model/Uom_model.dart';
import 'package:flovix_kitchen/model/pos/cart/product_model/product_model.dart';

import '../model/pos/cart/cart_local_model/cart_local_model.dart' show CartLocalModel;

int parseProductInt(dynamic value, {int fallback = 0}) {
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value.trim()) ?? fallback;
  return fallback;
}

double parseUomValue(dynamic value, {double fallback = 1.0}) {
  if (value is int) return value.toDouble();
  if (value is double) return value;
  if (value is String) return double.tryParse(value.trim()) ?? fallback;
  return fallback;
}

bool isBatchTrackedPType(int? pType) => pType == 2 || pType == 3;

bool isBatchTrackedProduct(ProductModel? product) {
  if (product == null) return false;
  if (isBatchTrackedPType(product.pType)) return true;
  return product.defaultBatchList?.isNotEmpty ?? false;
}

bool isBatchTrackedCartItem(CartLocalModel? item) {
  if (item == null) return false;
  return isBatchTrackedPType(item.pType);
}

UomModel? findUomInList(List<UomModel>? uomList, int? uomId) {
  if (uomList == null || uomList.isEmpty || uomId == null || uomId == 0) {
    return null;
  }
  for (final uom in uomList) {
    if (parseProductInt(uom.uomId) == uomId) {
      return uom;
    }
  }
  return null;
}

double saleUomValueForProduct(ProductModel? product) {
  if (product == null) return 1.0;
  final unitSale = product.unitSale;
  if (unitSale == null || unitSale == 0) return 1.0;
  final saleUom = findUomInList(product.uomList, unitSale);
  return saleUom == null ? 1.0 : parseUomValue(saleUom.uomValue);
}

/// Converts raw batch stock into sellable quantity for [unit_sale].
int adjustBatchStockForUom(ProductModel? product, int rawBatchStock) {
  if (product == null || rawBatchStock <= 0) return rawBatchStock;

  final unitId = product.unitId;
  final unitSale = product.unitSale;
  final uomList = product.uomList;

  if (unitId == null ||
      unitSale == null ||
      unitId == 0 ||
      unitSale == 0 ||
      uomList == null ||
      uomList.isEmpty) {
    return rawBatchStock;
  }

  if (unitId == unitSale) {
    return rawBatchStock;
  }

  final unitIdUom = findUomInList(uomList, unitId);
  final unitSaleUom = findUomInList(uomList, unitSale);
  if (unitIdUom == null || unitSaleUom == null) {
    return rawBatchStock;
  }

  final unitIdUomValue = parseUomValue(unitIdUom.uomValue);
  final saleUomValue = parseUomValue(unitSaleUom.uomValue);
  if (saleUomValue <= 0) return rawBatchStock;

  final double effective;
  if (unitIdUomValue < saleUomValue) {
    effective = rawBatchStock / saleUomValue;
  } else {
    effective = rawBatchStock * unitIdUomValue / saleUomValue;
  }

  if (effective.isNaN || effective.isInfinite || effective <= 0) {
    return 0;
  }
  return effective.floor();
}

int rawBatchStockFromProduct(ProductModel? product) {
  if (product == null) return 0;
  final batches = product.defaultBatchList;
  if (batches != null && batches.isNotEmpty) {
    return parseProductInt(batches.first.stock);
  }
  return parseProductInt(product.stock);
}

int batchStockFromProduct(ProductModel? product) {
  if (product == null) return 0;
  if (!isBatchTrackedProduct(product)) {
    return parseProductInt(product.stock);
  }

  final rawStock = rawBatchStockFromProduct(product);
  return adjustBatchStockForUom(product, rawStock);
}

/// Converts sellable stock ([unit_sale] basis) into the cart line's UOM.
int availableStockForCartUom({
  required ProductModel? product,
  required int stockInSaleUnit,
  dynamic cartUomValue,
}) {
  if (stockInSaleUnit <= 0) return 0;
  if (product == null) return stockInSaleUnit;

  final itemUomValue = parseUomValue(cartUomValue);
  final saleUomValue = saleUomValueForProduct(product);
  if (itemUomValue <= 0 || saleUomValue <= 0 || itemUomValue == saleUomValue) {
    return stockInSaleUnit;
  }

  final converted = stockInSaleUnit * saleUomValue / itemUomValue;
  if (converted.isNaN || converted.isInfinite || converted <= 0) {
    return 0;
  }
  return converted.floor();
}

List<DefaultBatch>? parseDefaultBatchList(dynamic raw) {
  if (raw == null) return null;
  final list = <DefaultBatch>[];
  if (raw is List) {
    for (final entry in raw) {
      if (entry is Map) {
        list.add(DefaultBatch.fromJson(entry));
      }
    }
  } else if (raw is Map) {
    list.add(DefaultBatch.fromJson(raw));
  }
  return list.isEmpty ? null : list;
}
