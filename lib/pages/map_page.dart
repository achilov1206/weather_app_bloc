import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../blocs/weather/weather_bloc.dart';
import './locations_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select location'),
        actions: [
          if (_pickedLocation != null)
            IconButton(
              onPressed: () {
                if (_pickedLocation != null) {
                  context.read<WeatherBloc>().add(
                        FetchWoeidsByLocationEvent(
                          location: _pickedLocation!,
                        ),
                      );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LocationsPage(),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.check),
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(41.309370, 69.277340),
          zoom: 4,
        ),
        onTap: _selectLocation,
        markers: _pickedLocation == null
            ? const <Marker>{}
            : <Marker>{
                Marker(
                    markerId: const MarkerId('m1'), position: _pickedLocation!),
              },
      ),
    );
  }
}
