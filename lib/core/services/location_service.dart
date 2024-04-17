import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationService {
  LatLng? _currentP;
  final Location _locationController;
  final void Function(LatLng)? onLocationChanged;

  LocationService(this._currentP, this._locationController, {this.onLocationChanged});

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (_currentP == null) {
        if (currentLocation.latitude != null && currentLocation.longitude != null) {
          _currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          if (onLocationChanged != null) {
            onLocationChanged!(_currentP!);
          }
        }
      }
    });
  }
}
