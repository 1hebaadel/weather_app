import 'package:flutter/material.dart';
import 'package:weather_app/modules/search/search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(),
                    ),
                );
              },
              icon: Icon(Icons.search),
          ),
        ],
        title: Text(
          'Weather',
        ),
      ),
    );
  }
}
