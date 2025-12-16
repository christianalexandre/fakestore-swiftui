# FakeStore iOS (SwiftUI + Clean Architecture)

This project is a simple e-commerce application built to demonstrate modern iOS development practices. It utilizes the [DummyJSON](https://dummyjson.com/) API to create a fake store, allowing users to browse products, add them to a cart, and simulate a shopping experience.

The main purpose of this project is to serve as a learning resource in:
* **SwiftUI:** Building a modern, declarative UI using the latest iOS standards.
* **Clean Architecture:** Structuring the application for better separation of concerns, testability, and maintainability.
* **iOS Testing:** Implementing Unit and UI tests using XCTest to ensure code quality.

This project is also part of a post-graduation course in Mobile Application Development.

## Features

* **Product Catalog:** Browse a list of products fetched from the DummyJSON API.
* **Product Details:** View detailed information, including image carousels, ratings, and descriptions.
* **Shopping Cart:** Add, remove, and update item quantities.
    * **Persistence:** Shopping cart data is synchronized in real-time using **Firebase Firestore**.
    * **Cross-Platform:** The data structure is compatible with the Android version of this app.
* **Authentication:** Custom native Login and Registration flow using **Firebase Authentication**.

> **Note:** Firebase features require a `GoogleService-Info.plist` file in the root of the project. Please generate your own via the Firebase Console or contact me for the file.

## Architecture

This project follows the principles of **Clean Architecture**, separating the code into three main layers:

* **Data Layer:** Responsible for fetching data from the network (using `URLSession`) and synchronizing with Firebase Firestore. It implements the repositories defined in the Domain layer.
* **Domain Layer:** Contains the core business logic of the application, including **Use Cases** (e.g., `AddToCartUseCase`, `GetProductsUseCase`) and domain models. It is completely independent of UI frameworks.
* **Presentation Layer:** The UI layer, built with **SwiftUI** and **MVVM** pattern. It observes changes from ViewModels and reacts to user interactions.

## How to Run

### Prerequisites

* **Xcode 15** or later (Project targets iOS 16.0+).
* **macOS** capable of running the latest Xcode.

### Step-by-Step

1.  Clone the repository:
    ```bash
    git clone https://github.com/christianalexandre/fakestore-ios.git
    ```
2.  Open the `FakeStore.xcodeproj` file in Xcode.
3.  Wait for Xcode to resolve **Swift Package Manager (SPM)** dependencies.
4.  Place your `GoogleService-Info.plist` file in the root folder of the project (ensure it is added to the main Target).
5.  Select a Simulator (e.g., iPhone 15/16) and press **Run (Cmd + R)**.

## Tools / Dependencies

* **Swift 5+**
* **SwiftUI** for the User Interface.
* **Swift Concurrency (Async/Await)** for asynchronous programming.
* **Manual Dependency Injection** for loose coupling between layers.
* **URLSession** for networking (Native).
* **Firebase SDK** (via SPM):
    * **Firebase Authentication** for user management.
    * **Firebase Firestore** for real-time cloud database. 