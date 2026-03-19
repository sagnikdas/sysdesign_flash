import 'package:flutter/material.dart';

import '../../../domain/models/concept.dart';
import '../../study/widgets/bullets_tab.dart';
import '../../study/widgets/card_header.dart';
import '../../study/widgets/diagram_tab.dart';
import '../../study/widgets/interview_tab.dart';

class ConceptModal extends StatefulWidget {
  final Concept concept;

  const ConceptModal({
    super.key,
    required this.concept,
  });

  @override
  State<ConceptModal> createState() => _ConceptModalState();
}

class _ConceptModalState extends State<ConceptModal> {
  int _selectedTab = 0;

  @override
  void didUpdateWidget(covariant ConceptModal oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.concept.id != widget.concept.id) {
      _selectedTab = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Expanded(child: CardHeader(concept: widget.concept)),
                IconButton(
                  tooltip: 'Close',
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(
                  value: 0,
                  label: Text('Diagram'),
                  icon: Icon(Icons.schema_outlined, size: 18),
                ),
                ButtonSegment(
                  value: 1,
                  label: Text('Points'),
                  icon: Icon(Icons.list, size: 18),
                ),
                ButtonSegment(
                  value: 2,
                  label: Text('Q&A'),
                  icon: Icon(Icons.mic, size: 18),
                ),
              ],
              selected: {_selectedTab},
              onSelectionChanged: (selected) =>
                  setState(() => _selectedTab = selected.first),
              showSelectedIcon: false,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: switch (_selectedTab) {
                0 => DiagramTab(
                    key: const ValueKey('diagram'),
                    diagram: widget.concept.diagram,
                    mnemonic: widget.concept.mnemonic,
                  ),
                1 => BulletsTab(
                    key: const ValueKey('bullets'),
                    bullets: widget.concept.bullets,
                  ),
                _ => InterviewTab(
                    key: const ValueKey('interview'),
                    question: widget.concept.interviewQ,
                    answer: widget.concept.interviewA,
                  ),
              },
            ),
          ),
        ],
      ),
    );
  }
}

