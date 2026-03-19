import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/subscription_provider.dart';
import '../../screens/paywall/paywall_sheet.dart';

class ProGate extends ConsumerWidget {
  final Widget child;
  final String featureTitle;
  final String featureDescription;

  const ProGate({
    super.key,
    required this.child,
    this.featureTitle = 'Pro feature',
    this.featureDescription =
        'Unlock this feature with Pro to accelerate your interview prep.',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tier = ref.watch(subscriptionProvider);

    if (tier == SubscriptionTier.pro) return child;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => showContextualPaywallSheet(
        context,
        featureTitle: featureTitle,
        featureDescription: featureDescription,
      ),
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: ListTile(
          leading: const Icon(Icons.lock_outline),
          title: Text('Unlock: $featureTitle'),
          subtitle: Text(featureDescription),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
