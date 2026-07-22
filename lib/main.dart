import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flovix_kitchen/screens/chucker_debug_service.dart';
import 'package:flovix_kitchen/services/database/database_init.dart';
import 'package:flovix_kitchen/services/kitchen/kitchen_local_server.dart';
import 'package:flovix_kitchen/utils/colors/colors.dart';
import 'package:flovix_kitchen/utils/helper/helpers.dart';
import 'package:flovix_kitchen/utils/platform/platform_info.dart';
import 'package:flovix_kitchen/widgets/debug/windows_api_debug_overlay.dart';
import 'package:flovix_kitchen/widgets/receipt/thermal_printer_io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:chucker_flutter/chucker_flutter.dart';


import 'bloc/locale_cubit.dart';
import 'bloc/repository/login_repository.dart';
import 'bloc/repository/select_branch_repository.dart';
import 'config/app_env.dart';
import 'notification_services/notification_service.dart';

import 'utils/routes/routes.dart';
import 'utils/routes/routes_name.dart';
import 'utils/app_utils.dart' show rootScaffoldMessengerKey;

final repaintBoundaryKey = GlobalKey();
GetIt getIt = GetIt.instance;
ThermalPrinter thermalPrinter = ThermalPrinter();
// Add this with your global variables
bool _isGlobalInitialized = false;
late final siteConfig;
late final settingsResponse;
late final printerConfig;

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await initializeAppDatabase();
  // Reduce decoded image memory pressure (important on iOS / low-RAM iPads).
  // Debug/profile from Xcode already uses extra RAM; keep caches smaller.
  if (PlatformInfo.isMobile) {
    if (kDebugMode || kProfileMode) {
      PaintingBinding.instance.imageCache.maximumSize = 40;
      PaintingBinding.instance.imageCache.maximumSizeBytes = 16 << 20; // 16 MB
    } else {
      PaintingBinding.instance.imageCache.maximumSize = 80;
      PaintingBinding.instance.imageCache.maximumSizeBytes = 24 << 20; // 24 MB
    }
  } else {
    PaintingBinding.instance.imageCache.maximumSize = 200;
    PaintingBinding.instance.imageCache.maximumSizeBytes = 80 << 20; // 80 MB
  }
  await EasyLocalization.ensureInitialized();
  await ChuckerDebugService.initialize();
  ChuckerDebugService.applyRuntimeConfig();
  setupLocator();

  if (!kIsWeb) {
    try {
      await getIt<KitchenLocalServerService>().start(
        port: KitchenLocalServerService.defaultPort,
      );
    } catch (e, st) {
      debugPrint('Kitchen local server failed to start: $e');
      debugPrint('$st');
    }
  }

  // Get saved locale preference
  final prefs = await SharedPreferences.getInstance();
  final isEnglishLocale = prefs.getBool('isEnglish') ?? true;
  final initialLocale = isEnglishLocale ? const Locale('en') : const Locale('ar');

  // Set the global isEnglish variable based on saved preference
  isEnglish = isEnglishLocale;

  if (PlatformInfo.isMobile) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
  await ScreenUtil.ensureScreenSize();
  ScreenUtil.enableScale(enableWH: () => true, enableText: () => true);

  debugPrint('App flavor: ${AppEnv.flavor}');
  debugPrint('API base URL: ${AppEnv.apiBaseUrl}');
  debugPrint('Web base URL: ${AppEnv.webBaseUrl}');
  if (PlatformInfo.isWindows && kDebugMode) {
    debugPrint(
      'Windows debug: API calls log to this console as [API] lines. '
          'Tap the API button (bottom-right) or login logo 5× for Chucker UI.',
    );
  }

  try {
    await AppEnv.initializeFirebase();
  } catch (e, stackTrace) {
    debugPrint('Firebase initialization failed: $e');
    debugPrint('$stackTrace');
  }

  final orientations = PlatformInfo.isMobile
      ? const [
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]
      : const [
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ];

  SystemChrome.setPreferredOrientations(orientations).then((_) {
    runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        fallbackLocale: const Locale('en'),
        path: 'assets/translations',
        startLocale: initialLocale,
        child: const MyApp(),
      ),
    );

  });
  //runApp(const MyApp());
}
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (!PlatformInfo.isMobile) return;

  await AppEnv.initializeFirebase();
  NotificationServices().showNotifications(message);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didHaveMemoryPressure() {
    // Release decoded image memory aggressively when OS reports pressure.
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // On background/inactive, release live images to reduce GPU/Metal memory.
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      PaintingBinding.instance.imageCache.clearLiveImages();
    }
  }

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit()),
      ],
      child: BlocListener<LocaleCubit, Locale>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, locale) {
          // Update EasyLocalization locale when LocaleCubit state changes
          // This triggers rebuild of all widgets using .tr()
          if (context.mounted) {
            // Use addPostFrameCallback to ensure it happens after build
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                context.setLocale(locale);
              }
            });
          }
        },
        child: BlocBuilder<LocaleCubit, Locale>(
          builder: (context, locale) {
            // Sync EasyLocalization on initial build
            if (context.locale != locale && context.mounted) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  context.setLocale(locale);
                }
              });
            }

            return ScreenUtilInit(
                designSize: Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height,
                ),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (context, child) {
                  return MaterialApp(
                    scaffoldMessengerKey: rootScaffoldMessengerKey,
                    supportedLocales: context.supportedLocales,
                    localizationsDelegates: context.localizationDelegates,
                    locale: locale, // Use locale from BlocBuilder directly
                    debugShowCheckedModeBanner: false,
                    title: 'pos'.tr(),
                    themeMode: ThemeMode.light,
                    navigatorObservers: [
                      if (ChuckerDebugService.shouldRegisterNavigatorObserver)
                        ChuckerFlutter.navigatorObserver,
                    ],
                    theme: ThemeData(

                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(

                          foregroundColor: GlobalColors.primaryColor, // text color

                        ),
                      ),

                      textSelectionTheme: TextSelectionThemeData(
                        cursorColor: GlobalColors.primaryColor,        // 👈 cursor color
                        selectionColor: GlobalColors.primaryColor,
                        selectionHandleColor: GlobalColors.primaryColor,
                      ),

                      dropdownMenuTheme: DropdownMenuThemeData(
                        textStyle:  TextStyle(
                          fontSize:10,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          letterSpacing: 0.2,

                        ),

                        menuStyle: MenuStyle(
                          elevation: WidgetStateProperty.all(6),
                          backgroundColor: WidgetStateProperty.all(Colors.white),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        inputDecorationTheme: InputDecorationTheme(
                          isDense: true,

                          /// 🔹 Hint text
                          hintStyle: const TextStyle(
                            fontSize:10,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),

                          /// 🔹 Selected value text
                          labelStyle:  TextStyle(
                            fontSize:Helpers.isTablet()? null:12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),

                          /// 🔹 Floating label (if used)
                          floatingLabelStyle:  TextStyle(
                            fontSize: Helpers.isTablet()? null:12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 1.5,
                            ),
                          ),

                          errorStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                        ),
                      ),

                      checkboxTheme: CheckboxThemeData(
                        fillColor: MaterialStateProperty.resolveWith(
                              (states) {
                            if (states.contains(MaterialState.selected)) {
                              return GlobalColors.primaryColor;
                            }
                            return Colors.transparent;
                          },
                        ),
                        checkColor: MaterialStateProperty.all(Colors.white),
                        side: const BorderSide(
                          color: Color(0xffC7C7C7),
                          width: 1.5,
                        ),
                        overlayColor: MaterialStateProperty.all(
                          GlobalColors.primaryColor.withOpacity(0.12),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),

                      progressIndicatorTheme: const ProgressIndicatorThemeData(
                        color: GlobalColors.primaryColor,      // sets the progress color
                        linearTrackColor: Color(0xffECEAEA), // optional for LinearProgressIndicator
                        circularTrackColor: Color(0xffECEAEA), // optional track color for circular
                        strokeWidth: 4.0,                    // default thickness
                      ),

                      floatingActionButtonTheme: FloatingActionButtonThemeData(
                        backgroundColor: GlobalColors.primaryColor,
                        foregroundColor: Colors.white, // icon/text color
                        elevation: 6.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), // rounded edges
                        ),
                        extendedSizeConstraints: const BoxConstraints(
                          minWidth: 120,
                          minHeight: 50,
                        ),
                      ),
                      fontFamily: 'Inter',
                    ),
                    //  theme: lightTheme,
                    //  darkTheme: darkTheme,
                    /*    localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: AppLocalizations.supportedLocales,
                  locale: locale,**/
                    builder: (context, appChild) {
                      return WindowsApiDebugOverlay(
                        child: appChild ?? const SizedBox.shrink(),
                      );
                    },
                    initialRoute: RoutesName.splashScreen,
                    onGenerateRoute: Routes.generateRoute,
                  );
                },
            );
          },
        ),
      ),
    );
  }
}

bool isEnglish = true;
void setupLocator() {
  if (!getIt.isRegistered<LoginRepository>()) {
    getIt.registerSingleton<LoginRepository>(LoginRepository());
  }
  if (!getIt.isRegistered<SelectBranchRepository>()) {
    getIt.registerSingleton<SelectBranchRepository>(SelectBranchRepository());
  }
  if (!getIt.isRegistered<KitchenLocalServerService>()) {
    getIt.registerSingleton<KitchenLocalServerService>(
      KitchenLocalServerService(),
    );
  }
}
int? transactionTotalPagesCount=1;
int? productTotalPagesCount=1;