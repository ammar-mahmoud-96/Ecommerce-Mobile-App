## Firebase and order email setup

The Flutter app uses Firebase Authentication for email/password login and Cloud Firestore for authenticated order history. SMTP credentials must remain on a server; the app calls the web app's deployed `/api/order` endpoint through `ORDER_API_URL`.

1. Create or select a Firebase project and enable **Authentication > Email/Password** and Firestore.
2. Copy `.env.example` to `.env` and fill in the Firebase app values and your deployed web order endpoint:

```bash
cp .env.example .env
```

3. Configure the web app's server environment with `SMTP_HOST`, `SMTP_PORT`, `SMTP_SECURE`, `SMTP_USER`, `SMTP_PASSWORD`, and `SMTP_FROM`. Do not put SMTP credentials in Flutter or `--dart-define` values.
4. Apply Firestore rules that restrict orders to their authenticated owner:

```text
match /orders/{orderId} {
	allow create: if request.auth != null && request.resource.data.userId == request.auth.uid;
	allow read: if request.auth != null && resource.data.userId == request.auth.uid;
	allow update, delete: if false;
}
```

The app loads `.env` at startup. Without Firebase values, it launches in guest mode. Without `ORDER_API_URL`, checkout displays a configuration error and does not clear the cart. Firebase client keys are bundled into the mobile app and should be protected with Firebase Auth and Firestore rules; SMTP credentials must never be placed in `.env`.

# flutter_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
