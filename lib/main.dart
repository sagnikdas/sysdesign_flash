import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Open persistence boxes
  await Future.wait([
    Hive.openBox<bool>('mastered'),
    Hive.openBox<bool>('bookmarks'),
    Hive.openBox('profile'),
    Hive.openBox('settings'),
  ]);

  runApp(
    const ProviderScope(
      child: SysDesignFlashApp(),
    ),
  );
}
