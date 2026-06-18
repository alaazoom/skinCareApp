![Task Manager Banner](mmm.jpg)

# 🌸 Skin Care Store App

A modern and scalable E-Commerce mobile application for skincare products built with **Flutter** and **Dart**, following **Clean Architecture** principles and using **BLoC State Management**. The application provides a smooth shopping experience with product browsing, filtering, favorites, cart management, address handling, coupon system, and a responsive UI with loading effects.

---

## 📱 Features

### 🛍️ Product Management

* Display all skincare products from REST APIs.
* Product details screen.
* Search products by name.
* Category-based product listing.
* Product filtering and sorting.
* Pagination and optimized API requests.

### ❤️ Favorites

* Add products to favorites.
* Remove products from favorites.
* Persist favorite items locally.
* Real-time UI updates using BLoC.

### 🛒 Shopping Cart

* Add products to cart.
* Remove products from cart.
* Increase and decrease product quantity.
* Calculate total price automatically.
* Cart state management with BLoC.

### 📍 Address Management

* Add new addresses.
* Edit addresses.
* Delete addresses.
* Select default shipping address.
* Manage multiple delivery addresses.

### 🎟️ Coupon System

* Apply discount coupons.
* Validate coupon codes through API.
* Calculate discounted prices dynamically.
* Display coupon status and error messages.

### 🔍 Search & Filters

* Search by product name.
* Filter by category.
* Filter by price range.
* Sorting:

  * Price (Low → High)
  * Price (High → Low)
  * Newest Products
  * Best Sellers

### ✨ Loading Experience

* Shimmer loading effect while fetching data.
* Skeleton screens for products and details pages.
* Smooth transitions and animations.

### 🔔 Navigation

Application includes a complete navigation flow:

* Splash Screen
* Onboarding Screens
* Authentication Screens
* Home Screen
* Categories Screen
* Product Details Screen
* Search Screen
* Favorites Screen
* Cart Screen
* Address Screen
* Coupon Screen
* Profile Screen
* Settings Screen
* Checkout Screen
* Order Confirmation Screen

---

## 🏗️ Architecture

The project follows:

* Clean Architecture
* Feature-Based Structure
* Repository Pattern
* Dependency Injection
* SOLID Principles
* BLoC State Management

### Project Structure

```bash
lib/
│
├── core/
│   ├── constants/
│   ├── errors/
│   ├── network/
│   ├── services/
│   ├── theme/
│   └── widgets/
│
├── features/
│   ├── auth/
│   ├── home/
│   ├── products/
│   ├── categories/
│   ├── favorites/
│   ├── cart/
│   ├── address/
│   ├── coupons/
│   ├── checkout/
│   ├── profile/
│   └── settings/
│
├── models/
├── repositories/
├── blocs/
├── routes/
└── main.dart
```

---

## 🧰 Technologies Used

* Flutter
* Dart
* REST API
* BLoC (flutter_bloc)
* Equatable
* Dio / HTTP
* Shimmer
* Shared Preferences
* Cached Network Image
* Flutter ScreenUtil
* Dependency Injection (GetIt)
* JSON Serialization

---

## 📦 Main Packages

```yaml
dependencies:
  flutter_bloc:
  equatable:
  dio:
  shimmer:
  shared_preferences:
  cached_network_image:
  flutter_screenutil:
  get_it:
  json_annotation:
```

---

## 🔄 State Management

The application uses **BLoC Pattern** for:

* Authentication
* Products
* Categories
* Search
* Filters
* Favorites
* Cart
* Addresses
* Coupons
* Checkout
* Profile
* Settings

Each feature contains:

* Events
* States
* Bloc/Cubit
* Repository
* Data Source
* Models

---

## 🌐 API Integration

The app consumes REST APIs for:

* Authentication
* Products
* Categories
* Product Details
* Search
* Favorites
* Cart
* Addresses
* Coupons
* Orders
* User Profile

---

## 🚀 Performance Optimizations

* Shimmer loading screens.
* Lazy loading and pagination.
* Cached network images.
* Optimized API calls.
* Efficient state management with BLoC.
* Feature-based architecture for scalability.
* Reusable widgets and components.

---

## 🎯 App Highlights

✅ Clean Architecture
✅ REST API Integration
✅ BLoC State Management
✅ Shimmer Loading Effect
✅ Search & Filtering System
✅ Favorites Management
✅ Shopping Cart System
✅ Address Management
✅ Coupon System
✅ Checkout Flow
✅ Responsive UI
✅ Reusable Components
✅ Scalable Project Structure
✅ Production Ready

---

# 👨‍💻 Developed With Flutter & Dart

A complete skincare e-commerce application designed with modern Flutter development practices, scalable architecture, and a smooth user experience.
