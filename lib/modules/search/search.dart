import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/cubit.dart';
import '../../cubit/status.dart';


class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Search',
        ),
      ),
      body: BlocProvider(
        create: (context) => WeatherCubit(),
        child: BlocConsumer<WeatherCubit , WeatherStatus>(
          listener: (context, state) {

          },
          builder: (context, state) {
            WeatherCubit cubit = WeatherCubit.get(context);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0 , horizontal: 16.0),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  labelText: 'Enter City',
                  hintText: 'Enter City',
                ),
                onChanged: (value){
                  cubit.getWeather(cityName: value);
                },
                onFieldSubmitted: (value){
                  cubit.getWeather(cityName: value);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
