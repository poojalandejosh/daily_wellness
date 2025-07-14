# DailyWellness – Personal Wellness Tracker App

## Project Overview
DailyWellness is a Flutter application designed to help users track their daily wellness activities, such as hydration, meditation, and exercise, while providing motivational content. The app demonstrates core Flutter concepts including UI design, state management, API integration, testing, and deployment.

---

## Features

- **Login Screen**: Email and password fields with validation (no backend, just format and required checks). Successful login navigates to the dashboard.
- **Dashboard Screen**:
  - Personalized greeting with user’s name
  - List of wellness tasks (hardcoded and user-added)
  - Current date and time display
  - Fetches and displays a motivational quote from an API
  - Button to add custom activities
- **Add Activity Screen**: Form to add new activities with validation and optional notes.
- **State Management**: Uses `setState` for basic state, later refactored to use `Provider`.
- **Responsive UI**: Works in both portrait and landscape modes using `MediaQuery` and `LayoutBuilder`.
- **Networking**: Integrates with an external API to fetch motivational quotes.
- **Testing**: Includes unit and widget tests for utility functions and form validation.
- **Deployment**: Instructions to build and test a signed release APK.

---

## Tech Stack
- **Flutter SDK**: 3.x
- **Dart**
- **Packages**: `http`, `provider` (or `flutter_riverpod`)
- **Tools**: Android Studio / VS Code

---

## Setup Instructions

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd daily_wellness
   ```
2. **Install dependencies**
   ```bash
   flutter pub get
   ```
3. **Run the app**
   ```bash
   flutter run
   ```
4. **Testing**
   - Run all tests:
     ```bash
     flutter test
     ```

---

## API Used
- **Motivational Quotes**: [FavQs Quote of the Day](https://favqs.com/api/qotd)
  - Endpoint: `https://favqs.com/api/qotd`
  - Used to fetch and display a daily motivational quote on the dashboard.

---

## Screenshots
<!-- Add screenshots of Login, Dashboard, and Add Activity screens here -->

---

## Known Issues
- No backend authentication; login is local-only.
- Activities are not persisted after app restart (no local storage).
- Only one user supported.

---

## Deployment: Building a Release APK
1. **Build the APK**
   ```bash
   flutter build apk --release
   ```
2. **Locate the APK**
   - The release APK will be at `build/app/outputs/flutter-apk/app-release.apk`
3. **Test the APK**
   - Transfer the APK to your Android device or emulator and install it.
   - Open the app and verify all features work as expected.

--

## Success Criteria
- All features implemented as described
- Clean, maintainable code
- Responsive, professional UI
- State management with both `setState` and `Provider`
- API integration for quotes

APK


todo task 

fix button position 
quote and button position 

login-> session management -> shared-preference - async storrage 
spalshscreen /appicon 
dialog box cross icon
logout button 
modal class for json convertor
  // 'quote': data['quote']['body'] ?? 'No quote found',
  //         'author': data['quote']['author'] ?? 'Unknown',
mark completed task
notes description (limits letters )