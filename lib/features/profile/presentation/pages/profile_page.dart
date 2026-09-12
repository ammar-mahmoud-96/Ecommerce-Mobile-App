import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/firebase/firebase_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  bool emailUpdates = true;
  bool orderNotifications = true;

  @override
  void initState() {
    super.initState();
    if (FirebaseService.isInitialized) {
      FirebaseService.auth.authStateChanges().listen((value) {
        if (mounted) setState(() => user = value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!FirebaseService.isInitialized || user == null) return _guestView();
    final displayName = user!.displayName?.isNotEmpty == true
        ? user!.displayName!
        : 'Shopper';
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
            onPressed: FirebaseService.auth.signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _card(
              'Account overview',
              'Welcome, $displayName',
              user!.email ?? 'Manage your account and orders.',
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                _stat('Orders', '0', 'No orders yet'),
                const SizedBox(width: 8),
                _stat('Saved items', '0', 'Build your wishlist'),
                const SizedBox(width: 8),
                _stat('Addresses', '0', 'Add one at checkout'),
              ],
            ),
            const SizedBox(height: 14),
            _section(
              'Purchase history',
              'Your orders',
              const Text(
                'Your completed orders will appear here.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 14),
            _section(
              'Delivery',
              'Saved addresses',
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add address'),
              ),
            ),
            const SizedBox(height: 14),
            _section(
              'Preferences',
              'Account settings',
              Column(
                children: [
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Email updates'),
                    subtitle: const Text(
                      'Receive news about new arrivals and offers',
                    ),
                    value: emailUpdates,
                    onChanged: (value) => setState(() => emailUpdates = value),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Order notifications'),
                    subtitle: const Text('Get updates about your delivery'),
                    value: orderNotifications,
                    onChanged: (value) =>
                        setState(() => orderNotifications = value),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _guestView() => Scaffold(
    backgroundColor: const Color(0xFFF8F8F8),
    appBar: AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      title: const Text(
        'My Profile',
        style: TextStyle(fontWeight: FontWeight.w900),
      ),
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Sign in to see your profile',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                FirebaseService.isInitialized
                    ? 'Access your orders, addresses, and preferences.'
                    : 'Configure Firebase to enable account access.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              if (FirebaseService.isInitialized)
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _showAuthDialog,
                    child: const Text('Sign in or create account'),
                  ),
                ),
            ],
          ),
        ),
      ),
    ),
  );

  Future<void> _showAuthDialog() async {
    final email = TextEditingController();
    final password = TextEditingController();
    final name = TextEditingController();
    var create = false;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, update) => AlertDialog(
          title: Text(create ? 'Create account' : 'Sign in'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (create)
                TextField(
                  controller: name,
                  decoration: const InputDecoration(labelText: 'Full name'),
                ),
              TextField(
                controller: email,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: password,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => update(() => create = !create),
              child: Text(create ? 'Sign in instead' : 'Create account'),
            ),
            FilledButton(
              onPressed: () async {
                try {
                  if (create) {
                    await FirebaseService.createAccount(
                      name.text,
                      email.text,
                      password.text,
                    );
                  } else {
                    await FirebaseService.signIn(email.text, password.text);
                  }
                  if (dialogContext.mounted) Navigator.pop(dialogContext);
                } on FirebaseAuthException catch (error) {
                  if (dialogContext.mounted) {
                    ScaffoldMessenger.of(dialogContext).showSnackBar(
                      SnackBar(
                        content: Text(
                          error.message ?? 'Authentication failed.',
                        ),
                      ),
                    );
                  }
                }
              },
              child: Text(create ? 'Create' : 'Sign in'),
            ),
          ],
        ),
      ),
    );
    email.dispose();
    password.dispose();
    name.dispose();
  }

  Widget _card(String label, String title, String body) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 11,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 6),
        Text(body, style: const TextStyle(color: Colors.grey)),
      ],
    ),
  );
  Widget _stat(String title, String value, String caption) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
          ),
          Text(
            caption,
            style: const TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ],
      ),
    ),
  );
  Widget _section(String label, String title, Widget child) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 11,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 14),
        child,
      ],
    ),
  );
}
