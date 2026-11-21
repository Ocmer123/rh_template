import 'package:flutter/material.dart';
import 'package:rh_template/core/config/app_env.dart';
import 'package:rh_template/core/theme/app_theme.dart';
import 'package:rh_template/features/counter/ui/counter_screen.dart';
import 'package:rh_template/l10n/app_localizations.dart';

/// Root widget: theme, localisation and the first screen.
class App extends StatelessWidget {
  const App({super.key, this.env = AppEnv.current});

  final AppEnv env;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      // Non-production builds are clearly marked so testers never confuse them.
      builder: (context, child) => env.isProd
          ? child!
          : Banner(
              message: env.name.toUpperCase(),
              location: BannerLocation.topEnd,
              child: child,
            ),
      home: const CounterScreen(),
    );
  }
}
