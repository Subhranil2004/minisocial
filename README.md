# MiniSocial 📱

A modern Flutter-based social media chat application with Firebase integration. Share your thoughts, connect with users, and enjoy a seamless social experience with both light and dark mode support.

## ✨ Features

- **User Authentication** - Secure login and registration with Firebase Auth
- **Real-time Posts** - Share posts and see updates in real-time using Firestore
- **User Profiles** - Personalized user profiles and settings
- **User Discovery** - Browse and connect with other users
- **Dark/Light Theme** - Automatic theme switching based on system preference
- **Cross-platform** - Supports Android, iOS, Web, Windows, macOS, and Linux
- **Responsive Design** - Beautiful UI that works across all screen sizes

## 🛠️ Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Firebase
  - Firebase Auth (Authentication)
  - Cloud Firestore (Database)
  - Firebase Core
- **State Management**: Provider
- **UI**: Material Design with custom themes

## 📋 Prerequisites

Before running this project, make sure you have:

- Flutter SDK (^3.9.2)
- Dart SDK
- Firebase project set up
- Android Studio / VS Code
- Git

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/Subhranil2004/minisocial.git
cd minisocial
```

### 2. Install Dependencies

```bash
flutter pub get
```

<!--
### 3. Firebase Setup

1. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Enable Authentication (Email/Password)
3. Create a Firestore database
4. Add your platform-specific configuration files:
   - `android/app/google-services.json` (Android)
   - `ios/Runner/GoogleService-Info.plist` (iOS)
   - Update `lib/firebase_options.dart` with your config -->

### 3. Run the Application

```bash
# For development
flutter clean
flutter pub get
flutter pub run flutter_launcher_icons
flutter run
```

## 📱 Screenshots

_TODO: Add screenshots of the app_

## 🏗️ Project Structure

```
lib/
├── auth/                 # Authentication logic
│   ├── auth.dart
│   └── login_or_register.dart
├── components/           # Reusable UI components
│   ├── my_button.dart
│   ├── my_drawer.dart
│   ├── my_post_card.dart
│   └── my_textfield.dart
├── database/             # Database operations
│   └── firestore.dart
├── helper/               # Utility functions
│   └── helper_functions.dart
├── pages/                # Application screens
│   ├── home_page.dart
│   ├── login_page.dart
│   ├── profile_page.dart
│   ├── register_page.dart
│   └── users_page.dart
├── theme/                # App themes
│   ├── dark_mode.dart
│   └── light_mode.dart
└── main.dart            # Entry point
```

## 🎨 Features Overview

### Authentication System

- **Login/Register**: Secure user authentication with email and password
- **Auto Login**: Persistent user sessions
- **Error Handling**: Comprehensive error messages and validation

### Social Features

- **Post Creation**: Share your thoughts with the community
- **Real-time Feed**: See posts from all users in real-time
- **User Profiles**: View and edit your profile information
- **User Directory**: Discover and connect with other users

### UI/UX

- **Material Design**: Modern and intuitive interface
- **Theme Support**: Automatic dark/light mode switching
- **Responsive**: Works beautifully on all screen sizes
- **Custom Components**: Reusable and consistent UI elements

---

_Made with ❤️ by Subhranil2004_  
_Feel free to contribute, report issues, or suggest features!_
