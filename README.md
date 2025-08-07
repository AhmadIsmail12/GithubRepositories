# GithubRepositoryApp

A SwiftUI-based application to search Github repositories using the public GitHub API.  
Built using Clean Architecture, MVVM, Coordinator pattern, Combine, and includes disk & memory caching, pagination, unit and UITest

---

## 📱 Features

- 🔍 Real-time search for GitHub repositories
- 📄 Repository detail screen with avatar, creation date, stars, and URL
- 🔄 Pagination with infinite scroll
- 🔄 Pull-to-refresh
- ⚙️ Image caching (memory + disk)
- 🧠 Repository data caching with 5-minute expiration
- ❌ Error handling (network, decoding, etc.)
- 🧪 Unit tests for ViewModels, UseCases, Repositories
- 🎯 UI tests for search flow and detail screen
- 🚀 Clean and modular architecture

---

## 🧱 Architecture

- **MVVM** with `@StateObject` view models
- **Use Cases** for business logic
- **Repositories** for API + Caching logic
- **DI Containers** for dependency injection
- **Coordinators** for navigation (without importing SwiftUI)
- **NavigationStack** with path-based routing
- **Combine** for reactive bindings and search debounce

---

## 📂 Module Breakdown

### 1. `GitHubRepositoryApp`
- Entry point (`@main`)
- Initializes `AppCoordinator` and root `NavigationStack`

### 2. `AppCoordinator`
- Handles root navigation
- Delegates navigation to `Splash`, `RepositoriesList`, and `RepositoryDetail` coordinators

### 3. `RepositoriesListView`
- Searchable `List` with infinite scroll
- Calls `loadNextPage()` on `.onAppear`
- Navigates to detail screen on selection

### 4. `RepositoryDetailView`
- Displays detailed information about selected repository
- UI elements include avatar, name, stars, created date, and link

---

## 🧪 Testing

### ✅ Unit Tests
- Located under `GithubRepositoryTests`
- Tests for:
  - ViewModel search debounce, state transitions, and error handling
  - Use case mocking
  - Pagination logic
  - Cache validation

### ✅ UI Tests
- Located under `GithubRepositoryUITests`
- Includes:
  - App launch performance
  - `testSearchFlow()`:
    - Search for a repo
    - Tap first result
    - Validate detail view with title

---

## 🧠 Caching Strategy

- **Image Caching**:  
  - In-memory via `NSCache`
  - Disk cache via `FileManager`

- **Repository Search Cache**:  
  - Cache response for each search query
  - Auto-expiration after 5 minutes
  - Cleared on pull-to-refresh

---

## 🧪 Code Coverage

✅ Unit and UITest:
- ViewModels
- UseCases
- Coordinators
- Repository implementations

---

## ▶️ How to Run

1. Clone this repo:
   ```bash
   git clone https://github.com/yourusername/GitHubRepoSearchApp.git
   cd GitHubRepoSearchApp
Open with Xcode:

bash
Copy
Edit
open GitHubRepository.xcodeproj
Run the app (Cmd + R)

Run the tests (Cmd + U)

🔗 GitHub API Rate Limiting
This app uses GitHub's public unauthenticated API.
You are limited to 60 requests per hour.

🛠 Dependencies
Swift 5.9+

Xcode 15+

iOS 16+

Combine

SwiftUI

🙌 Author
Ahmad Ismail
Senior iOS Developer — LinkedIn

