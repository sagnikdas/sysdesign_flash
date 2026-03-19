import 'package:flutter/material.dart';

class StatsOverview extends StatelessWidget {
  final int total;
  final int mastered;
  final int remaining;
  final int streak;

  const StatsOverview({
    super.key,
    required this.total,
    required this.mastered,
    required this.remaining,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        _StatTile(
          icon: Icons.library_books,
          value: '$total',
          label: 'Total',
          color: theme.colorScheme.primary,
          theme: theme,
        ),
        const SizedBox(width: 8),
        _StatTile(
          icon: Icons.check_circle,
          value: '$mastered',
          label: 'Mastered',
          color: Colors.green,
          theme: theme,
        ),
        const SizedBox(width: 8),
        _StatTile(
          icon: Icons.pending,
          value: '$remaining',
          label: 'Remaining',
          color: Colors.orange,
          theme: theme,
        ),
        const SizedBox(width: 8),
        _StatTile(
          icon: Icons.local_fire_department,
          value: '$streak',
          label: 'Streak',
          color: Colors.deepOrange,
          theme: theme,
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final ThemeData theme;

  const _StatTile({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          child: Column(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(height: 6),
              Text(
                value,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
