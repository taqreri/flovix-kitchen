import 'package:flovix_kitchen/utils/colors/colors.dart';
import 'package:flovix_kitchen/utils/images/app_images.dart';
import 'package:flovix_kitchen/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String hintText;
  final String? placeholder;
  final double? width;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? hintTextInSingleLine;
  final bool? obscureText;
  final bool isPassword;
  final bool? enabled;
  final int? maxLength;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final AutovalidateMode autovalidateMode;
  final String? Function(String?)? validator;

  TextFormFieldWidget({
    super.key,
    this.hintTextInSingleLine = false,
    required this.hintText,
    this.placeholder,
    this.width,
    required this.keyboardType,
    this.controller,
    this.focusNode,
    this.maxLines,
    this.maxLength,
    this.validator,
    this.enabled,
    this.obscureText,
    this.isPassword = false,
    this.inputFormatters,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {


  late bool _secureText;

  @override
  void initState() {
    super.initState();
    _secureText = widget.obscureText ?? widget.isPassword;
  }

  @override
  void didUpdateWidget(covariant TextFormFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.obscureText != null &&
        widget.obscureText != oldWidget.obscureText) {
      _secureText = widget.obscureText!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final fieldRadius = 10.0;
    final labelSize = SizeConfig.height(context, 0.015).clamp(12.0, 13.0);
    final fieldFontSize = SizeConfig.height(context, 0.017).clamp(13.0, 15.0);

    return SizedBox(
      width: widget.width ?? double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.hintText,
            maxLines: widget.hintTextInSingleLine == true ? 1 : null,
            overflow:
                widget.hintTextInSingleLine == true ? TextOverflow.ellipsis : null,
            style: TextStyle(
              color: GlobalColors.labelColor,
              fontSize: labelSize,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: SizeConfig.height(context, 0.008)),
          Container(height: SizeConfig.height(context,GlobalColors.fieldHeight),
            child: Center(
              child: TextFormField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                autovalidateMode: widget.autovalidateMode,
                keyboardType: widget.keyboardType,
                enabled: widget.enabled,
                textInputAction: widget.textInputAction ?? TextInputAction.next,
                textCapitalization: widget.keyboardType == TextInputType.name
                    ? TextCapitalization.words
                    : TextCapitalization.none,
                validator: widget.validator,
                obscureText: widget.isPassword || (widget.obscureText ?? false)
                    ? _secureText
                    : false,
                maxLength: widget.maxLength,
                maxLines: widget.maxLines ?? 1,
                cursorColor:GlobalColors.focusBorderColor,
                style: TextStyle(
                  fontSize: fieldFontSize,
                  fontWeight: FontWeight.w500,
                  color: GlobalColors.textColor,
                ),
                decoration: InputDecoration(
                  hintText: widget.placeholder ?? widget.hintText,
                  hintStyle: TextStyle(
                    color: GlobalColors.hintColor,
                    fontSize: fieldFontSize,
                    fontWeight: FontWeight.w400,
                  ),
                  suffixIcon: widget.isPassword
                      ? IconButton(
                          onPressed: () {
                            setState(() => _secureText = !_secureText);
                          },
                          splashRadius: 18,
                          icon: Image.asset(
                            AppImages.eye,
                            width: SizeConfig.height(context, 0.022).clamp(16.0, 20.0),
                            height:
                                SizeConfig.height(context, 0.022).clamp(16.0, 20.0),
                            color: GlobalColors.labelColor,
                          ),
                        )
                      : null,
                 isDense: true,
                 /* contentPadding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.width(context, 0.015).clamp(12.0, 16.0),
                    vertical: SizeConfig.height(context, 0.016).clamp(12.0, 16.0),
                  ),*/
                  filled: true,
                  fillColor: GlobalColors.whiteColor,
                  counterText: '',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.01)),
                    borderSide: const BorderSide(color:GlobalColors.borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.01)),  borderSide:
                        const BorderSide(color: GlobalColors.focusBorderColor, width: 1.4),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.01)), borderSide: BorderSide(
                      color:GlobalColors.borderColor.withValues(alpha: 0.7),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.01)),   borderSide: const BorderSide(color: GlobalColors.redColor),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.01)), borderSide:
                        const BorderSide(color: GlobalColors.redColor, width: 1.4),
                  ),
                  errorStyle: TextStyle(
                    color: GlobalColors.redColor,
                    fontSize: SizeConfig.width(context, 0.01),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onChanged: widget.onChanged,
                onFieldSubmitted: widget.onFieldSubmitted,
                inputFormatters: widget.inputFormatters ??
                    ((widget.keyboardType == TextInputType.phone ||
                            widget.keyboardType == TextInputType.number)
                        ? [
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.allow(RegExp(r'\d')),
                          ]
                        : null),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
