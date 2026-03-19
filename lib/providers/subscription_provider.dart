import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_provider.g.dart';

enum SubscriptionTier { free, pro }

@riverpod
class Subscription extends _$Subscription {
  @override
  SubscriptionTier build() {
    return SubscriptionTier.free;
  }

  void setTier(SubscriptionTier tier) {
    state = tier;
  }
}
