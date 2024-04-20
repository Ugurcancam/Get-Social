import 'dart:io';

import 'package:dio/dio.dart';
import 'package:etkinlikapp/core/constants/constants.dart';

class LocationService {
  // For getting the place details which clicked on the map
  Future<void> getPlaceDetails(double lat, double long, void Function(String address) getAddressCallback) async {
    const apiKey = google_api_key;
    const baseURL = 'https://maps.googleapis.com/maps/api/geocode/json';
    final request = '$baseURL?latlng=$lat,$long&key=$apiKey';

    try {
      final response = await Dio().get<Map<String, dynamic>>(request);

      // Accessing the first element of the list
      if (response.statusCode == HttpStatus.ok) {
        final data = response.data!;
        final results = data['results'] as List<dynamic>; // Accessing as List

        if (results.isNotEmpty) {
          // Accessing the first element of the list
          final placeDetails = results[0] as Map<String, dynamic>;
          final destinationPlaceFullAddress = placeDetails['formatted_address'] as String;

          //We are sending the address to the callback function, then set it to TextEditingController
          getAddressCallback(destinationPlaceFullAddress);
        }
        throw Exception('No place');
      } else {
        throw Exception('Failed to get place details');
      }
    } catch (e) {
      throw Exception('Error fetching place details: $e');
    }
  }
}
