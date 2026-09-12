import 'package:flutter/material.dart';
import 'package:flutter_app/features/all_products/data/models/product_item_model.dart';
import 'package:flutter_app/features/all_products/presentation/providers/cart_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductItem extends ConsumerWidget {
  const ProductItem({super.key, required this.product});

  final ProductItemModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final cart = ref.watch(cartProvider);
    final quantity = cart[product.id]?.quantity ?? 0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          Expanded(
            child: Center(
              child: product.image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        product.image!,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: colors.secondary,
                            ),
                            child: const Icon(Icons.image, size: 40),
                          );
                        },
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: colors.secondary,
                      ),
                      child: const Icon(Icons.shopping_bag, size: 40),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          // Product name
          Text(
            product.name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          // Price and quantity controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Price
              Row(
                children: [
                  Icon(Icons.attach_money, color: colors.primary, size: 18),
                  Text(
                    product.price.toStringAsFixed(2),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colors.primary,
                    ),
                  ),
                ],
              ),
              // Quantity controls
              Row(
                children: [
                  // Remove button
                  IgnorePointer(
                    ignoring: quantity == 0,
                    child: GestureDetector(
                      onTap: () {
                        ref
                            .read(cartProvider.notifier)
                            .removeFromCart(product.id);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: quantity > 0
                              ? colors.secondary
                              : Colors.grey.shade200,
                        ),
                        child: Icon(
                          Icons.remove,
                          size: 18,
                          color: quantity > 0 ? colors.primary : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  // Quantity
                  Container(
                    constraints: const BoxConstraints(minWidth: 28),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      quantity.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  // Add button
                  GestureDetector(
                    onTap: () {
                      ref.read(cartProvider.notifier).addToCart(product);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: colors.secondary,
                      ),
                      child: Icon(Icons.add, size: 18, color: colors.primary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
