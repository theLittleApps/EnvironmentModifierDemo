# EnvironmentModifierDemo

A SwiftUI iOS application demonstrating two powerful approaches to dependency injection using the `.environment()` modifier. This educational project showcases best practices for managing shared state and configuration values in modern SwiftUI applications.

## Overview

This demo app implements a simple shopping experience with products, a cart, and user settings. It serves as a practical example of how to effectively use SwiftUI's environment system for dependency injection and state management.

## Key Features

- **Two Environment Approaches**: Demonstrates both KeyPath-based and Observable-based environment patterns
- **Shopping Cart**: Full cart functionality with add, remove, and quantity management
- **User Session**: Authentication state management with sign-in/sign-out
- **Custom Environment Values**: Configurable accent colors, corner radius, and debug mode
- **Modern SwiftUI**: Built with iOS 17+ features including `@Observable` and `@Entry` macros

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Project Structure

```
EnvironmentModifierDemo/
├── Core/
│   ├── Root/
│   │   ├── EnvironmentModifierDemoApp.swift    # App entry point
│   │   └── ContentView.swift                   # Tab view container
│   ├── ProductList/
│   │   └── ProductListView.swift               # Product grid view
│   ├── Cart/
│   │   └── CartView.swift                      # Shopping cart view
│   └── Settings/
│       └── SettingsView.swift                  # Settings and info
├── Components/
│   ├── ProductCard.swift                       # Product display card
│   ├── CartBadge.swift                         # Cart item counter
│   ├── WelcomeHeader.swift                     # User greeting header
│   └── DebugInfoCard.swift                     # Debug info display
├── ViewModels/
│   ├── ShoppingCart.swift                      # Observable cart state
│   └── UserSession.swift                       # Observable user session
├── Model/
│   └── Product.swift                           # Product data model
└── Extensions/
    └── EnvironmentValues+Ext.swift             # Custom environment values
```

## Two Approaches to Environment Injection

### Approach 1: KeyPath Syntax (EnvironmentValues)

Used for **simple, immutable configuration values** that don't change frequently.

**Definition** (`EnvironmentValues+Ext.swift`):
```swift
extension EnvironmentValues {
    @Entry var appAccentColor: Color = .blue
    @Entry var cardCornerRadius: CGFloat = 12
    @Entry var isDebugMode: Bool = false
}
```

**Setting values** (at the root level):
```swift
ContentView()
    .environment(\.appAccentColor, .orange)
    .environment(\.cardCornerRadius, 16)
    .environment(\.isDebugMode, true)
```

**Reading values** (in any child view):
```swift
@Environment(\.appAccentColor) private var accentColor
@Environment(\.isDebugMode) private var isDebugMode
```

**Best for:**
- Theme colors and styling
- Feature flags
- Simple configuration values
- Values that rarely change

### Approach 2: Observable Syntax

Used for **shared, mutable state** that needs to be accessed and modified across multiple views.

**Definition** (`ShoppingCart.swift`):
```swift
@Observable
class ShoppingCart {
    var items: [CartItem] = []
    var itemCount: Int { items.reduce(0) { $0 + $1.quantity } }

    func addItem(product: Product) { /* ... */ }
    func removeItem(at index: Int) { /* ... */ }
}
```

**Setting** (at the root level):
```swift
@State private var cart = ShoppingCart()
@State private var userSession = UserSession()

ContentView()
    .environment(cart)
    .environment(userSession)
```

**Reading** (in any child view):
```swift
@Environment(ShoppingCart.self) private var cart
@Environment(UserSession.self) private var userSession
```

**Best for:**
- ViewModels with business logic
- Shared mutable state
- Services (networking, database, etc.)
- Complex state that changes frequently

## How It Works

### App Entry Point

The app initializes all environment values in `EnvironmentModifierDemoApp.swift`:

```swift
@main
struct EnvironmentModifierDemoApp: App {
    @State private var cart = ShoppingCart()
    @State private var userSession = UserSession()

    var body: some Scene {
        WindowGroup {
            ContentView()
                // Approach 1: KeyPath-based
                .environment(\.appAccentColor, .orange)
                .environment(\.cardCornerRadius, 12)
                .environment(\.isDebugMode, true)
                // Approach 2: Observable-based
                .environment(cart)
                .environment(userSession)
        }
    }
}
```

### View Hierarchy

