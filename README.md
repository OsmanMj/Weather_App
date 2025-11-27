# WEATHER_APP

<p align="center">
  <i>Forecast the Future, Feel the Weather Instantly</i>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Riverpod-2D2D2D?style=for-the-badge&logo=riverpod&logoColor=white" alt="Riverpod" />
</p>

<p align="center">
  Built with the tools and technologies:
</p>

<p align="center">
  <img src="https://img.shields.io/badge/JSON-000000?style=flat-square&logo=json&logoColor=white" alt="JSON" />
  <img src="https://img.shields.io/badge/Markdown-000000?style=flat-square&logo=markdown&logoColor=white" alt="Markdown" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Kotlin-7F52FF?style=flat-square&logo=kotlin&logoColor=white" alt="Kotlin" />
  <img src="https://img.shields.io/badge/Swift-F05138?style=flat-square&logo=swift&logoColor=white" alt="Swift" />
</p>

---

## Table of Contents

- [Overview](#overview)
- [Why Weather_App?](#why-weather_app)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [License](#license)

---

## Overview

**Weather_App** is a modern, Flutter-based weather application designed to deliver real-time weather data with a focus on localization, theming, and modular architecture. It streamlines the development of cross-platform weather apps that are visually consistent and culturally adaptable.

It provides users with accurate weather information, including current conditions, 7-day forecasts, and smart clothing recommendations, all wrapped in a beautiful, animated user interface.

## Why Weather_App?

This project simplifies building feature-rich, multilingual weather applications with a clean, maintainable codebase. The core features include:

-   🌍 **Globe: Localization Support**: Seamlessly switch between **English** and **Arabic**, providing a culturally tailored user experience with full RTL support.
-   🎨 **Palette: Theming Architecture**: Easily toggle between **Light** and **Dark** themes for a cohesive visual style that adapts to day and night.
-   ☁️ **Cloud: Weather Widgets**: Reusable components for displaying current conditions, forecasts, and smart clothing recommendations.
-   ⚙️ **Gear: Modular Structure**: Built using **Clean Architecture**, ensuring clear separation of UI, logic, and data layers for scalable development.
-   🌐 **Cross-Platform Compatibility**: Built for Android and iOS, ensuring broad accessibility.
-   🚀 **Performance: State Management with Riverpod**: Reactive UI updates and efficient data handling.

## Architecture

The project follows **Clean Architecture** principles to ensure separation of concerns and testability:

-   **Presentation Layer**: Contains UI components (Screens, Widgets) and State Management (Providers).
-   **Domain Layer**: Contains Business Logic (Use Cases) and Repository Interfaces.
-   **Data Layer**: Handles Data Retrieval (API calls, Local Storage) and Repository Implementations.

## Getting Started

### Prerequisites

This project requires the following dependencies:

-   **Programming Language**: Dart (SDK ^3.6.1)
-   **Framework**: Flutter (SDK ^3.0.0)
-   **Package Manager**: Pub

### Installation

Build Weather_App from the source and install dependencies:

1.  **Clone the repository**:

    ```bash
    git clone https://github.com/OsmanMj/Weather_App.git
    ```

2.  **Navigate to the project directory**:

    ```bash
    cd Weather_App
    ```

3.  **Install dependencies**:

    ```bash
    flutter pub get
    ```

4.  **Run the app**:

    ```bash
    flutter run
    ```

## Usage

-   **Grant Location Permission**: Upon first launch, allow the app to access your location to get local weather data.
-   **Search City**: Use the search bar to find weather for any city globally.
-   **Switch Theme**: Toggle the theme icon to switch between Light and Dark modes.
-   **Change Language**: Use the settings or language toggle to switch between English and Arabic.

## Project Structure

```text
lib/
├── core/                   # Core utilities, constants, and theme configuration
├── data/                   # Data layer: API services, models, and repository implementations
│   ├── models/             # Data models (JSON serialization)
│   ├── repositories/       # Concrete implementations of repositories
│   └── services/           # API services (Dio client)
├── domain/                 # Domain layer: Business logic and interfaces
│   ├── logic/              # Business logic (e.g., clothing recommendations)
│   └── repositories/       # Abstract repository interfaces
├── l10n/                   # Localization files (.arb)
├── presentation/           # UI layer: Screens, widgets, and state management
│   ├── providers/          # Riverpod providers
│   ├── screens/            # Application screens
│   └── widgets/            # Reusable UI components
└── main.dart               # Application entry point
```

## Screenshots

| Light Mode | Dark Mode | Arabic UI |
|:---:|:---:|:---:|
| ![Light Mode](assets/screenshots/light.png) | ![Dark Mode](assets/screenshots/dark.png) | ![Arabic UI](assets/screenshots/arabic.png) |

*(Note: Please ensure you have screenshots in the `assets/screenshots` directory)*

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
