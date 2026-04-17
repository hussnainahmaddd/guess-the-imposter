import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:flutter/foundation.dart';

class PurchaseService {
  static final PurchaseService _instance = PurchaseService._internal();
  factory PurchaseService() => _instance;
  PurchaseService._internal();

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  
  static const String monthlySubscriptionId = 'monthly_Sub';
  
  ProductDetails? monthlyProduct;
  final ValueNotifier<bool> isPremium = ValueNotifier<bool>(false);

  void initialize() {
    final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      debugPrint("Purchase stream error: $error");
    });
  }

  Future<void> fetchProducts() async {
    final bool available = await _inAppPurchase.isAvailable();
    if (!available) {
      debugPrint("Store not available");
      return;
    }

    const Set<String> ids = {monthlySubscriptionId};
    final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(ids);

    if (response.notFoundIDs.isNotEmpty) {
      debugPrint("Products not found: ${response.notFoundIDs}");
    }

    final products = response.productDetails;
    if (products.isNotEmpty) {
      // Use a safer way to find the product to avoid AppStoreProduct2Details type issues
      final index = products.indexWhere((p) => p.id == monthlySubscriptionId);
      monthlyProduct = index != -1 ? products[index] : products.first;
    }
  }

  Future<void> buySubscription() async {
    if (monthlyProduct == null) {
      await fetchProducts();
    }
    
    if (monthlyProduct != null) {
      final PurchaseParam purchaseParam = PurchaseParam(productDetails: monthlyProduct!);
      await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    } else {
      debugPrint("Cannot start purchase: monthlyProduct is null");
    }
  }

  Future<void> restorePurchases() async {
    await _inAppPurchase.restorePurchases();
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // Show pending UI if needed
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          debugPrint("Purchase error: ${purchaseDetails.error}");
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
                   purchaseDetails.status == PurchaseStatus.restored) {
          // Verify purchase if needed
          isPremium.value = true;
        }
        
        if (purchaseDetails.pendingCompletePurchase) {
          _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  void dispose() {
    _subscription.cancel();
  }
}
