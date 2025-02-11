# User Directory App - Technical Documentation

## Project Overview
A Flutter application that displays a list of users, allows searching through them, and shows detailed information in a popup. The application follows clean architecture principles and uses minimal external dependencies.

## Technical Specifications

### Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
  provider: ^6.0.5
```

### Project Structure
```
lib/
  ├── models/
  │   └── user_model.dart      # Data models
  ├── providers/
  │   └── user_provider.dart   # State management
  ├── services/
  │   └── user_service.dart    # API services
  ├── screens/
  │   └── users_page.dart      # UI screens
  └── main.dart               # App entry point
```

### Architecture Components

#### 1. Models
- `UserModel`: Represents user data structure
- `Address`: Handles address-related data
- `Geo`: Manages geographical coordinates

#### 2. Services
`UserService` handles all API interactions:
- Base URL: https://jsonplaceholder.typicode.com
- Photo URL: https://picsum.photos/id
- Endpoints:
  - GET /users: Fetch user list
  - GET /id/{id}/info: Fetch user photo

#### 3. State Management
`UserProvider` manages application state using Provider pattern:
- User list management
- Search functionality
- Loading states
- Error handling

#### 4. UI Components
`UsersPage` implements the main interface:
- Responsive design
- Search functionality
- User list display
- Detail popup

### Key Features

1. **User Listing**
   - Fetches users from API
   - Displays in scrollable list
   - Shows user photo, name, and username

2. **Search Functionality**
   - Real-time filtering by username
   - Clear search option
   - "User not found" state handling

   
3. **User Details**
   - Modal popup display
   - Comprehensive user information
   - Close button functionality

4. **Error Handling**
   - API error management
   - Loading states
   - Fallback image handling

### Implementation Details

#### API Integration
```dart
Future<List<UserModel>> getUsers() async {
  final response = await http.get(Uri.parse('$baseUrl/users'));
  // Process response
}
```

#### State Management
```dart
class UserProvider with ChangeNotifier {
  // State variables
  // State modification methods
  // Notification handling
}
```

#### Search Implementation
```dart
void searchUsers(String query) {
  _searchQuery = query;
  _filteredUsers = _users.where((user) =>
    user.username.toLowerCase().contains(query.toLowerCase())
  ).toList();
  notifyListeners();
}
```

### Setup Instructions

1. Prerequisites:
   - Flutter SDK
   - Dart SDK
   - Android Studio/VS Code

2. Installation:
   ```bash
   # Clone repository
   git clone [repository-url]

   # Navigate to project
   cd [project-directory]

   # Install dependencies
   flutter pub get

   # Run application
   flutter run
   ```

3. Configuration:
   - No additional configuration required
   - Minimal dependencies used as per requirements

### Performance Considerations

1. **Image Loading**
   - Network images are cached
   - Fallback image handling
   - Lazy loading implementation

2. **State Management**
   - Efficient Provider implementation
   - Minimal rebuilds
   - Optimized search filtering

3. **API Calls**
   - Error handling
   - Loading states
   - Response caching

### Testing

To run tests:
```bash
flutter test
```

Key test areas:
- API integration
- State management
- Search functionality
- UI components

### Build and Deploy

Generate release build:
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

### Code Style and Standards
- Follows Flutter coding conventions
- Uses consistent naming patterns
- Implements proper error handling
- Maintains clean architecture principles

### Known Limitations
- Limited to http and provider packages
- Basic error handling
- No offline support
- No data persistence

### Future Improvements
1. Add offline support
2. Implement caching
3. Add unit tests
4. Enhance error handling
5. Implement pagination

### Troubleshooting

Common issues and solutions:
1. API Connection Issues
   - Check internet connection
   - Verify API endpoints

2. Image Loading Issues
   - Check URL format
   - Verify photo IDs

3. State Management Issues
   - Verify Provider implementation
   - Check notifyListeners() calls
