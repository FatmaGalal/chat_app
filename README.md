# Chat App

A Flutter chat application backed by Firebase Authentication and Cloud Firestore.

The app currently includes:

- Email/password registration and login
- Real-time chat messages from Firestore
- Route-based navigation between login, register, and chat screens
- BLoC-based state management for login, registration, and chat flows

## Current Branch

The current working branch is `refactor/state-management-bloc`.

This branch reflects an in-progress migration from Cubit-based state handling to BLoC.

## Tech Stack

- Flutter
- Dart
- Firebase Core
- Firebase Authentication
- Cloud Firestore
- `flutter_bloc`
- `modal_progress_hud_nsn`

## Project Structure

Key folders in `lib/`:

- `blocs/`
  - `bloc/`: chat BLoC
  - `login_bloc/`: login BLoC
  - `register_bloc/`: registration BLoC
- `pages/`
  - `login_page.dart`
  - `register_page.dart`
  - `chat_page.dart`
- `models/`
  - `message.dart`
- `widgets/`
  - reusable UI widgets such as buttons, text fields, and chat bubbles

## Application Flow

1. The app starts in `lib/main.dart`.
2. Firebase is initialized before `runApp`.
3. `MultiBlocProvider` provides:
   - `LoginBloc`
   - `RegisterBloc`
   - `ChatBloc`
4. The default screen is the login page.
5. After successful authentication, the user navigates to the chat page.
6. The chat page reads and sends messages through Firestore.

## State Management

The app now uses BLoC for feature state:

- `LoginBloc` handles login submission and authentication states.
- `RegisterBloc` handles account creation and registration states.
- `ChatBloc` handles chat startup, message submission, and incoming message updates.

This branch replaces the older `cubit/` approach with explicit events and states.

## Firebase Requirements

This project expects Firebase to be configured locally.

Important files already present in the repo include:

- `lib/firebase_options.dart`
- `firebase.json`
- `firestore.rules`
- `firestore.indexes.json`

Before running the app, make sure your Firebase project is set up correctly for the platforms you want to use.

## Getting Started

1. Install Flutter.
2. Install project dependencies:

```bash
flutter pub get
```

3. Make sure Firebase configuration is valid for your environment.
4. Run the app:

```bash
flutter run
```

## Useful Commands

Run static analysis:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

## Notes

- The chat feature depends on Firestore documents in the `messages` collection.
- Authentication currently uses email and password through Firebase Auth.
- Some BLoC migration work is still being refined on this branch, especially around chat message loading behavior.
