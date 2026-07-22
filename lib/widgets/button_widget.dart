import 'package:flovix_kitchen/utils/app_utils.dart';
import 'package:flovix_kitchen/utils/colors/colors.dart';
import 'package:flovix_kitchen/utils/helper/helpers.dart';
import 'package:flovix_kitchen/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  final double? fontSize;
  final double? border;
  final Color borderColors;
  final bool isIcon;
  final Color? color;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool isLoading;

  const ButtonWidget({
    super.key,
    required this.title,
    required this.onPressed,
    this.height,
    this.isIcon = false,
    this.fontSize,
    this.width,
    this.margin,
    this.borderColors = Colors.transparent,
    this.textColor = GlobalColors.whiteColor,
    this.padding,
    this.border = 10.0,
    this.color,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = Helpers.isTablet();
    final isDisabled = onPressed == null || isLoading;

    return InkWell(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        height: height,
        width: width,
        margin: margin ?? EdgeInsets.zero,
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: SizeConfig.height(context, isTablet ? 0.01 : 0.007),
              horizontal: SizeConfig.width(context, isTablet ? 0.02 : 0.006),
            ),
        decoration: BoxDecoration(
          color: (color ?? GlobalColors.primaryColor)
             ,
          border: Border.all(color: borderColors),
          borderRadius:AppUtils.borderRadius(context: context,radius: 0.01),
        ),
        child: isLoading
            ? Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    color: (textColor ?? GlobalColors.whiteColor)
                        .withValues(alpha: 0.95),
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: isIcon
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.center,
                children: [
                  if (isIcon)
                    const Icon(Icons.check_circle, color: Colors.white),
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: fontSize ?? SizeConfig.width(context, 0.015),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
