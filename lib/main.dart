import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/modules/home/home_screen.dart';
import 'package:weather_app/shared/bloc_observer.dart';
import 'package:weather_app/shared/cubit/cubit.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WeatherCubit()..getWeather(cityName: 'London'),),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.teal,
          )
        ),
        home: HomeScreen(),
      ),
    );
  }
}