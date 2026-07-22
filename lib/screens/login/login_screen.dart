import 'dart:ui';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flovix_kitchen/screens/chucker_debug_service.dart';
import 'package:flovix_kitchen/utils/app_utils.dart';
import 'package:flovix_kitchen/utils/colors/colors.dart';
import 'package:flovix_kitchen/utils/images/app_images.dart';
import 'package:flovix_kitchen/utils/size_config.dart';
import 'package:flovix_kitchen/widgets/donation_app_form_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const Color _accentGreen = Color(0xFF2F8F3A);
  static const Color _titleColor = Color(0xFF1A1A1A);
  static const Color _bodyColor = Color(0xFF6B7280);
  static const Color _fieldBorder = Color(0xFFE5E7EB);
  static const Color _pageBg = Color(0xFFF5F6F8);

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _pinController = TextEditingController();
  final _emailFocus = FocusNode();
  final _pinFocus = FocusNode();

  bool _isLoading = false;
  int _logoTapCount = 0;

  @override
  void dispose() {
    _emailController.dispose();
    _pinController.dispose();
    _emailFocus.dispose();
    _pinFocus.dispose();
    super.dispose();
  }

  Future<void> _onLogoTap() async {
    if (!ChuckerDebugService.isAllowedFlavor) return;

    _logoTapCount++;
    if (_logoTapCount < ChuckerDebugService.secretTapCount) return;

    _logoTapCount = 0;
    await ChuckerDebugService.enableFromSecretGesture();
    if (!mounted) return;

    AppUtils.showFlushBar('API inspector enabled', context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) ChuckerFlutter.showChuckerScreen();
    });
  }

  Future<void> _onSignIn() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);
    // Auth wiring can be connected to LoginRepository here.
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 900;

    return Scaffold(
      backgroundColor: _pageBg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                SizeConfig.horizontalPadding(context: context, widthPad: 0.02),
            vertical:
                SizeConfig.verticalPadding(context: context, heightPad: 0.025),
          ),
          child: isWide
              ? Row(
                  children: [
                    Expanded(flex: 11, child: _buildHeroPanel(context)),
                    SizedBox(width: SizeConfig.width(context, 0.02)),
                    Expanded(flex: 9, child: _buildLoginPanel(context)),
                  ],
                )
              : Column(
                  children: [
                    Expanded(flex: 5, child: _buildHeroPanel(context)),
                    SizedBox(height: SizeConfig.height(context, 0.02)),
                    Expanded(flex: 6, child: _buildLoginPanel(context)),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildHeroPanel(BuildContext context) {
    final radius = SizeConfig.width(context, 0.018).clamp(16.0, 28.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppImages.loginHero,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.05),
                  Colors.black.withValues(alpha: 0.35),
                ],
              ),
            ),
          ),
          Positioned(
            left: SizeConfig.width(context, 0.025),
            right: SizeConfig.width(context, 0.12),
            bottom: SizeConfig.height(context, 0.04),
            child: _HeroInfoCard(
              accentGreen: _accentGreen,
              titleColor: _titleColor,
              bodyColor: _bodyColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginPanel(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: GestureDetector(
            onTap: _onLogoTap,
            child: Image.asset(
              AppImages.logo,
              height: SizeConfig.height(context, 0.09).clamp(48.0, 72.0),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width(context, 0.03),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: SizeConfig.width(context, 0.34).clamp(320.0, 460.0),
                ),
                child: _LoginFormCard(
                  formKey: _formKey,
                  emailController: _emailController,
                  pinController: _pinController,
                  emailFocus: _emailFocus,
                  pinFocus: _pinFocus,
                  isLoading: _isLoading,
                  accentGreen: _accentGreen,
                  titleColor: _titleColor,
                  bodyColor: _bodyColor,
                  fieldBorder: _fieldBorder,
                  onSignIn: _onSignIn,
                ),
              ),
            ),
          ),
        ),
        Text(
          '© ${DateTime.now().year} ALL RIGHTS RESERVED',
          style: TextStyle(
            color: _bodyColor.withValues(alpha: 0.75),
            fontSize: SizeConfig.height(context, 0.014).clamp(10.0, 12.0),
            fontWeight: FontWeight.w500,
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }
}

class _HeroInfoCard extends StatelessWidget {
  const _HeroInfoCard({
    required this.accentGreen,
    required this.titleColor,
    required this.bodyColor,
  });

  final Color accentGreen;
  final Color titleColor;
  final Color bodyColor;

