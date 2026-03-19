import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'providers/user_prefs_provider.dart';

class SysDesignFlashApp extends ConsumerWidget {
  const SysDesignFlashApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pref = ref.watch(userPrefsProvider).themeMode;
    final themeMode = switch (pref) {
      ThemeModePreference.light => ThemeMode.light,
      ThemeModePreference.dark => ThemeMode.dark,
      ThemeModePreference.system => ThemeMode.system,
    };

    return MaterialApp.router(
      title: 'SysDesign Flash',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}
