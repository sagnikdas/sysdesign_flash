import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/models/subscription_models.dart';
import '../domain/repositories/subscription_repository.dart';
export '../domain/models/subscription_models.dart';

part 'subscription_provider.g.dart';

@riverpod
SubscriptionRepository subscriptionRepository(Ref ref) {
  return SubscriptionRepository();
}

@riverpod
Future<List<ProductDetails>> billingProducts(Ref ref) {
  return ref.read(subscriptionRepositoryProvider).fetchProducts();
}

@riverpod
class Subscription extends _$Subscription {
  SubscriptionTier? _debugOverrideTier;

  @override
  SubscriptionTier build() {
    final cached = ref.read(subscriptionRepositoryProvider).getCachedTier();
    unawaited(_loadCurrentTier());
    return cached;
  }

  void setTier(SubscriptionTier tier) {
    _debugOverrideTier = tier;
    state = tier;
  }

  Future<void> refresh() async {
    if (_debugOverrideTier != null) {
      state = _debugOverrideTier!;
      return;
    }
    state = await ref.read(subscriptionRepositoryProvider).getCurrentTier();
  }

  Future<void> clearDebugOverride() async {
    _debugOverrideTier = null;
    await refresh();
  }

  Future<SubscriptionTier> purchasePlan(SubscriptionPlan plan) async {
    if (_debugOverrideTier != null) {
      state = SubscriptionTier.pro;
      return state;
    }

    final previous = state;
    state = SubscriptionTier.pro;
    try {
      final tier = await ref
          .read(subscriptionRepositoryProvider)
          .purchaseByPlan(plan);
      state = tier;
      return tier;
    } catch (_) {
      state = previous;
      rethrow;
    }
  }

  Future<SubscriptionTier> restorePurchases() async {
    if (_debugOverrideTier != null) {
      return _debugOverrideTier!;
    }
    final tier = await ref
        .read(subscriptionRepositoryProvider)
        .restorePurchases();
    state = tier;
    return tier;
  }

  Future<void> _loadCurrentTier() async {
    if (_debugOverrideTier != null) return;
    try {
      state = await ref.read(subscriptionRepositoryProvider).getCurrentTier();
    } catch (_) {
      // Keep cached state when server refresh fails.
    }
  }
}
