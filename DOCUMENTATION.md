# Weather App Documentation

## Overview

This Flutter application allows users to get the current weather conditions for a specified city. It displays the current temperature, as well as the minimum and maximum temperatures for the day.

## Features

*   **Search by City:** Enter the name of any city to get its latest weather data.
*   **Current Temperature:** Displays the current temperature in Celsius.
*   **Min/Max Temperatures:** Shows the forecasted minimum and maximum temperatures for the day in Celsius.
*   **Loading Animation:** A visual indicator (`worldspin.flr` animation) is shown while the app fetches data.
*   **Error Handling:** Displays a message if the weather data for the entered city cannot be fetched (e.g., city not found, network issue).

## How to Use

1.  Upon launching the app, you will see a search screen with an animation.
2.  Enter the desired city name in the text input field labeled "City Name".
3.  Tap the "Search" button.
4.  If the city is found and data is retrieved, the weather information (current, min, and max temperatures) will be displayed.
5.  A "Search" button is present on the results screen. Tapping this button will take you back to the initial search screen, allowing you to search for another city. (Note: This button effectively acts as a "Reset" or "New Search".)

## Technical Details

### Architecture

The application is built using Flutter and follows the BLoC (Business Logic Component) pattern for state management. This pattern helps in separating the presentation layer from business logic, making the app more scalable and testable.

### Data Source

Weather data is fetched from the [OpenWeatherMap API](https://openweathermap.org/api). The app uses the current weather data endpoint.

### API Key

The application uses an API key to authenticate with the OpenWeatherMap API.

**Important Security Note:** The API key is currently hardcoded within the `lib/repository/weatherrepo.dart` file:
`https://api.openweathermap.org/data/2.5/weather?q=$city&appid=4321fa2ca520af425fb7efc52dc1a61e`

For production or public distribution, it is strongly recommended to manage this API key more securely. Options include:
*   Storing it in a separate configuration file that is not committed to version control (e.g., added to `.gitignore`).
*   Using environment variables to pass the API key at build time.

### State Management

The BLoC pattern is implemented using the `flutter_bloc` package. The core components are:

*   **Events:**
    *   `FetchWeather(String city)`: Triggered when the user requests weather for a city.
    *   `ResetWeather()`: Triggered to return to the initial search state.
*   **States:**
    *   `WeatherNotSearched`: Initial state before any search is performed.
    *   `WeatherLoading`: State when the app is actively fetching data from the API.
    *   `WeatherLoaded(WeatherModel weather)`: State when weather data has been successfully fetched and is available.
    *   `WeatherNotLoaded`: State indicating an error occurred while fetching data.
*   **Bloc:**
    *   `WeatherBloc(WeatherRepo weatherRepo)`: Manages the state transitions based on events and interacts with the `WeatherRepo` to get data.

### Project Structure

*   `lib/`: Contains the main Dart code for the application.
    *   `main.dart`: The entry point of the application, defines the UI structure and BLoC provider.
    *   `bloc/`: Contains the `WeatherBloc` and its associated events and states.
    *   `model/`: Contains the `WeatherModel` defining the structure of the weather data.
    *   `repository/`: Contains `WeatherRepo` responsible for fetching data from the API.
*   `assets/`: Contains static assets like animations.
    *   `worldspin.flr`: A Flare animation displayed on the search screen.
*   `android/`: Android specific project files.
*   `ios/`: iOS specific project files.
*   `pubspec.yaml`: Defines project metadata, dependencies, and assets.

## Setup and Build

To set up and run this project locally:

1.  **Flutter SDK:** Ensure you have the Flutter SDK installed and configured on your system. Refer to the [official Flutter installation guide](https://flutter.dev/docs/get-started/install).
2.  **Clone Repository:**
    ```bash
    git clone <repository_url>
    cd weather_app
    ```
3.  **Get Dependencies:**
    ```bash
    flutter pub get
    ```
4.  **Run the App:**
    Connect a device or start an emulator/simulator, then run:
    ```bash
    flutter run
    ```

This will build and launch the weather application on your selected device.
