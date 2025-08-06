import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/distance_result.dart';

class RoutesService {
  RoutesService(this._apiKey);
  final String _apiKey;

  Future<DistanceResult?> distance({
    required double originLat,
    required double originLng,
    required String destinationAddress,
  }) async {
    const url = 'https://routes.googleapis.com/directions/v2:computeRoutes';

    try {
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
          'destination': {'address': destinationAddress},
          'travelMode': 'WALK',
        }),
      );

      if (res.statusCode != 200) {
        debugPrint('HTTP error: statusCode=${res.statusCode}, body=${res.body}');
        return null;
      }

      final json = jsonDecode(res.body);

      if (json['routes'] != null && json['routes'].isNotEmpty) {
        final route = json['routes'][0];
        if (route['distanceMeters'] != null) {
          final meters = (route['distanceMeters'] as num).toDouble();
          return DistanceResult(meters);
        }
      }

      return null;
    } catch (e) {
      debugPrint('Error fetching distance: $e');
      return null;
    }
  }
}
