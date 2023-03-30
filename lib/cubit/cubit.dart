import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'status.dart';
import 'package:http/http.dart' as http;

class WeatherCubit extends Cubit<WeatherStatus> {

  WeatherCubit() : super(InitiateWeatherState());

  static WeatherCubit get(BuildContext context) => BlocProvider.of(context);

  String baseUrl = 'http://api.weatherapi.com/v1';
  String apiKey = '20c50eeaadae4799a05153539230203';

  void getWeather({required String cityName}) async{
    Uri url = Uri.parse(
      '$baseUrl/current.json?key=$apiKey&q=$cityName&aqi=no'
    );
    http.Response response= await http.get(url);

    Map<String , dynamic> data = jsonDecode(response.body);
    print(data);
  }

}