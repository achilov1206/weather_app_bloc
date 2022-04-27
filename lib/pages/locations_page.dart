import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import './home_page.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select more suitable location')),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          return ListView.builder(
              itemCount: state.locations.length,
              itemBuilder: (context, int index) {
                return ListTile(
                  title: Text(state.locations[index].title),
                  subtitle: Text(state.locations[index].locationType),
                  onTap: () {
                    context.read<WeatherBloc>().add(
                          FetchWeatherEvent(city: state.locations[index].title),
                        );
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                        (route) => false);
                  },
                );
              });
        },
      ),
    );
  }
}
