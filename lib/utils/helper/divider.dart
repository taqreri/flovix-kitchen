import 'package:flovix_kitchen/utils/size_config.dart';
import 'package:flutter/material.dart';


SizedBox buildVerticalDivider({required BuildContext context, double? fraction}) =>
    SizedBox(height: SizeConfig.height(context, fraction??0.02));

SizedBox buildHorizontalDivider({required BuildContext context, double? fraction}) {
  return SizedBox(width: SizeConfig.width(context, fraction ?? 0.02));
}
