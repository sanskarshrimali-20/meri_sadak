import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meri_sadak/providerData/image_picker_provider.dart';
import 'package:meri_sadak/providerData/permission_provider.dart';
import 'package:meri_sadak/providerData/theme_provider.dart';
import 'package:meri_sadak/screens/splash/splash_screen.dart';
import 'package:meri_sadak/utils/fontsize_provider.dart';
import 'package:meri_sadak/utils/localization_provider.dart';
import 'package:meri_sadak/utils/network_provider.dart';
import 'package:meri_sadak/viewmodels/forgotChangePassword/forgot_change_password_viewmodel.dart';
import 'package:meri_sadak/viewmodels/login/login_view_model.dart';
import 'package:meri_sadak/viewmodels/signup/sign_up_viewmodel.dart';
import 'package:meri_sadak/viewmodels/xmlData/xml_master_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'constants/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localizationProvider = LocalizationProvider();
  await localizationProvider.initLocale();

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  final fontSizeProvider = FontSizeProvider();
  await fontSizeProvider.loadFontSize();

  runApp(MyApp(localizationProvider: localizationProvider, themeProvider:themeProvider, fontSizeProvider: fontSizeProvider,));
}

class MyApp extends StatefulWidget {

  final LocalizationProvider localizationProvider;
  final ThemeProvider themeProvider;
  final FontSizeProvider fontSizeProvider;

  const MyApp({Key? key, required this.localizationProvider, required this.themeProvider, required this.fontSizeProvider});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final _storage = const FlutterSecureStorage(); // Secure storage instance

  bool isDarkMode = false; // Default theme mode

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => XmlMasterDataViewModel()),
        ChangeNotifierProvider(create: (_) => ForgotChangePasswordViewModel()),
        ChangeNotifierProvider(create: (_) => widget.localizationProvider),
        ChangeNotifierProvider(create: (_) => PermissionProvider()),
        ChangeNotifierProvider(create: (_) => ImagePickerProvider()),
        ChangeNotifierProvider(create: (_) => widget.themeProvider),
        ChangeNotifierProvider(create: (_) => NetworkProviderController()),
        ChangeNotifierProvider(create: (_) => widget.fontSizeProvider),
      ],
      child: Consumer2<LocalizationProvider, ThemeProvider>(
        builder: (context, languageProvider, themeProvider, child) {

          return MaterialApp(
            title: 'Meri Sadak',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeProvider.themeMode, // Set the current theme mode
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            locale: languageProvider.locale,
            supportedLocales: [
              Locale('en'), // English
              Locale('hi'), // Hindi
            ],
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}


