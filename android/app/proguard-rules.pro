-keep class io.flutter.plugins.GeneratedPluginRegistrant { *; }

# Hive adapters and generated type adapters.
-keep class * extends io.hive.flutter.HiveFlutterPlugin { *; }
-keep class * extends io.hive.HiveObject { *; }
-keep class **Adapter { *; }

# In-app purchase plugin classes.
-keep class io.flutter.plugins.inapppurchase.** { *; }
-keep class com.android.billingclient.api.** { *; }
