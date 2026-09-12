import 'package:flutter/material.dart';
import 'package:flutter_app/features/all_products/data/models/product_item_model.dart';
import 'package:flutter_app/features/all_products/data/repositories/products_repository.dart';
import 'package:flutter_app/features/all_products/presentation/providers/cart_provider.dart';
import 'package:flutter_app/features/all_products/presentation/widgets/product_item.dart';
import 'package:flutter_app/features/cart/presentation/pages/cart_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CatalogFilter { all, newArrivals, bestSelling, onSale }

class AllProductsPage extends ConsumerStatefulWidget {
  final CatalogFilter filter;
  const AllProductsPage({super.key, this.filter = CatalogFilter.all});
  @override
  ConsumerState<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends ConsumerState<AllProductsPage> {
  final _repository = ProductsRepository();
  final _searchController = TextEditingController();
  late Future<List<ProductItemModel>> _productsFuture;
  final _categories = <String>{};
  final _colors = <String>{};
  final _sizes = <String>{};
  final _styles = <String>{};
  double _priceLimit = 300;

  static const categories = ['T-shirts', 'Shorts', 'Shirts', 'Hoodie', 'Jeans'];
  static const colors = [
    'green',
    'red',
    'yellow',
    'orange',
    'blue',
    'purple',
    'pink',
    'white',
    'black',
  ];
  static const sizes = [
    'XX-Small',
    'X-Small',
    'Small',
    'Medium',
    'Large',
    'X-Large',
    'XX-Large',
    '3X-Large',
    '4X-Large',
  ];
  static const styles = ['Casual', 'Formal', 'Party', 'Gym'];

  @override
  void initState() {
    super.initState();
    _productsFuture = _repository.fetchProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String get _title => switch (widget.filter) {
    CatalogFilter.newArrivals => 'New Arrivals',
    CatalogFilter.bestSelling => 'Best Selling',
    CatalogFilter.onSale => 'On Sale',
    CatalogFilter.all => 'All Products',
  };

  List<ProductItemModel> _filterProducts(List<ProductItemModel> products) {
    final query = _searchController.text.trim().toLowerCase();
    return products.where((product) {
      final pageMatch = switch (widget.filter) {
        CatalogFilter.newArrivals => product.isNew,
        CatalogFilter.bestSelling => product.isBestSeller,
        CatalogFilter.onSale => product.isOnSale,
        CatalogFilter.all => true,
      };
      return pageMatch &&
          (query.isEmpty || product.name.toLowerCase().contains(query)) &&
          (_categories.isEmpty || _categories.contains(product.category)) &&
          (_colors.isEmpty || product.colors.any(_colors.contains)) &&
          (_sizes.isEmpty || product.sizes.any(_sizes.contains)) &&
          (_styles.isEmpty || _styles.contains(product.dressStyle)) &&
          product.price <= _priceLimit;
    }).toList();
  }

  int get _filterCount =>
      _categories.length +
      _colors.length +
      _sizes.length +
      _styles.length +
      (_priceLimit < 300 ? 1 : 0);

  void _clearFilters() => setState(() {
    _categories.clear();
    _colors.clear();
    _sizes.clear();
    _styles.clear();
    _priceLimit = 300;
  });

  void _toggle(Set<String> selected, String value) => setState(() {
    selected.contains(value) ? selected.remove(value) : selected.add(value);
  });

  @override
  Widget build(BuildContext context) {
    final cartCount = ref
        .watch(cartProvider)
        .values
        .fold<int>(0, (sum, item) => sum + item.quantity);
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'SHOP.CO',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const CartPage())),
          ),
          if (cartCount > 0)
            Padding(
              padding: const EdgeInsets.only(right: 14, top: 20),
              child: Text('$cartCount'),
            ),
        ],
      ),
      body: FutureBuilder<List<ProductItemModel>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final products = _filterProducts(snapshot.data!);
          return LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth > 900
                  ? 4
                  : constraints.maxWidth > 560
                  ? 3
                  : 2;
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _CatalogToolbar(
                      title: _title,
                      controller: _searchController,
                      filterCount: _filterCount,
                      onSearch: () => setState(() {}),
                      onFilters: _showFilters,
                    ),
                  ),
                  if (_filterCount > 0)
                    SliverToBoxAdapter(
                      child: _ActiveFilters(
                        labels: [
                          ..._categories,
                          ..._colors,
                          ..._sizes,
                          ..._styles,
                        ],
                        onClear: _clearFilters,
                      ),
                    ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                      child: Text(
                        'Showing ${products.length} products',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  if (products.isEmpty)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text('No products match these filters'),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(14, 0, 14, 24),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) =>
                              ProductItem(product: products[index]),
                          childCount: products.length,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 14,
                          childAspectRatio: .61,
                        ),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _showFilters() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _FilterSheet(
        categories: _categories,
        colors: _colors,
        sizes: _sizes,
        styles: _styles,
        priceLimit: _priceLimit,
        onToggle: _toggle,
        onPriceChanged: (value) => setState(() => _priceLimit = value),
        onClear: _clearFilters,
        onDone: () => Navigator.pop(context),
      ),
    );
  }
}

