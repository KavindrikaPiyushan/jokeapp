# Jokes App with Caching

## Overview
The **Jokes App** is a Flutter-based mobile application that fetches and displays 5 jokes using the [Jokes API](https://v2.jokeapi.dev/). It features offline functionality by caching jokes using the `shared_preferences` package, ensuring users can view jokes even without an internet connection.

---

## Features
- Fetches 5 jokes from the Jokes API.
- Caches jokes locally for offline use.
- Automatically displays cached jokes when offline.
- Neat and simple UI.

---

## Technologies Used
- **Flutter**: Framework for building the app.
- **HTTP**: For API integration.
- **Shared Preferences**: For caching jokes locally.

---

## Installation
### Prerequisites
Ensure you have the following installed:
- Flutter SDK
- Android Studio or Visual Studio Code with Flutter extension
- A device or emulator to run the app

### Steps
1. Clone the repository:
   ```bash
   git clone <repository-link>
   ```
2. Navigate to the project directory:
   ```bash
   cd jokes_app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

---

## Usage
1. Launch the app.
2. If connected to the internet:
   - The app fetches and displays 5 jokes from the Jokes API.
   - The jokes are cached locally for future offline use.
3. If offline:
   - The app automatically displays previously cached jokes.
   - Ensure the app was run at least once online to cache jokes.

---

## Challenges & Solutions (Optional)
- **Challenge**: Managing offline scenarios when no cached jokes exist.
  - **Solution**: Display an appropriate message to the user if no data is available offline.
- **Challenge**: Ensuring smooth deserialization of complex JSON data.
  - **Solution**: Utilized structured models and error handling.

---


## Contribution
Feel free to submit issues or pull requests to improve this project!

---


