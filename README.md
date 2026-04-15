# Flutter Energy Consumption

## Overview
This repository contains a Flutter application that monitors and displays energy consumption data in a user-friendly interface.

## Features
- **Real-time data display:** Shows the current energy consumption.
- **Historical data tracking:** Save and visualize past energy consumption data.
- **Notifications:** Get alerts for high energy consumption trends.
- **User authentication:** Secure login for users to access their data.

## Tech Stack
- **Frontend:** Flutter
- **Backend:** Firebase
- **Database:** Firestore
- **State Management:** Provider

## Architecture Overview
```text
┌─────────────────────────────────────────────────────────────────────────┐
│                         PRESENTATION LAYER                              │
│                            (Flutter UI)                                 │
├─────────────────────────────────────────────────────────────────────────┤
│  Mobile/Web UI + Responsive Screens + fl_chart                         │
└─────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                    SERVICES & REPOSITORIES LAYER                        │
├─────────────────────────────────────────────────────────────────────────┤
│  ConsumoService • PrevisaoDemandaService • ConsumoRepository           │
└─────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                         DATA MODELS LAYER                               │
├─────────────────────────────────────────────────────────────────────────┤
│  ConsumoRegiao • PrevisaoDemanda                                       │
└─────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                  EXTERNAL SERVICES & DEPENDENCIES                       │
├─────────────────────────────────────────────────────────────────────────┤
│  Firebase • Firestore • HTTP Client • fl_chart • Material UI           │
└─────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                         BACKEND SERVICES                                │
├─────────────────────────────────────────────────────────────────────────┤
│  FastAPI on Render • Endpoints REST • Firestore                        │
└─────────────────────────────────────────────────────────────────────────┘
```
<img width="350" height="788" alt="image" src="https://github.com/user-attachments/assets/cb7cb99d-0837-4ece-90aa-5d66a65cce0f" />

<img width="1164" height="786" alt="image" src="https://github.com/user-attachments/assets/a49bc1cf-9fad-4efa-940f-8b896c0ac064" />

<img width="1447" height="765" alt="image" src="https://github.com/user-attachments/assets/72faa35f-632a-4648-8f20-0933649c4216" />


## Layer Descriptions

### 1. Presentation Layer (Flutter UI)
Responsible for user experience, screen rendering, and navigation between functionalities.

**Main screens:**
- `ResponsiveEntryScreen`
- `LoginScreen`
- `RegisterScreen`
- `OTPScreen`
- `ForgotScreen`
- `WelcomeScreen`
- Submenus:

- `AnalyzeConsumption`

- `DemandPrediction`

- `WasteAlerts`

- `UserProfile`

**Layer responsibilities:**

- Display interface for Web and Mobile
- Responsive navigation with `NavigationRail` and `Drawer`
- Rendering of charts with `fl_chart`
- Capture of user interactions

### 2. Services & Repositories Layer
Intermediate layer between the interface and the backend. #### `ConsumptionService`
Responsible for retrieving consumption data by region via REST API.

**Example of responsibility:**
- `searchConsumptionByRegion(year, indicator)`
- Endpoint consumed: `GET /api/consumption/regions`

#### `DemandPredictionService`
Responsible for consuming energy demand forecast data.

#### `ConsumptionRepository`
Abstracts access to services and centralizes the logic for obtaining data for the UI.

**Advantages of this approach:**

- Reduces coupling between screen and API
- Facilitates testing
- Centralizes data access rules

### 3. Data Models Layer
Represents the data structures exchanged between frontend and backend.

#### `ConsumptionRegion`
**Properties:**
- `region: String`
- `value: double`

**Common Methods:**
- `fromJson()`
- `toJson()`

#### `DemandForecast`
Similar model, used for projected demand data.

### 4. External Services & Dependencies
Groups external libraries and services used by the app.

#### Firebase Services
- `FirebaseCore`
- `FirebaseAuth`
- `CloudFirestore`

**Use in the project:**

- User authentication
- Profile persistence
- History and data associated with system usage

#### HTTP Client
Used for REST calls to the FastAPI backend.

#### Visualization
- `fl_chart`: charts and analytical visualization

#### Platform/UI
- `cupertino_icons`
- Material Design components

### 5. Backend Services Backend published separately with **FastAPI**, hosted on **Render**.

#### Main API
Example endpoint:

- `GET /api/consumption/regions` → returns consumption by region

#### Possible backend functions
- Provide regional consumption data
- Deliver demand forecasts
- Expose data for waste alerts
- Integrate external data sources

#### Database
**Firestore** as a NoSQL database for:
- authentication
- user profiles
- consumption history
- alerts and notifications

## Workflow

1. The user accesses the Flutter application.

2. The interface triggers services such as `ConsumoService` or `PrevisaoDemandaService`.

3. The services make HTTP requests to the FastAPI backend.

4. The backend processes the request and returns the data.

5. The models (`ConsumoRegiao`, `PrevisaoDemanda`) parse the JSON.

6. The UI displays the data in lists, cards, and graphs.

7. Authentication and complementary persistence functionalities are handled via Firebase/Firestore.

## Architecture Strengths

- Clear separation between UI, services, and models
- Structure prepared for growth
- Easy to add new screens and endpoints
- Low coupling between frontend and backend
- Cross-platform support with Flutter
- Simple integration with cloud authentication and persistence

## Technology Stack

**Frontend**

- Flutter
- Dart
- fl_chart

**Backend**

- FastAPI
- Python
- Render

**Services and Data**

- Firebase Authentication
- Cloud Firestore
- REST APIs

The architecture consists of:
- A Flutter frontend that communicates with a Firebase backend.
- Data is stored in Firestore, which provides a scalable database solution.
- The Provider package is used for state management to keep the app responsive.

## Installation Instructions
1. Clone the repository:
   ```bash
   git clone https://github.com/alexjosesilva/flutter-energy-consumption.git
   cd flutter-energy-consumption
   ```
2. Install the Flutter dependencies:
   ```bash
   flutter pub get
   ```
3. Set up Firebase by following the [Firebase setup guide](https://firebase.google.com/docs/flutter/setup).
4. Run the application:
   ```bash
   flutter run
   ```

## Project Structure
```
flutter-energy-consumption/
├── android/                 # Android-specific code
├── ios/                     # iOS-specific code
├── lib/                     # Flutter application code
│   ├── models/              # Data models
│   ├── providers/           # State management
│   ├── screens/             # Application screens
│   ├── services/            # Services for Firebase and other APIs
│   └── main.dart            # Entry point
├── test/                    # Unit tests
└── pubspec.yaml             # Project configuration
```  

## Contributing
We welcome contributions! Please read the [CONTRIBUTING.md](CONTRIBUTING.md) file for details on our code of conduct, and the process for submitting pull requests.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact
For questions or feedback, please reach out to [alexjosesilva](mailto:alexjosesilvati@gmail.com).
