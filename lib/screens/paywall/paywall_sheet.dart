import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> showContextualPaywallSheet(
  BuildContext context, {
  required String featureTitle,
  required String featureDescription,
}) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (_) => _PaywallSheet(
      featureTitle: featureTitle,
      featureDescription: featureDescription,
    ),
  );
}

class _PaywallSheet extends StatelessWidget {
  final String featureTitle;
  final String featureDescription;

  const _PaywallSheet({
    required this.featureTitle,
    required this.featureDescription,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lock_outline, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '$featureTitle is Pro',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              featureDescription,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.push('/paywall');
                },
                child: const Text('Start 7-day Free Trial'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.push('/paywall');
                },
                child: const Text('See all Pro features'),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Not now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