```
ContentView (TabView)
├── ProductListView
│   ├── Accesses: cart, userSession, accentColor, isDebugMode
│   ├── WelcomeHeader (reads userSession)
│   ├── DebugInfoCard (reads all environment values)
│   └── ProductCard (reads accentColor, cart)
├── CartView
│   ├── Accesses: cart, accentColor
│   └── Displays cart items with total
└── SettingsView
    ├── Accesses: userSession, accentColor
    └── Sign in/out functionality
```

All child views automatically inherit environment values from their parent, enabling clean dependency injection without prop drilling.

## Features in Detail

### Shop Tab (ProductListView)
- Displays products in a 2-column grid
- Add items to cart with quantity tracking
- Cart badge showing total item count
- User welcome header with quick sign-in
- Debug information card (when debug mode enabled)

### Cart Tab (CartView)
- Lists all cart items with quantities
- Swipe-to-delete individual items
- Shows total price calculation
- Clear all items button
- Empty state when cart is empty

### Settings Tab (SettingsView)
- User profile information
- Sign In/Sign Out functionality
- Explanation of environment modifier approaches
- App information and learning resources

## Custom Environment Values

| Key | Type | Default | Purpose |
|-----|------|---------|---------|
| `appAccentColor` | `Color` | `.blue` | Primary accent color used throughout the app |
| `cardCornerRadius` | `CGFloat` | `12` | Corner radius for product cards |
| `isDebugMode` | `Bool` | `false` | Toggles debug information display |

## Observable State Objects

### ShoppingCart
- **Properties**: `items`, `itemCount`, `totalPrice`
- **Methods**: `addItem()`, `removeItem()`, `clearCart()`
- **Purpose**: Manages shopping cart state across views

### UserSession
- **Properties**: `username`, `isLoggedIn`, `prefersDarkMode`
- **Methods**: `login(username:)`, `logout()`
- **Purpose**: Manages user authentication and preferences

## Data Models

### Product
```swift
struct Product: Identifiable {
    let id: String
    let name: String
    let price: Double
    let emoji: String
}
```

Sample products include: Coffee, Croissant, Sandwich, and Salad.

## Building and Running

1. Clone the repository
2. Open `EnvironmentModifierDemo.xcodeproj` in Xcode
3. Select your target device or simulator
4. Press `Cmd + R` to build and run

No external dependencies required - this is a pure SwiftUI implementation.

## Learning Objectives

This demo helps you understand:

1. **When to use KeyPath vs Observable approaches**
   - KeyPath: Simple configuration, styling, feature flags
   - Observable: Complex state, ViewModels, services

2. **How environment values propagate**
   - Set at root level
   - Automatically inherited by all child views
   - No prop drilling needed

3. **Modern SwiftUI patterns**
   - `@Observable` macro for state management
   - `@Entry` macro for custom environment values
   - `@Environment` property wrapper for dependency injection

4. **Real-world application**
   - Shopping cart implementation
   - User authentication flow
   - Shared state management

## Key Takeaways

- **Avoid Prop Drilling**: Environment values eliminate the need to pass data through multiple view layers
- **Type Safety**: Both approaches provide compile-time type safety
- **Testability**: Easy to inject mock dependencies for testing
- **Scalability**: Clean pattern that scales well as your app grows
- **iOS 17+ Features**: Leverages modern SwiftUI capabilities for cleaner code

## Code Examples

### Adding a New Custom Environment Value

1. Define in `EnvironmentValues+Ext.swift`:
```swift
extension EnvironmentValues {
    @Entry var customSpacing: CGFloat = 8
}
```

2. Set at root level:
```swift
ContentView()
    .environment(\.customSpacing, 16)
```

3. Read in any view:
```swift
@Environment(\.customSpacing) private var spacing
```

### Creating a New Observable Object

1. Define the class:
```swift
@Observable
class MyService {
    var data: [Item] = []

    func fetchData() async {
        // Implementation
    }
}
```

2. Set at root level:
```swift
@State private var myService = MyService()

ContentView()
    .environment(myService)
```

3. Read in any view:
```swift
@Environment(MyService.self) private var service
```

## Best Practices Demonstrated

- Separation of concerns (Views, ViewModels, Models)
- Reusable UI components
- Preview support with proper environment setup
- Clean dependency injection
- Modern Swift concurrency patterns
- MVVM-like architecture with Observable objects

## License

This is an educational demo project. Feel free to use and modify for learning purposes.

## Contributing

This is a demonstration project. Feel free to fork and experiment with different approaches to environment-based dependency injection.

## Additional Resources

- [Apple SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [Observable Macro Documentation](https://developer.apple.com/documentation/observation)
- [Environment Values Guide](https://developer.apple.com/documentation/swiftui/environmentvalues)

---

Built with SwiftUI for iOS 17+
