import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/mastered_provider.dart';
import '../../providers/bookmarks_provider.dart';
import '../../providers/streak_provider.dart';
import '../../providers/user_prefs_provider.dart';
import '../../providers/subscription_provider.dart';
import '../../providers/auth_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final userPrefs = ref.watch(userPrefsProvider);
    final authState = ref.watch(authControllerProvider);
    final displayLabel = userPrefs.displayName.trim().isEmpty
        ? 'Not set'
        : userPrefs.displayName.trim();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Display name'),
            subtitle: Text(displayLabel),
          ),
          ListTile(
            leading: const Icon(Icons.cloud_sync_outlined),
            title: const Text('Account & Cloud Sync'),
            subtitle: Text(
              authState.user?.email ??
                  (authState.isConfigured
                      ? 'Not signed in'
                      : 'Cloud sync not configured in this build'),
            ),
            onTap: () => context.push('/auth'),
          ),
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: const Text('Theme'),
            subtitle: Text(switch (userPrefs.themeMode) {
              ThemeModePreference.light => 'Light',
              ThemeModePreference.dark => 'Dark',
              ThemeModePreference.system => 'System',
            }),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: SegmentedButton<ThemeModePreference>(
              selected: {userPrefs.themeMode},
              onSelectionChanged: (selection) {
                ref
                    .read(userPrefsProvider.notifier)
                    .setThemeMode(selection.first);
              },
              segments: const [
                ButtonSegment(
                  value: ThemeModePreference.light,
                  label: Text('Light'),
                  icon: Icon(Icons.light_mode_outlined),
                ),
                ButtonSegment(
                  value: ThemeModePreference.dark,
                  label: Text('Dark'),
                  icon: Icon(Icons.dark_mode_outlined),
                ),
                ButtonSegment(
                  value: ThemeModePreference.system,
                  label: Text('System'),
                  icon: Icon(Icons.brightness_auto_outlined),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.flag_outlined),
            title: const Text('Daily Goal'),
            subtitle: Text('${userPrefs.dailyGoal} cards / day'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.notifications_none_outlined),
            title: const Text('Notification settings'),
            subtitle: const Text('Pro reminder controls (coming soon)'),
            onTap: () {},
          ),
          if (kDebugMode)
            SwitchListTile(
              secondary: const Icon(Icons.workspace_premium_outlined),
              title: const Text('Debug: Toggle Pro'),
              value: ref.watch(subscriptionProvider) == SubscriptionTier.pro,
              onChanged: (value) async {
                if (value) {
                  ref
                      .read(subscriptionProvider.notifier)
                      .setTier(SubscriptionTier.pro);
                  return;
                }
                await ref
                    .read(subscriptionProvider.notifier)
                    .clearDebugOverride();
              },
            ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.restore),
            title: const Text('Restore Purchase'),
            onTap: () async {
              final messenger = ScaffoldMessenger.of(context);
              try {
                final tier = await ref
                    .read(subscriptionProvider.notifier)
                    .restorePurchases();
                if (!context.mounted) return;
                messenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      tier == SubscriptionTier.pro
                          ? 'Pro subscription restored.'
                          : 'No active Pro purchase found.',
                    ),
                  ),
                );
              } catch (error) {
                if (!context.mounted) return;
                messenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      error.toString().replaceFirst('Exception: ', ''),
                    ),
                  ),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.delete_outline, color: theme.colorScheme.error),
            title: Text(
              'Reset Progress',
              style: TextStyle(color: theme.colorScheme.error),
            ),
            subtitle: const Text('Clear all mastered cards and streak'),
            onTap: () => _confirmReset(context, ref),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Version'),
            subtitle: Text('1.0.0'),
          ),
          ListTile(
            leading: const Icon(Icons.feedback_outlined),
            title: const Text('Send Feedback'),
            subtitle: const Text('hello@sysdesignflash.dev'),
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Email hello@sysdesignflash.dev with your feedback.',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmReset(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Progress?'),
        content: const Text(
          'This will clear all mastered cards, bookmarks, and your streak. '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () {
              ref.read(masteredProvider.notifier).clearAll();
              ref.read(streakProvider.notifier).reset();
              // Clear bookmarks too
              final bookmarkIds = ref.read(bookmarksProvider).toList();
              for (final id in bookmarkIds) {
                ref.read(bookmarksProvider.notifier).toggle(id);
              }
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Progress reset')));
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
