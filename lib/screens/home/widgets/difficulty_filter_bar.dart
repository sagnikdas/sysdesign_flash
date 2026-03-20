import 'package:flutter/material.dart';

class DifficultyFilterBar extends StatelessWidget {
  static const _options = [
    (label: 'All', icon: Icons.apps_rounded, color: null as Color?),
    (
      label: 'Beginner',
      icon: Icons.eco_outlined,
      color: Color(0xFF22C55E) as Color?,
    ),
    (
      label: 'Mid',
      icon: Icons.trending_up_rounded,
      color: Color(0xFFF97316) as Color?,
    ),
    (
      label: 'Advanced',
      icon: Icons.bolt_rounded,
      color: Color(0xFFEF4444) as Color?,
    ),
  ];

  // Canonical values matched in provider
  static const _values = ['All', 'Beginner', 'Intermediate', 'Advanced'];

  final String selected;
  final ValueChanged<String> onSelected;

  const DifficultyFilterBar({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(3),
        child: Row(
          children: List.generate(_options.length, (i) {
            final opt = _options[i];
            final val = _values[i];
            final isSelected = val == selected;
            final accent = opt.color ?? cs.primary;

            return Expanded(
              child: GestureDetector(
                onTap: () => onSelected(val),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (opt.color != null
                              ? accent.withValues(alpha: 0.15)
                              : cs.primaryContainer)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        opt.icon,
                        size: 13,
                        color: isSelected
                            ? (opt.color ?? cs.onPrimaryContainer)
                            : cs.onSurfaceVariant.withValues(alpha: 0.6),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        opt.label,
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: isSelected
                              ? (opt.color ?? cs.onPrimaryContainer)
                              : cs.onSurfaceVariant.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
