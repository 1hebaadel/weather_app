abstract class WeatherStatus {}

class InitiateWeatherState extends WeatherStatus {}

class GetWeatherDataLoadingState extends WeatherStatus {}

class GetWeatherDataSuccessfullyState extends WeatherStatus {}

class GetWeatherDataErrorState extends WeatherStatus {}

class ChangeTextFieldVisibilityState extends WeatherStatus {}

class ChangeUIState extends WeatherStatus {}