import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/concepts_provider.dart';
import '../../providers/mastered_provider.dart';
import '../../providers/streak_provider.dart';
import '../../providers/weak_areas_provider.dart';
import '../../providers/user_prefs_provider.dart';
import '../../core/theme/app_colors.dart';
import 'widgets/welcome_banner.dart';
import 'widgets/interview_simulation_banner.dart';
import 'widgets/streak_reset_warning_sheet.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _resetWarningScheduled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _maybeShowResetWarning();
    });
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  void _maybeShowResetWarning() {
    if (_resetWarningScheduled) return;
    _resetWarningScheduled = true;

    final streak = ref.read(streakProvider);
    if (streak.count <= 0 || streak.lastStudyDate == null) return;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final last = DateTime(
      streak.lastStudyDate!.year,
      streak.lastStudyDate!.month,
      streak.lastStudyDate!.day,
    );

    final yesterday = today.subtract(const Duration(days: 1));
    final missed = !(_isSameDay(last, yesterday) || _isSameDay(last, today));
    if (!missed) return;

    if (streak.lastResetWarningShownOn != null &&
        _isSameDay(streak.lastResetWarningShownOn!, today)) {
      return;
    }

    ref.read(streakProvider.notifier).markResetWarningShownForToday();

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (_) => StreakResetWarningSheet(
        streakCount: streak.count,
        onStart: () {
          Navigator.of(context).pop();
          context.push('/study/all');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final streak = ref.watch(streakProvider);
    final mastered = ref.watch(masteredProvider);
    final totalConcepts = ref.watch(conceptsProvider).length;
    final userPrefs = ref.watch(userPrefsProvider);
    final weakAreas = ref.watch(weakAreasProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: Row(
            children: [
              Hero(
                tag: 'app_logo',
                child: Icon(
                  Icons.architecture,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 8),
              const Text('SysDesign Flash'),
            ],
          ),
          actions: [
            if (streak.count > 0)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: TweenAnimationBuilder<double>(
                  key: ValueKey(streak.count),
                  tween: Tween<double>(begin: 1.25, end: 1.0),
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.elasticOut,
                  builder: (context, scale, _) => Transform.scale(
                    scale: scale,
                    child: Chip(
                      avatar: const Text('🔥', style: TextStyle(fontSize: 14)),
                      label: Text('${streak.count}'),
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () => context.push('/settings'),
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          sliver: SliverToBoxAdapter(
            child: WelcomeBanner(
              displayName: userPrefs.displayName,
              dailyGoal: userPrefs.dailyGoal,
              masteredCount: mastered.length,
              totalCount: totalConcepts,
            ),
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
          sliver: SliverToBoxAdapter(child: InterviewSimulationBanner()),
        ),
        if (weakAreas.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            sliver: SliverToBoxAdapter(
              child: Card(
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  leading: Icon(
                    Icons.flag,
                    size: 22,
                    color: theme.colorScheme.primary,
                  ),
                  title: Text(
                    'Focus Areas',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    weakAreas.map((w) => w.category).join(' · '),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  children: weakAreas.map((weak) {
                    final color = AppColors.categoryColor(weak.category);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  weak.category,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Weakness: ${(weak.weaknessRatio * 100).round()}%',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          FilledButton(
                            onPressed: () =>
                                context.push('/study/${weak.category}'),
                            child: const Text('Study now'),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
      ],
    );
  }
}
