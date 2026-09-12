import 'package:flutter/material.dart';
import 'package:flutter_app/features/all_products/presentation/providers/cart_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/core/firebase/firebase_service.dart';
//
class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key});
  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final phone = TextEditingController();
  final name = TextEditingController();
  final address = TextEditingController();
  final discountCode = TextEditingController();
  String? governorate;
  bool submitting = false;

  @override
  void dispose() {
    email.dispose();
    phone.dispose();
    name.dispose();
    address.dispose();
    discountCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final items = cart.values.toList();
    final subtotal = ref.read(cartProvider.notifier).totalPrice;
    final savings = subtotal * .2;
    const delivery = 15.0;
    final total = subtotal - savings + delivery;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'SHOP.CO',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: items.isEmpty
          ? const Center(child: Text('Your cart is empty.'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final details = _DetailsForm(
                    formKey: formKey,
                    email: email,
                    phone: phone,
                    name: name,
                    address: address,
                    discountCode: discountCode,
                    governorate: governorate,
                    onGovernorateChanged: (value) =>
                        setState(() => governorate = value),
                  );
                  final summary = _Summary(
                    items: items,
                    subtotal: subtotal,
                    savings: savings,
                    delivery: delivery,
                    total: total,
                    submitting: submitting,
                    onPlaceOrder: _placeOrder,
                  );
                  return constraints.maxWidth > 760
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: details),
                            const SizedBox(width: 24),
                            SizedBox(width: 340, child: summary),
                          ],
                        )
                      : Column(
                          children: [
                            summary,
                            const SizedBox(height: 18),
                            details,
                          ],
                        );
                },
              ),
            ),
    );
  }

  Future<void> _placeOrder() async {
    if (!formKey.currentState!.validate()) return;
    setState(() => submitting = true);
    final cartItems = ref.read(cartProvider).values.toList();
    final subtotal = ref.read(cartProvider.notifier).totalPrice;
    final items = cartItems
        .map(
          (item) => <String, dynamic>{
            'id': item.product.id,
            'title': item.product.name,
            'price': item.product.price,
            'quantity': item.quantity,
            if (item.product.image != null) 'image': item.product.image,
          },
        )
        .toList();
    final contact = {
      'email': email.text.trim(),
      'phoneCountryCode': '+20',
      'phone': phone.text.trim(),
    };
    final delivery = {
      'fullName': name.text.trim(),
      'governorate': governorate,
      'address': address.text.trim(),
    };
    try {
      // await FirebaseService.sendOrderEmail(
      //   contact: contact,
      //   delivery: delivery,
      //   paymentMethod: 'cash',
      //   discountCode: discountCode.text.trim(),
      //   items: items,
      //   subtotal: subtotal,
      // );
      // if (FirebaseService.isInitialized) {
      //   await FirebaseService.saveOrder(
      //     contact: contact,
      //     delivery: delivery,
      //     paymentMethod: 'cash',
      //     discountCode: discountCode.text.trim(),
      //     items: items,
      //     subtotal: subtotal,
      //     totalSavings: subtotal * .2,
      //   );
      // }
      if (!mounted) return;
      ref.read(cartProvider.notifier).clearCart();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your order has been sent successfully.')),
      );
      Navigator.pop(context);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString().replaceFirst('Bad state: ', '')),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => submitting = false);
    }
  }
}

class _DetailsForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController email, phone, name, address, discountCode;
  final String? governorate;
  final ValueChanged<String?> onGovernorateChanged;
  const _DetailsForm({
    required this.formKey,
    required this.email,
    required this.phone,
    required this.name,
    required this.address,
    required this.discountCode,
    required this.governorate,
    required this.onGovernorateChanged,
  });

  InputDecoration decoration(String hint, {IconData? icon}) => InputDecoration(
    hintText: hint,
    prefixIcon: icon == null ? null : Icon(icon),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFFE5E5E5)),
    ),
  );
  Widget field(
    TextEditingController controller,
    String hint, {
    bool required = false,
    TextInputType? type,
    IconData? icon,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(
      controller: controller,
      keyboardType: type,
      decoration: decoration(hint, icon: icon),
      validator: required
          ? (value) => value == null || value.trim().isEmpty ? 'Required' : null
          : null,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 14),
          field(
            email,
            'your.email@gmail.com',
            type: TextInputType.emailAddress,
            icon: Icons.mail_outline,
          ),
          field(
            phone,
            'Phone number',
            required: true,
            type: TextInputType.phone,
            icon: Icons.phone_outlined,
          ),
          const SizedBox(height: 12),
          const Text(
            'Delivery',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 14),
          field(name, 'Full name', required: true, icon: Icons.person_outline),
          DropdownButtonFormField<String>(
            initialValue: governorate,
            decoration: decoration('Select Governorate'),
            items: const [
              DropdownMenuItem(value: 'Cairo', child: Text('Cairo')),
              DropdownMenuItem(value: 'Giza', child: Text('Giza')),
              DropdownMenuItem(value: 'Alexandria', child: Text('Alexandria')),
            ],
            onChanged: onGovernorateChanged,
            validator: (value) => value == null ? 'Required' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: address,
            maxLines: 3,
            decoration: decoration('Address'),
            validator: (value) =>
                value == null || value.trim().isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 18),
          const Text(
            'Discount Code',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: discountCode,
                  decoration: decoration('Discount code'),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton(onPressed: () {}, child: const Text('Apply')),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Payment',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
            ),
            child: const Row(
              children: [
                Icon(Icons.payments_outlined),
                SizedBox(width: 12),
                Text(
                  'Cash on Delivery',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  final List<CartItem> items;
  final double subtotal, savings, delivery, total;
  final bool submitting;
  final VoidCallback onPlaceOrder;
  const _Summary({
    required this.items,
    required this.subtotal,
    required this.savings,
    required this.delivery,
    required this.total,
    required this.submitting,
    required this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 16),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Image.asset(
                    item.product.image ?? '',
                    width: 56,
                    height: 56,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) =>
                        const SizedBox(width: 56, height: 56),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '${item.product.name}\nx${item.quantity}',
                      maxLines: 2,
                    ),
                  ),
                  Text(
                    'EGP ${item.totalPrice.toStringAsFixed(0)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          row('Subtotal', subtotal),
          row('Discount (-20%)', savings, negative: true),
          row('Delivery Fee', delivery),
          const Divider(),
          row('Total', total, bold: true),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: submitting ? null : onPlaceOrder,
              child: Text(submitting ? 'Sending...' : 'Place Order'),
            ),
          ),
        ],
      ),
    );
  }

  Widget row(
    String label,
    double value, {
    bool bold = false,
    bool negative = false,
  }) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          '${negative ? '-' : ''}EGP ${value.abs().toStringAsFixed(0)}',
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            color: negative ? Colors.red : null,
          ),
        ),
      ],
    ),
  );
}
