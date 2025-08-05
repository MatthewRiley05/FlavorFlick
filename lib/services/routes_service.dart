import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/distance_result.dart';

class RoutesService {
  RoutesService(this._apiKey);
  final String _apiKey;

  Future<DistanceResult?> distance({
    required double originLat,
    required double originLng,
    required String destAddress,
  }) async {
    const url = 'https://routes.googleapis.com/directions/v2:computeRoutes';

    try {
      print('Making request for address: $destAddress');
      print('Origin: $originLat, $originLng');

      final res = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'X-Goog-Api-Key': _apiKey,
          'X-Goog-FieldMask': 'routes.duration,routes.distanceMeters',
        },
        body: jsonEncode({
          'origin': {
            'location': {
              'latLng': {'latitude': originLat, 'longitude': originLng},
            },
          },
          'destination': {'address': destAddress},
          'travelMode': 'WALK',
        }),
      );

      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');

      if (res.statusCode != 200) {
        print('API Error: ${res.statusCode} - ${res.body}');
        return null;
      }

      final json = jsonDecode(res.body);
      print('Parsed JSON: $json');

      if (json['routes'] != null && json['routes'].isNotEmpty) {
        final route = json['routes'][0];
        print('Route data: $route');
        if (route['distanceMeters'] != null) {
          final meters = (route['distanceMeters'] as num).toDouble();
          print('Found distance: $meters meters');
          return DistanceResult(meters);
        }
      }

      print('No distance found for: $destAddress');
      return null;
    } catch (e) {
      print('Distance API request failed: $e');
      return null;
    }
  }
}
