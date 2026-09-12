import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseService {
  FirebaseService._();

  static bool isInitialized = false;

  static FirebaseAuth get auth => FirebaseAuth.instance;

  static Future<void> initialize() async {
    final apiKey = dotenv.env['FIREBASE_API_KEY'];
    final appId = dotenv.env['FIREBASE_APP_ID'];
    final messagingSenderId = dotenv.env['FIREBASE_MESSAGING_SENDER_ID'];
    final projectId = dotenv.env['FIREBASE_PROJECT_ID'];

    if (appId?.contains(':web:') == true) {
      return;
    }

    if ([apiKey, appId, messagingSenderId, projectId].any(
      (value) => value == null || value.isEmpty,
    )) {
      return;
    }

    try {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: apiKey!,
          appId: appId!,
          messagingSenderId: messagingSenderId!,
          projectId: projectId!,
          storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
          iosClientId: dotenv.env['FIREBASE_IOS_CLIENT_ID'],
        ),
      );
      isInitialized = true;
    } on FirebaseException catch (error) {
      if (error.code == 'duplicate-app') {
        isInitialized = true;
        return;
      }
      // Fall back to guest mode; do not crash the app on startup.
      debugPrint('Firebase init failed: ${error.code} ${error.message}');
    } catch (error, stack) {
      debugPrint('Firebase init failed: $error\n$stack');
    }
  }

  static Future<UserCredential> createAccount(
    String name,
    String email,
    String password,
  ) async {
    final credential = await auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    await credential.user?.updateDisplayName(name.trim());
    return credential;
  }

  static Future<UserCredential> signIn(String email, String password) {
    return auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  static Future<void> saveOrder({
    required Map<String, dynamic> contact,
    required Map<String, dynamic> delivery,
    required String paymentMethod,
    required String discountCode,
    required List<Map<String, dynamic>> items,
    required double subtotal,
    required double totalSavings,
  }) async {
    final user = auth.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance.collection('orders').add({
      'userId': user.uid,
      'contact': contact,
      'delivery': delivery,
      'paymentMethod': paymentMethod,
      'discountCode': discountCode,
      'items': items,
      'subtotal': subtotal,
      'totalSavings': totalSavings,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> sendOrderEmail({
    required Map<String, dynamic> contact,
    required Map<String, dynamic> delivery,
    required String paymentMethod,
    required String discountCode,
    required List<Map<String, dynamic>> items,
    required double subtotal,
  }) async {
  //   final endpoint = dotenv.env['ORDER_API_URL'];
  //   if (endpoint == null || endpoint.isEmpty) {
  //     throw StateError('ORDER_API_URL is not configured.');
  //   }

  //   final response = await http.post(
  //     Uri.parse(endpoint),
  //     headers: const {'Content-Type': 'application/json'},
  //     body: jsonEncode({
  //       'contact': contact,
  //       'delivery': delivery,
  //       'paymentMethod': paymentMethod,
  //       'discountCode': discountCode,
  //       'items': items,
  //       'subtotal': subtotal,
  //     }),
  //   );

  //   if (response.statusCode < 200 || response.statusCode >= 300) {
  //     throw StateError('Order email failed (${response.statusCode}).');
  //   }
  }
}
