# Production Monitor

A Flutter application for monitoring production quality metrics in real-time. This application provides both operator and manager dashboards with different views of production data.

## Features

- Real-time production quality monitoring
- Role-based access (Operator/Manager views)
- Interactive charts for data visualization
- Multiple time-frame views (Hourly/Daily/Weekly)
- Automatic data refresh
- Responsive design

## Getting Started

### Prerequisites

- Flutter SDK (>=2.17.0)
- Dart SDK
- A suitable IDE (VS Code, Android Studio, etc.)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/mrksqvdq/application_flutter.git
   ```

2. Navigate to the project directory:
   ```bash
   cd application_flutter
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the application:
   ```bash
   flutter run
   ```

## Project Structure

- `lib/`
  - `models/` - Data models
  - `providers/` - State management
  - `screens/` - UI screens
  - `services/` - API and other services
  - `theme/` - App theming
  - `widgets/` - Reusable UI components

## Dependencies

- `provider` - For state management
- `fl_chart` - For charts and graphs
- `cupertino_icons` - iOS style icons

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## License

This project is licensed under the MIT License.
