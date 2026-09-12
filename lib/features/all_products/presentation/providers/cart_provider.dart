import 'package:flutter_app/features/all_products/data/models/product_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItem {
  final ProductItemModel product;
  final int quantity;

  CartItem({required this.product, this.quantity = 1});

  CartItem copyWith({ProductItemModel? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice => product.price * quantity;
}

class CartNotifier extends StateNotifier<Map<int, CartItem>> {
  CartNotifier() : super({});

  void addToCart(ProductItemModel product) {
    if (state.containsKey(product.id)) {
      // Increase quantity
      final existingItem = state[product.id]!;
      state = {
        ...state,
        product.id: existingItem.copyWith(quantity: existingItem.quantity + 1),
      };
    } else {
      // Add new item
      state = {
        ...state,
        product.id: CartItem(product: product, quantity: 1),
      };
    }
  }

  void removeFromCart(int productId) {
    if (!state.containsKey(productId)) return;

    final existingItem = state[productId]!;
    if (existingItem.quantity > 1) {
      // Decrease quantity
      state = {
        ...state,
        productId: existingItem.copyWith(quantity: existingItem.quantity - 1),
      };
    } else {
      // Remove item completely
      state = Map.from(state)..remove(productId);
    }
  }

  void removeItemCompletely(int productId) {
    state = Map.from(state)..remove(productId);
  }

  void clearCart() {
    state = {};
  }

  int getQuantity(int productId) {
    return state[productId]?.quantity ?? 0;
  }

  double get totalPrice {
    return state.values.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  int get totalItems {
    return state.values.fold(0, (sum, item) => sum + item.quantity);
  }
}

final cartProvider =
    StateNotifierProvider<CartNotifier, Map<int, CartItem>>((ref) {
  return CartNotifier();
});
