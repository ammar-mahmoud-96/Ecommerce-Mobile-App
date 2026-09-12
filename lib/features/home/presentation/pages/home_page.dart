import 'package:flutter/material.dart';
import 'package:flutter_app/features/all_products/presentation/pages/all_products_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: const [
            SliverToBoxAdapter(child: _ShopHeader()),
            SliverToBoxAdapter(child: _HeroSection()),
            SliverToBoxAdapter(child: _BrandStrip()),
            SliverToBoxAdapter(child: _NewArrivals()),
            SliverToBoxAdapter(child: _TopSelling()),
            SliverToBoxAdapter(child: _DressStyles()),
            SliverToBoxAdapter(child: _Testimonials()),
            SliverToBoxAdapter(child: _Newsletter()),
          ],
        ),
      ),
    );
  }
}

class _ShopHeader extends StatelessWidget {
  const _ShopHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFF006B68), width: 3)),
      ),
      child: Row(
        children: [
          const Text(
            'SHOP.CO',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(width: 28),
          if (MediaQuery.sizeOf(context).width > 600)
            const Expanded(
              child: Row(
                children: [
                  _HeaderLink('All Products'),
                  _HeaderLink('On Sale'),
                  _HeaderLink('New Arrivals'),
                  _HeaderLink('Best Selling'),
                ],
              ),
            )
          else
            const Spacer(),
          if (MediaQuery.sizeOf(context).width > 500)
            Container(
              width: 260,
              height: 38,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, size: 18, color: Colors.grey),
                  SizedBox(width: 8),
                  Text(
                    'Search for products...',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
          const SizedBox(width: 14),
          const Icon(Icons.shopping_cart_outlined, size: 23),
          const SizedBox(width: 16),
          const Icon(Icons.person_outline, size: 24),
        ],
      ),
    );
  }
}

class _HeaderLink extends StatelessWidget {
  final String label;
  const _HeaderLink(this.label);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(right: 22),
    child: Text(
      label,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
    ),
  );
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width > 700;
    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FIND CLOTHES\nTHAT MATCHES\nYOUR STYLE',
          style: TextStyle(
            fontSize: wide ? 48 : 38,
            height: .96,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.5,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Browse through our diverse range of meticulously crafted garments,\ndesigned to bring out your individuality and cater to your sense of style.',
          style: TextStyle(color: Color(0xFF666666), height: 1.3),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
            shape: const StadiumBorder(),
          ),
          child: const Text('Shop Now'),
        ),
        const SizedBox(height: 28),
        const Wrap(
          spacing: 26,
          runSpacing: 16,
          children: [
            _Stat('200+', 'International Brands'),
            _Stat('2,000+', 'High-Quality Products'),
            _Stat('30,000+', 'Happy Customers'),
          ],
        ),
      ],
    );
    final image = ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: Image.asset(
        'assets/images/hero.png',
        height: wide ? 360 : 230,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
    return Container(
      color: const Color(0xFFF5F5F5),
      padding: EdgeInsets.fromLTRB(wide ? 42 : 24, 44, wide ? 42 : 24, 42),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: wide
            ? Row(
                children: [
                  Expanded(flex: 5, child: copy),
                  const SizedBox(width: 48),
                  Expanded(flex: 4, child: image),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [copy, const SizedBox(height: 32), image],
              ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value;
  final String label;
  const _Stat(this.value, this.label);
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        value,
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
      ),
      Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _BrandStrip extends StatelessWidget {
  const _BrandStrip();
  @override
  Widget build(BuildContext context) => Container(
    color: Colors.black,
    padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Text('VERSACE', style: _BrandStyle()),
          SizedBox(width: 48),
          Text('ZARA', style: _BrandStyle()),
          SizedBox(width: 48),
          Text('GUCCI', style: _BrandStyle()),
          SizedBox(width: 48),
          Text('PRADA', style: _BrandStyle()),
          SizedBox(width: 48),
          Text('Calvin Klein', style: _BrandStyle()),
        ],
      ),
    ),
  );
}

class _BrandStyle extends TextStyle {
  const _BrandStyle()
    : super(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w800);
}

