import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/concepts_provider.dart';
import '../../providers/deck_filter_provider.dart';
import '../../providers/mastered_provider.dart';
import '../../providers/streak_provider.dart';
import 'widgets/welcome_banner.dart';
import 'widgets/category_filter_bar.dart';
import 'widgets/concept_grid_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final selectedCategory = ref.watch(deckFilterProvider);
    final categories = ref.watch(categoriesProvider);
    final concepts = ref.watch(filteredConceptsProvider(selectedCategory));
    final totalConcepts = ref.watch(conceptsProvider).length;
    final mastered = ref.watch(masteredProvider);
    final streak = ref.watch(streakProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: Row(
            children: [
              Icon(Icons.architecture, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              const Text('SysDesign Flash'),
            ],
          ),
          actions: [
            if (streak.count > 0)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Chip(
                  avatar: const Text('🔥', style: TextStyle(fontSize: 14)),
                  label: Text('${streak.count}'),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
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
              masteredCount: mastered.length,
              totalCount: totalConcepts,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: CategoryFilterBar(
            categories: categories,
            selected: selectedCategory,
            onSelected: (cat) =>
                ref.read(deckFilterProvider.notifier).select(cat),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 12)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.9,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final concept = concepts[index];
                return ConceptGridCard(
                  concept: concept,
                  isMastered: mastered.contains(concept.id),
                  onTap: () => context.push('/study/${concept.category}'),
                );
              },
              childCount: concepts.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
      ],
    );
  }
}
