import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationPage extends StatefulWidget {
  const GeolocationPage({Key? key}) : super(key: key);

  @override
  State<GeolocationPage> createState() => _GeolocationPageState();
}

class _GeolocationPageState extends State<GeolocationPage> {
  Position? _currentPosition;
  LocationPermission? _permission;

  @override
  Widget build(BuildContext context) {
    final formattedPosition = _currentPosition == null
        ? 'Unknown'
        : '${_currentPosition!.latitude}, ${_currentPosition!.longitude}';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocation Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Current location: $formattedPosition',
              key: const ValueKey<String>('current_position_text'),
            ),
            Text('Permission status: ${_permission?.name ?? 'Unknown'}'),
            const SizedBox(height: 6.0),
            ElevatedButton(
              key: const ValueKey<String>('get_current_position_button'),
              onPressed: () async {
                final permission = await Geolocator.requestPermission();
                setState(() {
                  _permission = permission;
                });
                if (permission == LocationPermission.denied) {
                  return Future.error('Location permissions are denied');
                }
                final position = await Geolocator.getCurrentPosition();
                setState(() {
                  _currentPosition = position;
                });
              },
              child: const Text('Get current location'),
            ),
          ],
        ),
      ),
    );
  }
}
