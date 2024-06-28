<<<<<<< HEAD
# customer_management

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
=======
Customer Management App
Customer Management App is a mobile application built with Flutter that allows users to manage customer information seamlessly. Whether you're adding new customers, searching for existing ones, updating details, or removing entries, this app provides a user-friendly interface and robust functionality.

Features
Add Customer Information: Create new customer profiles with validation for email format, phone number, and name requirements. Upload profile pictures to enhance customer profiles.

Search Customers: Quickly find customers by name or email using the search feature.

Edit Customer Information: Update customer details with validation to ensure data accuracy.

Delete Customer Information: Remove customer entries securely with a confirmation prompt to prevent accidental deletions.

User Interface: Enjoy a clean and intuitive UI with smooth transitions and animations for a pleasant user experience.

Technical Stack
Flutter: Developed using Flutter framework for cross-platform compatibility and performance.

Firebase: Utilizes Firebase Firestore for real-time database operations to store and retrieve customer data securely. Firebase Storage manages profile pictures efficiently.

State Management: Implements Provider package for efficient state management across the app.

Installation
Clone the repository:

  bash
  Copy code
  git clone https://github.com/Tkenthiran98/customer_management_app.git
  Install dependencies:

bash
  Copy code
  flutter pub get
  Firebase Setup:

Create a Firebase project in the Firebase Console.
Register your app with Firebase and follow the setup instructions for both Android and iOS platforms.
collection name: customers
field:
 contact (string)
 dob (timestamp)
 email (string)
 id (string)
 name (string)
 profilePictureUrl(string)

Download the necessary configuration files (google-services.json for Android, GoogleService-Info.plist for iOS) and place them in their respective directories (android/app/ and ios/Runner/).


Run the app:
bash
Copy code
flutter run
Project Structure
css
Copy code
customer_management/
├── android/
├── ios/
├── lib/
│   ├── models/
│   │   └── customer.dart
│   ├── screens/
│   │   ├── add_customer_screen.dart
│   │   ├── customer_list_screen.dart
│   │   ├── edit_customer_screen.dart
│   │   └── ...
│   ├── services/
│   │   └── customer_service.dart
│   ├── main.dart
│   └── ...
├── pubspec.yaml
 

Directory Structure Explanation
  android/ and ios/: Native code directories for Android and iOS platforms respectively.
  lib/: Contains all Dart code for the application.
  models/: Data models including customer.dart.
  screens/: UI screens such as add_customer_screen.dart, customer_list_screen.dart, etc.
  services/: Backend services including customer_service.dart for Firebase integration.
  main.dart: Entry point of the application.
  pubspec.yaml: Flutter dependency configuration file.
 
>>>>>>> 3716fa8a44c35a82a14defe975a580f5bd4e2e81
