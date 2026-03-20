import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/concepts_provider.dart';
import '../../providers/deck_filter_provider.dart';
import '../../providers/home_grid_filters_provider.dart';
import '../../providers/mastered_provider.dart';
import '../../shared/widgets/empty_state.dart';
import '../home/widgets/category_filter_bar.dart';
import '../home/widgets/concept_grid_card.dart';
import '../home/widgets/difficulty_filter_bar.dart';
import '../home/widgets/home_search_field.dart';

class ConceptsScreen extends ConsumerWidget {
  const ConceptsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(deckFilterProvider);
    final selectedDifficulty = ref.watch(difficultyDeckFilterProvider);
    final searchExpanded = ref.watch(homeSearchExpandedProvider);
    final searchQuery = ref.watch(homeSearchQueryProvider);
    final categories = ref.watch(categoriesProvider);
    final concepts = ref.watch(homeGridConceptsProvider);
    final mastered = ref.watch(masteredProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: const Text('Concepts'),
          actions: [
            if (searchQuery.isNotEmpty && !searchExpanded)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Center(
                  child: Text(
                    '"$searchQuery"',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            IconButton(
              tooltip: searchExpanded ? 'Close search' : 'Search concepts',
              icon: Icon(searchExpanded ? Icons.close : Icons.search),
              onPressed: () {
                final expanded = ref.read(homeSearchExpandedProvider.notifier);
                if (searchExpanded) {
                  expanded.setExpanded(false);
                  ref.read(homeSearchQueryProvider.notifier).setQuery('');
                } else {
                  expanded.setExpanded(true);
                }
              },
            ),
          ],
        ),
        if (searchExpanded)
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            sliver: const SliverToBoxAdapter(child: HomeSearchField()),
          ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 6),
            child: Text(
              'Category',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
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
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
            child: Text(
              'Difficulty',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: DifficultyFilterBar(
            selected: selectedDifficulty,
            onSelected: (d) =>
                ref.read(difficultyDeckFilterProvider.notifier).select(d),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 14)),
        if (concepts.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyState(
              icon: Icons.filter_alt_off_outlined,
              title: 'No cards in this category',
              subtitle:
                  'No concepts match your current filters. Try another category, difficulty, or search.',
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.78,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final concept = concepts[index];
                return ConceptGridCard(
                  concept: concept,
                  isMastered: mastered.contains(concept.id),
                  onTap: () {
                    final categoryList = ref.read(
                      filteredConceptsProvider(concept.category),
                    );
                    final startIdx = categoryList.indexWhere(
                      (c) => c.id == concept.id,
                    );
                    final ids = categoryList
                        .sublist(startIdx < 0 ? 0 : startIdx)
                        .map((c) => c.id)
                        .toList();
                    context.push('/study/concepts', extra: ids);
                  },
                );
              }, childCount: concepts.length),
            ),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
      ],
    );
  }
}
