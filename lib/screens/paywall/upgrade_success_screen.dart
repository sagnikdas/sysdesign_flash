import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UpgradeSuccessScreen extends StatefulWidget {
  const UpgradeSuccessScreen({super.key});

  @override
  State<UpgradeSuccessScreen> createState() => _UpgradeSuccessScreenState();
}

class _UpgradeSuccessScreenState extends State<UpgradeSuccessScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Upgrade Complete')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final scale = 1 + (_controller.value * 0.1);
                  return Transform.scale(
                    scale: scale,
                    child: Icon(
                      Icons.celebration_outlined,
                      size: 72,
                      color: theme.colorScheme.primary,
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              Text(
                'Welcome to Pro!',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your advanced study tools are now unlocked.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => context.go('/study/smart'),
                  child: const Text('Start Smart Session'),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => context.go('/home'),
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