class _NewArrivals extends StatelessWidget {
  const _NewArrivals();
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(14, 42, 14, 32),
    child: Column(
      children: [
        _SectionHeading(
          title: 'NEW ARRIVALS',
          onViewAll: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  const AllProductsPage(filter: CatalogFilter.newArrivals),
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 270,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              _ProductCard(
                'assets/images/products/product1.png',
                'T-shirt with Tape Details',
                '\$120',
              ),
              _ProductCard(
                'assets/images/products/product2.png',
                'Skinny Fit Jeans',
                '\$180',
              ),
              _ProductCard(
                'assets/images/products/product3.png',
                'Checkered Shirt',
                '\$160',
              ),
              _ProductCard(
                'assets/images/products/product4.png',
                'Vertical Striped Shirt',
                '\$212',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _TopSelling extends StatelessWidget {
  const _TopSelling();

  @override
  Widget build(BuildContext context) => Container(
    color: const Color(0xFFFAFAFA),
    padding: const EdgeInsets.fromLTRB(14, 42, 14, 38),
    child: Column(
      children: [
        _SectionHeading(
          title: 'TOP SELLING',
          onViewAll: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  const AllProductsPage(filter: CatalogFilter.bestSelling),
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 270,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              _ProductCard(
                'assets/images/products/product8.png',
                'Faded Skinny Jeans',
                'EGP 130',
                oldPrice: 'EGP 160',
              ),
              _ProductCard(
                'assets/images/products/product5.png',
                'Vertical Striped Shirt',
                'EGP 130',
                oldPrice: 'EGP 160',
              ),
              _ProductCard(
                'assets/images/products/product6.png',
                'Courage Graphic T-Shirt',
                'EGP 130',
                oldPrice: 'EGP 160',
              ),
              _ProductCard(
                'assets/images/products/product7.png',
                'Loose Fit Bermuda Shorts',
                'EGP 130',
                oldPrice: 'EGP 160',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _SectionHeading extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;
  const _SectionHeading({required this.title, required this.onViewAll});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
        ),
      ),
      TextButton(
        onPressed: onViewAll,
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('View All'),
            SizedBox(width: 4),
            Icon(Icons.arrow_forward, size: 16),
          ],
        ),
      ),
    ],
  );
}

class _DressStyles extends StatelessWidget {
  const _DressStyles();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(14, 42, 14, 20),
    child: Column(
      children: [
        const Text(
          'BROWSE BY DRESS STYLE',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 20),
        GridView.count(
          crossAxisCount: MediaQuery.sizeOf(context).width > 600 ? 2 : 1,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 2.2,
          children: const [
            _StyleCard('Casual', 'assets/images/products/product1.png'),
            _StyleCard('Formal', 'assets/images/products/product2.png'),
            _StyleCard('Party', 'assets/images/products/product3.png'),
            _StyleCard('Gym', 'assets/images/products/product4.png'),
          ],
        ),
      ],
    ),
  );
}

class _StyleCard extends StatelessWidget {
  final String title;
  final String image;
  const _StyleCard(this.title, this.image);

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(14),
    child: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(image, fit: BoxFit.cover),
        Container(color: Colors.white.withValues(alpha: .55)),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ],
    ),
  );
}

class _Testimonials extends StatelessWidget {
  const _Testimonials();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(14, 28, 14, 38),
    child: Column(
      children: [
        const Text(
          'OUR HAPPY CUSTOMERS',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 145,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              _Testimonial('Sarah M.', 'Great quality and fast shipping!'),
              _Testimonial('Alex K.', 'Excellent customer service.'),
              _Testimonial('James L.', 'Fits perfectly.'),
              _Testimonial('Lisa R.', 'Very satisfied with my purchase.'),
            ],
          ),
        ),
      ],
    ),
  );
}

class _Testimonial extends StatelessWidget {
  final String name;
  final String text;
  const _Testimonial(this.name, this.text);

  @override
  Widget build(BuildContext context) => Container(
    width: 245,
    margin: const EdgeInsets.only(right: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFFE5E5E5)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '★★★★★',
          style: TextStyle(color: Color(0xFFFFB000), letterSpacing: 2),
        ),
        const SizedBox(height: 10),
        Text(text, style: const TextStyle(color: Colors.black87)),
        const Spacer(),
        Text(
          '- $name',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    ),
  );
}

class _Newsletter extends StatelessWidget {
  const _Newsletter();

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(14, 0, 14, 28),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'STAY UPTO DATE ABOUT\nOUR LATEST OFFERS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 18),
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Enter your email address',
            prefixIcon: const Icon(Icons.mail_outline),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: const StadiumBorder(),
            ),
            child: const Text('Subscribe to Newsletter'),
          ),
        ),
      ],
    ),
  );
}

class _ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String? oldPrice;
  const _ProductCard(this.image, this.title, this.price, {this.oldPrice});
  @override
  Widget build(BuildContext context) => Container(
    width: 220,
    margin: const EdgeInsets.only(right: 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(image, fit: BoxFit.contain),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Text(
              price,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),
            if (oldPrice != null) ...[
              const SizedBox(width: 8),
              Text(
                oldPrice!,
                style: const TextStyle(
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                  fontSize: 13,
                ),
              ),
            ],
          ],
        ),
      ],
    ),
  );
}
