import 'package:flutter/material.dart';
import 'home_product_card.dart';

class HomeProductCarousel extends StatefulWidget {
  final String? title;
  final VoidCallback? onViewAll;

  const HomeProductCarousel({super.key, this.title, this.onViewAll});

  @override
  State<HomeProductCarousel> createState() => _HomeProductCarouselState();
}

class _HomeProductCarouselState extends State<HomeProductCarousel> {
  final ScrollController _scrollController = ScrollController();

  // Sample product data - replace with actual data source
  static final List<ProductData> _products = [
    ProductData(
      imagePath: 'assets/images/homeProduct1.png',
      title: 'Women Printed Kurta',
      description: 'Neque porro quisquam est qui dolorem ipsum quia',
      price: 1500,
      originalPrice: 2499,
      discountPercent: 40,
      rating: 4.0,
      reviewCount: 56890,
    ),
    ProductData(
      imagePath: 'assets/images/homeProduct1.png',
      title: 'HRX by Hrithik Roshan',
      description: 'Neque porro quisquam est qui dolorem ipsum quia',
      price: 2499,
      originalPrice: 4999,
      discountPercent: 50,
      rating: 4.5,
      reviewCount: 344567,
    ),
    ProductData(
      imagePath: 'assets/images/homeProduct1.png',
      title: 'Casual T-Shirt',
      description: 'Premium cotton comfortable fit',
      price: 799,
      originalPrice: 1299,
      discountPercent: 38,
      rating: 4.2,
      reviewCount: 12450,
    ),
    ProductData(
      imagePath: 'assets/images/product_4.png',
      title: 'Running Shoes',
      description: 'Lightweight breathable sports shoes',
      price: 1999,
      originalPrice: 3499,
      discountPercent: 43,
      rating: 4.7,
      reviewCount: 89234,
    ),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToNext() {
    final currentOffset = _scrollController.offset;
    final maxOffset = _scrollController.position.maxScrollExtent;
    final newOffset = currentOffset + 200;

    if (newOffset < maxOffset) {
      _scrollController.animateTo(
        newOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Optional header with title and view all
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (widget.onViewAll != null)
                  TextButton(
                    onPressed: widget.onViewAll,
                    child: const Row(
                      children: [
                        Text('View all'),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward, size: 16),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        const SizedBox(height: 12),
        // Product carousel with arrow button
        SizedBox(
          height: 310,
          child: Stack(
            children: [
              ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return HomeProductCard(
                    imagePath: product.imagePath,
                    title: product.title,
                    description: product.description,
                    price: product.price,
                    originalPrice: product.originalPrice,
                    discountPercent: product.discountPercent,
                    rating: product.rating,
                    reviewCount: product.reviewCount,
                    onTap: () {
                      // TODO: Navigate to product detail
                    },
                  );
                },
              ),
              // Circular arrow button
              Positioned(
                right: 8,
                top: 60,
                child: GestureDetector(
                  onTap: _scrollToNext,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.chevron_right,
                      color: Colors.black54,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProductData {
  final String imagePath;
  final String title;
  final String description;
  final double price;
  final double originalPrice;
  final int discountPercent;
  final double rating;
  final int reviewCount;

  ProductData({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.discountPercent,
    required this.rating,
    required this.reviewCount,
  });
}
