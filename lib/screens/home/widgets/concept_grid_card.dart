import 'package:flutter/material.dart';
import '../../../domain/models/concept.dart';

class ConceptGridCard extends StatelessWidget {
  final Concept concept;
  final bool isMastered;
  final VoidCallback onTap;

  const ConceptGridCard({
    super.key,
    required this.concept,
    this.isMastered = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final heroTag = 'concept_header_${concept.id}';

    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 4, color: concept.color),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Hero(
                          tag: heroTag,
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              concept.icon,
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                        const Spacer(),
                        if (isMastered)
                          Container(
                            width: 22,
                            height: 22,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 14,
                            ),
                          )
                        else
                          _DifficultyDot(difficulty: concept.difficulty),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        concept.title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: concept.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        concept.category,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: concept.color,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DifficultyDot extends StatelessWidget {
  final Difficulty difficulty;

  const _DifficultyDot({required this.difficulty});

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (difficulty) {
      Difficulty.beginner => (Colors.green, 'B'),
      Difficulty.intermediate => (Colors.orange, 'I'),
      Difficulty.advanced => (Colors.red, 'A'),
    };

    return Tooltip(
      message: difficulty.name,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
