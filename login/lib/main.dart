import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:login/core/utils/styles/app_theme.dart';
import 'package:login/navigation/app_router.gr.dart';
import 'core/injection_container.dart';
import 'core/utils/locales.dart';
import 'translations/codegen_loader.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  InjectionContainer.initDependencyInjection();
  runApp(const EasyLocalisationWrapper());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      routerDelegate: router.delegate(),
      routeInformationParser: router.defaultRouteParser(),
      theme: AppTheme.appTheme,
    );
  }
}

class EasyLocalisationWrapper extends StatelessWidget {
  const EasyLocalisationWrapper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      path: Locales.assetsPath,
      supportedLocales: Locales.getLocales(),
      fallbackLocale: Locales.en,
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    );
  }
}