  @override
  Widget build(BuildContext context) {
    final radius = SizeConfig.width(context, 0.016).clamp(16.0, 24.0);
    final padH = SizeConfig.width(context, 0.02).clamp(18.0, 28.0);
    final padV = SizeConfig.height(context, 0.028).clamp(18.0, 28.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.82),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: Colors.white.withValues(alpha: 0.55)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Kitchen Display System',
                style: TextStyle(
                  color: titleColor,
                  fontSize: SizeConfig.height(context, 0.034).clamp(22.0, 34.0),
                  fontWeight: FontWeight.w700,
                  height: 1.15,
                ),
              ),
              SizedBox(height: SizeConfig.height(context, 0.012)),
              Text(
                'Manage kitchen orders faster, reduce delays, and improve service efficiency.',
                style: TextStyle(
                  color: bodyColor,
                  fontSize: SizeConfig.height(context, 0.018).clamp(13.0, 16.0),
                  fontWeight: FontWeight.w400,
                  height: 1.45,
                ),
              ),
              SizedBox(height: SizeConfig.height(context, 0.022)),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: _StatItem(
                        value: '15%',
                        label: 'Faster Prep',
                        accentGreen: accentGreen,
                        bodyColor: bodyColor,
                      ),
                    ),
                    Container(
                      width: 1,
                      margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.width(context, 0.018),
                      ),
                      color: const Color(0xFFD1D5DB),
                    ),
                    Expanded(
                      child: _StatItem(
                        value: 'Zero',
                        label: 'Missed Orders',
                        accentGreen: accentGreen,
                        bodyColor: bodyColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.label,
    required this.accentGreen,
    required this.bodyColor,
  });

  final String value;
  final String label;
  final Color accentGreen;
  final Color bodyColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            color: accentGreen,
            fontSize: SizeConfig.height(context, 0.028).clamp(18.0, 26.0),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: SizeConfig.height(context, 0.004)),
        Text(
          label,
          style: TextStyle(
            color: bodyColor,
            fontSize: SizeConfig.height(context, 0.015).clamp(11.0, 13.0),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _LoginFormCard extends StatelessWidget {
  const _LoginFormCard({
    required this.formKey,
    required this.emailController,
    required this.pinController,
    required this.emailFocus,
    required this.pinFocus,
    required this.isLoading,
    required this.accentGreen,
    required this.titleColor,
    required this.bodyColor,
    required this.fieldBorder,
    required this.onSignIn,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController pinController;
  final FocusNode emailFocus;
  final FocusNode pinFocus;
  final bool isLoading;
  final Color accentGreen;
  final Color titleColor;
  final Color bodyColor;
  final Color fieldBorder;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    final radius = SizeConfig.width(context, 0.012).clamp(12.0, 18.0);
    final pad = SizeConfig.width(context, 0.025).clamp(20.0, 32.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(pad),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: fieldBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Welcome Back',
              style: TextStyle(
                color: titleColor,
                fontSize: SizeConfig.height(context, 0.032).clamp(22.0, 30.0),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: SizeConfig.height(context, 0.008)),
            Text(
              'Sign in to access your kitchen dashboard.',
              style: TextStyle(
                color: bodyColor,
                fontSize: SizeConfig.height(context, 0.016).clamp(12.0, 14.0),
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: SizeConfig.height(context, 0.028)),
            DonationAppFormField(
              hintText: 'Email',
              placeholder: 'Enter ID',
              controller: emailController,
              focusNode: emailFocus,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => pinFocus.requestFocus(),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email is required';
                }
                return null;
              },
            ),
            SizedBox(height: SizeConfig.height(context, 0.018)),
            DonationAppFormField(
              hintText: 'PIN',
              placeholder: '******',
              controller: pinController,
              focusNode: pinFocus,
              keyboardType: TextInputType.number,
              isPassword: true,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => onSignIn(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'PIN is required';
                }
                return null;
              },
            ),
            SizedBox(height: SizeConfig.height(context, 0.028)),
            SizedBox(
              width: double.infinity,
              height: SizeConfig.height(context, 0.058).clamp(44.0, 52.0),
              child: ElevatedButton(
                onPressed: isLoading ? null : onSignIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentGreen,
                  disabledBackgroundColor: accentGreen.withValues(alpha: 0.6),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: isLoading
                    ? SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          color: Colors.white.withValues(alpha: 0.95),
                        ),
                      )
                    : Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: SizeConfig.height(context, 0.018)
                              .clamp(14.0, 16.0),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
