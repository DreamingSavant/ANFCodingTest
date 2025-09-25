# Abercrombie & Fitch Code Test (iOS)

This project recreates a simplified version of the **A&F Explore Page** using UIKit and MVVM principles.  
Users can scroll through a feed of promotion cards powered by JSON data, each showing titles, descriptions, promo codes, images, and dynamically generated shop buttons.

---

## 🚀 Features
- Parses `exploreData.json` into Swift models (`Product`, `Content`) using `Codable`.
- Displays product cards in a scrollable `UITableView` using `ExploreContentCell`.
- Each card shows:
  - Background image (resizes based on content).
  - Top description, title, promo message, and bottom description.
  - HTML links (bottom description rendered with `NSAttributedString`).
  - Dynamic action buttons (from `content`) that open URLs in Safari.
- Networking layer built with a **repository pattern**:
  - `RestClient` → handles raw requests.
  - `ServiceClient` → higher-level fetch logic.
  - `ProductCardRepository` → abstracts data access and injects into the view model.
- ViewModel (`ProductCardViewModel`) provides parsed data to the view and handles async image fetching.
- Unit tests cover repository, service client, and view model with mock data.

---

## 🛠 Architecture
- **UIKit + MVVM**: Separation of view, view model, and repository.  
- **Networking Layer**: Cleanly abstracted for testability.  
- **Async/Await**: Used for JSON parsing and image fetching without blocking UI.  
- **Dependency Injection**: ViewModel depends on a protocol (`ProductCardRepositoryContract`), making it easy to inject fakes in tests.  

---

---

## 🧪 Unit Tests
- **Repository Tests** → validate networking layer fetches/parses correctly.  
- **ViewModel Tests** → confirm correct state when loading products and fetching images.  
- **Controller Tests** → check that labels and buttons are populated from JSON.  
- Tests use **mock JSON (`exploreData.json`)** and **fake repository/service clients** for deterministic results.

---

## ▶️ Running the Project
1. Clone this repo.  
2. Open `ANF Code Test.xcodeproj` in Xcode (iOS 16+).  
3. Build & run (⌘R) → the app loads `exploreData.json` and renders product cards in the table view.  
4. Run tests (⌘U) → unit test suite passes with mocks.  

---

## ✅ Future Improvements
- Add caching layer for images.  
- Pull `exploreData.json` from the provided API endpoint instead of a bundled file.  
- Add error handling UI for network failures.  
- Improve accessibility and localization coverage.  
- Add UI tests to verify navigation and button actions.  

---

## 👤 Author
**Roderick Presswood**  
Senior iOS Engineer with 10+ years of experience building large-scale consumer apps.  
