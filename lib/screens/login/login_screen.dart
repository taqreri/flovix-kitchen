import 'dart:ui';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flovix_kitchen/bloc/login/login_bloc.dart';
import 'package:flovix_kitchen/bloc/login/login_event.dart';
import 'package:flovix_kitchen/bloc/login/login_state.dart';
import 'package:flovix_kitchen/config/app_env.dart';
import 'package:flovix_kitchen/main.dart';
import 'package:flovix_kitchen/notification_services/notification_service.dart';
import 'package:flovix_kitchen/screens/chucker_debug_service.dart';
import 'package:flovix_kitchen/utils/app_utils.dart';
import 'package:flovix_kitchen/utils/colors/colors.dart';
import 'package:flovix_kitchen/utils/enums.dart';
import 'package:flovix_kitchen/utils/helper/divider.dart';
import 'package:flovix_kitchen/utils/images/app_images.dart';
import 'package:flovix_kitchen/utils/platform/platform_info.dart';
import 'package:flovix_kitchen/utils/routes/routes_name.dart';
import 'package:flovix_kitchen/utils/size_config.dart';
import 'package:flovix_kitchen/widgets/button_widget.dart';
import 'package:flovix_kitchen/widgets/text_form_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _pinController = TextEditingController();
  final _emailFocus = FocusNode();
  final _pinFocus = FocusNode();

  bool _isLoading = false;
  int _logoTapCount = 0;