class _CatalogToolbar extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final int filterCount;
  final VoidCallback onSearch;
  final VoidCallback onFilters;
  const _CatalogToolbar({
    required this.title,
    required this.controller,
    required this.filterCount,
    required this.onSearch,
    required this.onFilters,
  });
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                onSubmitted: (_) => onSearch(),
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: onSearch,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF2F2F2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            FilledButton.icon(
              onPressed: onFilters,
              icon: const Icon(Icons.tune, size: 18),
              label: Text(
                filterCount == 0 ? 'Filters' : 'Filters ($filterCount)',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _ActiveFilters extends StatelessWidget {
  final List<String> labels;
  final VoidCallback onClear;
  const _ActiveFilters({required this.labels, required this.onClear});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
    child: Wrap(
      spacing: 6,
      children: [
        ...labels.map((label) => Chip(label: Text(label))),
        ActionChip(label: const Text('Clear all'), onPressed: onClear),
      ],
    ),
  );
}

class _FilterSheet extends StatelessWidget {
  final Set<String> categories;
  final Set<String> colors;
  final Set<String> sizes;
  final Set<String> styles;
  final double priceLimit;
  final void Function(Set<String>, String) onToggle;
  final ValueChanged<double> onPriceChanged;
  final VoidCallback onClear;
  final VoidCallback onDone;
  const _FilterSheet({
    required this.categories,
    required this.colors,
    required this.sizes,
    required this.styles,
    required this.priceLimit,
    required this.onToggle,
    required this.onPriceChanged,
    required this.onClear,
    required this.onDone,
  });

  Widget _chips(List<String> values, Set<String> selected) => Wrap(
    spacing: 8,
    children: values
        .map(
          (value) => FilterChip(
            label: Text(value),
            selected: selected.contains(value),
            onSelected: (_) => onToggle(selected, value),
          ),
        )
        .toList(),
  );

  @override
  Widget build(BuildContext context) => SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filters',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
              TextButton(onPressed: onClear, child: const Text('Clear')),
            ],
          ),
          const Text(
            'Categories',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          _chips(_AllProductsPageState.categories, categories),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Price',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('EGP ${priceLimit.round()}'),
            ],
          ),
          Slider(
            value: priceLimit,
            min: 0,
            max: 300,
            divisions: 30,
            onChanged: onPriceChanged,
          ),
          const Text('Colors', style: TextStyle(fontWeight: FontWeight.bold)),
          _chips(_AllProductsPageState.colors, colors),
          const SizedBox(height: 16),
          const Text('Size', style: TextStyle(fontWeight: FontWeight.bold)),
          _chips(_AllProductsPageState.sizes, sizes),
          const SizedBox(height: 16),
          const Text(
            'Dress Style',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          _chips(_AllProductsPageState.styles, styles),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onDone,
              child: const Text('Apply Filters'),
            ),
          ),
        ],
      ),
    ),
  );
}
