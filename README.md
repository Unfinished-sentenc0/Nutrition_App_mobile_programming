
# Healthy Diet App

## Overview

The **Healthy Diet App** is a mobile application designed to provide dietary advice and support for users with various health conditions. Users can interact with nutritionist chat bot, read informative articles, and manage their dietary needs efficiently. This app also features a role-based system including users, nutritionists, and a master admin for managing the application.

## Features

- **User Registration and Login**: Users can sign up and log in to access the app’s features.
- **Nutritionist Registration**: Nutritionists can sign up with additional details and await admin approval.
- **FAQ Management**: Nutritionists can add articles in the form of FAQs with optional images.
- **Messaging System**: Users can send messages to nutritionists and receive responses.
- **Profile Management**: Users can view and update their profile details.
- **Help Section**: Provides users with information about the app's features.

## Project Structure

The project is structured as follows:

- `lib/Authtentication/`: Contains the authentication screens (login and signup).
- `lib/JsonModels/`: Contains the user model classes.
- `lib/SQLite/`: Contains SQLite database helper classes.
- `lib/Views/`: Contains the main screens for the app (home, help, notes, etc.).

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Android Studio or Visual Studio Code
- SQLite database

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/healthy_diet_app.git
   cd healthy_diet_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

### Configuration

Ensure you have the necessary setup for running Flutter applications, including an emulator or a physical device connected.

### Key Components

#### Login Screen (`lib/Authtentication/login.dart`)

Handles user login functionality, including validation and navigation based on user roles.

#### Signup Screen (`lib/Authtentication/signup.dart`)

Handles user and nutritionist registration with form validation and database integration.

#### Database Helper (`lib/SQLite/sqlite.dart`)

Manages database operations, including user and nutritionist signup and login.

#### Home Screen (`lib/Views/notes.dart`)

The main screen for users displaying FAQs and articles posted by nutritionists.

#### Help Screen (`lib/Views/help_screen.dart`)

Provides users with guidance and information about the app's features.

## Usage

1. **User Signup and Login:**
   - Users can sign up with their email, username, and password.
   - Login with the registered credentials to access the app.

2. **Nutritionist Signup:**
   - Nutritionists can sign up with additional details (qualification image and description).
   - Await admin approval before logging in.

3. **FAQ Management:**
   - Nutritionists can log in to add FAQs and articles.
   - Articles can include text and optional images.

4. **Messaging:**
   - Users can send messages to nutritionists.
   - Nutritionists can view and reply to user messages.

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes.
