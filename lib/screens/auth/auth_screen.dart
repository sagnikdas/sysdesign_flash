import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/auth_provider.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  bool _isSignUp = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);
    final controller = ref.read(authControllerProvider.notifier);
    final user = state.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Account & Sync')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Sign in to sync your progress across devices.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          if (!state.isConfigured)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Cloud sync is not configured for this build yet. '
                  'You can keep studying offline.',
                ),
              ),
            ),
          if (user != null)
            Card(
              child: ListTile(
                leading: const Icon(Icons.verified_user_outlined),
                title: Text(user.email ?? 'Signed in'),
                subtitle: const Text('Cloud sync is enabled for your account'),
                trailing: TextButton(
                  onPressed: controller.signOut,
                  child: const Text('Sign out'),
                ),
              ),
            )
          else ...[
            FilledButton.icon(
              onPressed: state.isConfigured ? controller.signInWithGoogle : null,
              icon: const Icon(Icons.g_mobiledata),
              label: const Text('Continue with Google'),
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Create a new account'),
              value: _isSignUp,
              onChanged: (value) => setState(() => _isSignUp = value),
            ),
            if (_isSignUp)
              TextField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
            TextField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: state.isConfigured
                  ? () async {
                      if (_isSignUp) {
                        await controller.signUp(
                          email: _emailCtrl.text.trim(),
                          password: _passwordCtrl.text,
                          name: _nameCtrl.text.trim(),
                        );
                      } else {
                        await controller.signInWithEmail(
                          email: _emailCtrl.text.trim(),
                          password: _passwordCtrl.text,
                        );
                      }
                    }
                  : null,
              child: Text(_isSignUp ? 'Sign up with email' : 'Sign in with email'),
            ),
          ],
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () async {
              await controller.continueWithoutAccount();
              if (context.mounted) Navigator.of(context).maybePop();
            },
            child: const Text('Continue without account'),
          ),
          const SizedBox(height: 16),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'What we store: your display name, progress state, and '
                'subscription details for sync and restore. '
                'Phone number collection is optional and never blocks sign-in.',
              ),
            ),
          ),
          if (state.errorMessage != null) ...[
            const SizedBox(height: 12),
            Text(
              state.errorMessage!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
        ],
      ),
    );
  }
}
