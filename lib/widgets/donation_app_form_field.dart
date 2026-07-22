import 'package:flovix_kitchen/utils/colors/colors.dart';
import 'package:flovix_kitchen/utils/images/app_images.dart';
import 'package:flovix_kitchen/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DonationAppFormField extends StatefulWidget {
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

  DonationAppFormField({
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
  State<DonationAppFormField> createState() => _DonationAppFormFieldState();
}

class _DonationAppFormFieldState extends State<DonationAppFormField> {
  static const Color _labelColor = Color(0xFF6B7280);
  static const Color _textColor = Color(0xFF111827);
  static const Color _hintColor = Color(0xFF9CA3AF);
  static const Color _borderColor = Color(0xFFE5E7EB);
  static const Color _focusBorderColor = Color(0xFF2F8F3A);

  late bool _secureText;

  @override
  void initState() {
    super.initState();
    _secureText = widget.obscureText ?? widget.isPassword;
  }

  @override
  void didUpdateWidget(covariant DonationAppFormField oldWidget) {
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
              color: _labelColor,
              fontSize: labelSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: SizeConfig.height(context, 0.008)),
          TextFormField<String>(
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
            cursorColor: _focusBorderColor,
            style: TextStyle(
              fontSize: fieldFontSize,
              fontWeight: FontWeight.w500,
              color: _textColor,
            ),
            decoration: InputDecoration(
              hintText: widget.placeholder ?? widget.hintText,
              hintStyle: TextStyle(
                color: _hintColor,
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
                        color: _labelColor,
                      ),
                    )
                  : null,
              contentPadding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width(context, 0.015).clamp(12.0, 16.0),
                vertical: SizeConfig.height(context, 0.016).clamp(12.0, 16.0),
              ),
              filled: true,
              fillColor: AppColors.whiteColor,
              counterText: '',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(fieldRadius),
                borderSide: const BorderSide(color: _borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(fieldRadius),
                borderSide:
                    const BorderSide(color: _focusBorderColor, width: 1.4),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(fieldRadius),
                borderSide: BorderSide(
                  color: _borderColor.withValues(alpha: 0.7),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(fieldRadius),
                borderSide: const BorderSide(color: AppColors.redColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(fieldRadius),
                borderSide:
                    const BorderSide(color: AppColors.redColor, width: 1.4),
              ),
              errorStyle: TextStyle(
                color: AppColors.redColor,
                fontSize: SizeConfig.height(context, 0.013).clamp(11.0, 12.0),
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
        ],
      ),
    );
  }
}