late LoginBloc loginBloc;
  NotificationServices notiService = NotificationServices();
  @override
  void dispose() {
    _emailController.dispose();
    _pinController.dispose();
    _emailFocus.dispose();
    _pinFocus.dispose();
    loginBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loginBloc = LoginBloc(authApiRepository: getIt());
    if (PlatformInfo.isMobile) {
      notiService.requestNotificationPermission();
      notiService.firebaseInit();
      notiService.foregroundMessage();
    }
    // notiService.firebaseInitOpen(context);
    // notiService.initLocalNotificationsOnLaunch();
    // notiService.setupInteractedMessage();
    //   notiService.foregroundMessage();
    //_emailController.text = "abohamza@taqreri.com";

    //_emailController.text = AppEnv.flavor=="production"?'':"imshafi.pro@gmail.com";
    _emailController.text = AppEnv.flavor=="production"?'':"dsjswt@gmail.com";
    //  _emailController.text = "adam@taqreri.com";
    _pinController.text =AppEnv.flavor=="production"?'': "32732";
    // _passwordController.text =AppEnv.flavor=="production"?'': "89828";
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



  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => loginBloc,
      child: Scaffold(
       // backgroundColor: Colors.red,
        backgroundColor: GlobalColors.whiteColor,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                SizeConfig.width(context,0.02),
            vertical:
            SizeConfig.height(context,0.02),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildHeroPanel(context),

                    _buildLoginPanel(context),
                  ],
                )

        ),
      ),
    );
  }

  Widget _buildHeroPanel(BuildContext context) {
  //  final radius = SizeConfig.width(context, 0.01).clamp(8.0, 8.0);

    return Container(
      //color: GlobalColors.whiteColor,
      height: SizeConfig.height(context, 1),
      width: SizeConfig.width(context, 0.45),
      decoration: BoxDecoration(
        color: GlobalColors.whiteColor,
        borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.02)),),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.02)),
        child: Image.asset(
          AppImages.loginHero,
         fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
    );
  }

  Widget _buildLoginPanel(BuildContext context) {
    return Container(color: Colors.white,
      height: SizeConfig.height(context, 1),
      width: SizeConfig.width(context, 0.45),
      child: Column(
        children: [
          buildVerticalDivider(context: context,fraction: 0.08),
          Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: _onLogoTap,
              child: Image.asset(
                AppImages.logo,scale: 3.8,
              //  height: SizeConfig.height(context, 0.09).clamp(48.0, 72.0),
                fit: BoxFit.contain,
              ),
            ),
          ),
          BlocConsumer<LoginBloc,LoginState>(
              listenWhen: (current,previous)=>current.loginEnum!=previous.loginEnum,
              builder: (context,state){
            return        Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.width(context, 0.03),
                  ),
                  child: SizedBox(
                    width:  SizeConfig.width(context, 0.4),

                    child: _LoginFormCard(
                      loginState: state,
                      formKey: _formKey,
                      emailController: _emailController,
                      pinController: _pinController,
                      emailFocus: _emailFocus,
                      pinFocus: _pinFocus,
                      isLoading: state.loginEnum==LoginEnum.loading,
                      accentGreen: GlobalColors.accentGreen,
                      titleColor: GlobalColors.titleColor,
                      bodyColor: GlobalColors.bodyColor,
                      fieldBorder: GlobalColors.fieldBorder,
                      onSignIn: (){
                        loginBloc.add(LoginApi());
                      },
                    ),
                  ),
                ),
              ),
            );

          }, listener: (context,state){
            if(state.loginEnum==LoginEnum.error){
              AppUtils.showFlushBar(state.message, context);
            }
            if(state.loginEnum==LoginEnum.success){
              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.kitchenDisplayScreen,
                    (route) => false,
              );
            }


          }),

          Text(
            '© ${DateTime.now().year} ALL RIGHTS RESERVED',
            style: TextStyle(
              color: GlobalColors.rightColor,
              fontSize: SizeConfig.width(context, GlobalColors.pixel14),
              fontWeight: FontWeight.w500,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
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
    required this.loginState,
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
  final LoginState loginState;
  final bool isLoading;
  final Color accentGreen;
  final Color titleColor;
  final Color bodyColor;
  final Color fieldBorder;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: SizeConfig.height(context, 0.06),horizontal: SizeConfig.width(context, 0.02)),
      decoration: BoxDecoration(
        color: GlobalColors.whiteColor,
        borderRadius: AppUtils.borderRadius(context: context),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Welcome Back',textAlign: TextAlign.center,
              style: TextStyle(
                color: titleColor,
                fontSize: SizeConfig.width(context, GlobalColors.pixel24),
                fontWeight: FontWeight.w600,
              ),
            ),
           buildVerticalDivider(context: context,fraction: 0.008),
            Text(
              'Sign in to access your kitchen dashboard.',
              style: TextStyle(
                color: bodyColor,
                fontSize: SizeConfig.width(context,GlobalColors.pixel16),
                fontWeight: FontWeight.w400,
              ),
            ),
    buildVerticalDivider(context: context,fraction: 0.03),
            TextFormFieldWidget(
              hintText: 'Email',
              placeholder: 'Enter ID',
              controller: emailController,
              focusNode: emailFocus,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => pinFocus.requestFocus(),
                onChanged: (value) {
                  context
                      .read<LoginBloc>()
                      .add(EmailChanged(email: value??""));
                },
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email is required';
                }
                return null;
              },
            ),
            SizedBox(height: SizeConfig.height(context, 0.018)),
            TextFormFieldWidget(
              hintText: 'PIN',
              placeholder: '******',
              controller: pinController,
              focusNode: pinFocus,
              keyboardType: TextInputType.number,
              isPassword: true,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => onSignIn(),
              onChanged: (value) {
                context
                    .read<LoginBloc>()
                    .add(PasswordChanged(password: value??""));
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'PIN is required';
                }
                return null;
              },
            ),
            buildVerticalDivider(context: context,fraction: 0.03),
            ButtonWidget(
              title: 'Sign in',
              onPressed: isLoading ? null : onSignIn,
              isLoading: isLoading,
              color: accentGreen,
              width: double.infinity,
              height: SizeConfig.height(context, GlobalColors.fieldHeight),
              border: GlobalColors.borderRadius,textColor: GlobalColors.whiteColor,
              fontSize:
                  SizeConfig.height(context, GlobalColors.pixel26),
            ),
          ],
        ),
      ),
    );
  }
}
