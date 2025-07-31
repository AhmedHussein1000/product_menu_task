# product_menu_task

A Flutter application displaying a product menu with Bloc state management and Sqflite for data persistence.

## How to Run the App and Populate Demo Data

1. Run the application:

# 1. Clone the repository
git clone https://github.com/AhmedHussein1000/product_menu_task.git

# 2. Navigate to the project directory
cd product_menu_task

# 3. Get dependencies
flutter pub get

# 4. Run the app
flutter run
   

Demo data is automatically populated using Sqflite when the database is initialized in `lib/data/database_helper.dart`, inserting initial products and categories.

## 🤖 AI Prompts & Responses
🔹 Prompt 1
"Create a Flutter screen called ProductsScreen that shows a food menu UI like Burger King, using local data stored in sqflite and managed by Cubit..."
(Full prompt included model, database setup, cubit, UI details, skeletonizer, responsiveness, and folder structure.)

✔️ Applied in:

models/product_model.dart

data/database_helper.dart

cubit/products_cubit.dart & products_state.dart

screens/products_screen.dart

widgets/product_card.dart, cart_button.dart, category_list.dart

main.dart

🔹 Prompt 2
"Add the packages that you used."

✔️ Applied in:

Updated pubspec.yaml with sqflite, flutter_bloc, skeletonizer, path, etc.

Ran flutter pub get to install dependencies.

🔹 Prompt 3
"Create customSnackBar function in core/functions/ and use it with every tappable element to show a relevant message."

✔️ Applied in:

Created core/functions/custom_snackbar.dart

Used in ProductsScreen for category taps, product taps, and search icon.

🔹 Prompt 4
"Create a screen [make it home] with a button at the center; when user clicks on it, navigate to ProductsScreen."

✔️ Applied in:

screens/home_screen.dart with centered button

Updated main.dart to use HomeScreen as initial screen

🔹 Prompt 5
"In initialProducts, update category to be 'Best Offers'. I need these products to show only when the user selects 'Best Offers' category."

✔️ Applied in:

database_helper.dart — set all initial products’ categories to أفضل العروض

products_cubit.dart — updated filter logic to show 'Best Offers' only when selected

🔹 Prompt 6
"I need two things: 1) Make 'Best Offers' the default selected category, 2) Replace hardcoded texts with a constants class."

✔️ Applied in:

products_cubit.dart — default category set to Constants.bestOffers

constants.dart — all category texts centralized

database_helper.dart and products_cubit.dart updated to use constants

## 📸 Screenshot Comparison
<img width="1101" height="969" alt="Screenshot (81)" src="https://github.com/user-attachments/assets/3b28231c-0b51-4c55-9274-3bb7d0ed1908" />


## Project Structure

```
lib/
├── core/
│   ├── constants.dart
│   ├── functions/
│   │   └── custom_snackbar.dart
│   ├── helpers/
│   │   ├── dummy_data.dart
│   │   └── size_config.dart
│   └── utils/
│       ├── app_styles.dart
│       └── constants.dart
├── models/
│   └── product_model.dart
│
├── cubit/
│   ├── products_cubit.dart
│   └── products_state.dart
│
├── data/
│   └── database_helper.dart
│
├── screens/
│   ├── home_screen.dart
│   └── products_screen.dart
│
├── widgets/
│   ├── cart_button.dart
│   ├── product_card.dart
│   ├── categories_section.dart
│   ├── category_item.dart
│   ├── product_card_item.dart
│   └── products_grid.dart
│
└── main.dart
```

## Used Tools

- Flutter
- Dart
- Sqflite
- Bloc/Cubit
- AI assistance
