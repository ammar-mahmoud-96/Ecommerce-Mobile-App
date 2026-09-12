import 'package:flutter/material.dart';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({super.key});

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<CarouselItem> _items = [
    CarouselItem(
      title: '50-40% OFF',
      subtitle: 'Now in (product)',
      description: 'All colours',
      buttonText: 'Shop Now',
      backgroundColor: const Color(0xFFF48FB1),
      imagePath: 'assets/images/carousel_1.png',
    ),
    CarouselItem(
      title: '30% OFF',
      subtitle: 'Summer Collection',
      description: 'Limited time',
      buttonText: 'Shop Now',
      backgroundColor: const Color(0xFF81D4FA),
      imagePath: 'assets/images/carousel_2.png',
    ),
    CarouselItem(
      title: 'New Arrivals',
      subtitle: 'Fresh Styles',
      description: 'Just landed',
      buttonText: 'Explore',
      backgroundColor: const Color(0xFFA5D6A7),
      imagePath: 'assets/images/carousel_1.png',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return _buildCarouselCard(_items[index]);
            },
          ),
        ),
        const SizedBox(height: 12),
        _buildDotsIndicator(),
      ],
    );
  }

  Widget _buildCarouselCard(CarouselItem item) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              item.imagePath,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              errorBuilder: (context, error, stackTrace) {
                // Placeholder when image not found
                return Container(
                  width: double.infinity,
                  height: 189,
                  color: item.backgroundColor.withOpacity(0.8),
                  child: const Icon(
                    Icons.shopping_bag,
                    size: 60,
                    color: Colors.white54,
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.subtitle,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
              Text(
                item.description,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  // Handle shop now action
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(item.buttonText),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _items.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? Theme.of(context).primaryColor
                : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

class CarouselItem {
  final String title;
  final String subtitle;
  final String description;
  final String buttonText;
  final Color backgroundColor;
  final String imagePath;

  CarouselItem({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.buttonText,
    required this.backgroundColor,
    required this.imagePath,
  });
}
