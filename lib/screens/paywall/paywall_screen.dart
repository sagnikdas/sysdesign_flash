import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/subscription_provider.dart';

enum _PaywallPlan { annual, monthly, lifetime }

class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({super.key});

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  _PaywallPlan _selectedPlan = _PaywallPlan.annual;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final planText = switch (_selectedPlan) {
      _PaywallPlan.annual => r'$35.99/yr',
      _PaywallPlan.monthly => r'$5.99/mo',
      _PaywallPlan.lifetime => r'$79.99 one-time',
    };

    return Scaffold(
      appBar: AppBar(title: const Text('SysDesign Flash Pro')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Build confidence faster with Pro',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const _BenefitItem(
                      icon: Icons.auto_awesome_outlined,
                      text: 'SM-2 smart queue and weak area targeting',
                    ),
                    const _BenefitItem(
                      icon: Icons.quiz_outlined,
                      text: 'Timed interview simulation mode',
                    ),
                    const _BenefitItem(
                      icon: Icons.analytics_outlined,
                      text:
                          'Readiness score, heatmap, and confidence analytics',
                    ),
                    const _BenefitItem(
                      icon: Icons.cloud_sync_outlined,
                      text: 'Cloud sync support when backend is enabled',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SegmentedButton<_PaywallPlan>(
                      segments: const [
                        ButtonSegment(
                          value: _PaywallPlan.annual,
                          label: Text('Annual'),
                        ),
                        ButtonSegment(
                          value: _PaywallPlan.monthly,
                          label: Text('Monthly'),
                        ),
                        ButtonSegment(
                          value: _PaywallPlan.lifetime,
                          label: Text('Lifetime'),
                        ),
                      ],
                      selected: {_selectedPlan},
                      onSelectionChanged: (selection) {
                        setState(() => _selectedPlan = selection.first);
                      },
                    ),
                    const SizedBox(height: 12),
                    _PlanTile(
                      selected: _selectedPlan == _PaywallPlan.annual,
                      title: 'Annual',
                      subtitle: r'$35.99 / year (best value)',
                    ),
                    _PlanTile(
                      selected: _selectedPlan == _PaywallPlan.monthly,
                      title: 'Monthly',
                      subtitle: r'$5.99 / month',
                    ),
                    _PlanTile(
                      selected: _selectedPlan == _PaywallPlan.lifetime,
                      title: 'Lifetime',
                      subtitle: r'$79.99 one-time',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  ref
                      .read(subscriptionProvider.notifier)
                      .setTier(SubscriptionTier.pro);
                  context.go('/upgrade-success');
                },
                child: Text('Start 7-day Free Trial - $planText'),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '"The smartest way to retain system design concepts before interviews."',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Cancel anytime'),
                ),
                TextButton(onPressed: () {}, child: const Text('Restore')),
                TextButton(onPressed: () {}, child: const Text('Privacy')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BenefitItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _BenefitItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class _PlanTile extends StatelessWidget {
  final bool selected;
  final String title;
  final String subtitle;

  const _PlanTile({
    required this.selected,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: selected
            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.45)
            : theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: selected ? theme.colorScheme.primary : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          Icon(
            selected ? Icons.check_circle : Icons.circle_outlined,
            size: 18,
            color: selected
                ? theme.colorScheme.primary
                : theme.colorScheme.outline,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$title - $subtitle',
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
