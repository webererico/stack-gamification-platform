import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stack_gamification_platform/core/navigation/app_router.dart';
import 'package:stack_gamification_platform/core/theme/theme.dart';
import 'package:stack_gamification_platform/core/variables/variables.dart';
import 'package:stack_gamification_platform/features/alert/presentation/alert_area.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

class StackUpApp extends StatelessWidget {
  const StackUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: kDebugMode,
      scaffoldMessengerKey: snackbarKey,
      locale: const Locale('pt', 'BR'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      routerConfig: router,
      title: Variables.appTitle,
      theme: theme,
      builder: (context, child) {
        return Stack(children: [?child, const AlertArea()]);
      },
    );
  }
}
