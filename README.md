# E-Commerce Mobile App

A modern Flutter e-commerce mobile application built to provide a complete shopping experience, including product browsing, authentication, cart management, checkout, and order history.

The application uses Firebase Authentication for user authentication and Cloud Firestore for authenticated order history. Checkout communicates with a deployed web API for order processing and email notifications.

## Features

- Browse and explore products
- Product search
- Product categories
- Add products to cart
- Increase/decrease product quantities
- Remove products from cart
- Wishlist/favorites
- User registration and login
- Authenticated user experience
- Order history
- Checkout flow
- Order email notifications
- Internet connectivity detection
- Local data persistence
- Localization support
- Responsive Flutter UI

## Tech Stack

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform mobile application framework |
| Dart | Programming language |
| Riverpod | State management |
| Firebase Authentication | User authentication |
| Cloud Firestore | Order history and user data |
| HTTP | API communication |
| SharedPreferences | Local storage |
| flutter_dotenv | Environment configuration |
| Dartz | Functional programming utilities |
| Equatable | Value equality |
| Flutter SVG | SVG asset rendering |
| Intl | Internationalization and formatting |

## Project Structure

```text
Ecommerce-Mobile-App/
├── android/                # Android platform files
├── ios/                    # iOS platform files
├── linux/                  # Linux platform files
├── macos/                  # macOS platform files
├── web/                    # Web platform files
├── lib/                    # Main Flutter application
├── test/                   # Tests
├── assets/
│   ├── images/
│   ├── images/products/
│   └── icons/
├── .env                    # Local environment configuration
├── pubspec.yaml            # Flutter dependencies and configuration
├── pubspec.lock
└── README.md
