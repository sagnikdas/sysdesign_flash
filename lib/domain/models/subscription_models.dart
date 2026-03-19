enum SubscriptionTier { free, pro }

enum SubscriptionPlan { monthly, annual, lifetime }

extension SubscriptionPlanSku on SubscriptionPlan {
  String get sku => switch (this) {
    SubscriptionPlan.monthly => 'pro_monthly',
    SubscriptionPlan.annual => 'pro_annual',
    SubscriptionPlan.lifetime => 'pro_lifetime',
  };

  static SubscriptionPlan fromSku(String sku) {
    return switch (sku) {
      'pro_monthly' => SubscriptionPlan.monthly,
      'pro_annual' => SubscriptionPlan.annual,
      'pro_lifetime' => SubscriptionPlan.lifetime,
      _ => SubscriptionPlan.annual,
    };
  }
}
