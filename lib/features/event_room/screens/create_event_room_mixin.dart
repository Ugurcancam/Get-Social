part of 'create_event_room_view.dart';

mixin CreateEventRoomPageMixin on State<CreateEventRoomPage> {
  @override
  void initState() {
    super.initState();
    selectedProvince = '';
    selectedDistrict = '';
    LocationService(_currentP, _locationController, onLocationChanged: (LatLng location) {
      setState(() {
        _currentP = location;
      });
    }).getLocationUpdates();
  }

  //Location
  LatLng? _currentP;
  final Location _locationController = Location();
  String coordinate = '';

  //Services
  final EventRoomService _eventRoomService = EventRoomService();
  final EventCategoriesService _eventCategoriesService = EventCategoriesService();

  final TextEditingController adresAciklamasiController = TextEditingController();
  final CreateEventRoomViewModel _roomViewModel = CreateEventRoomViewModel();

  String? get nameSurname => Provider.of<UserProvider>(context).namesurname;
  String? get uid => Provider.of<UserProvider>(context).uid;

  late final List<String>? selectedCategoryList;
  List<String> ilcelerr = [];
  bool getir = false;
  late String selectedProvince;
  late String selectedDistrict;

  // Tıklanılan konumun adresini almak için
  Future<void> getPlaceDetails(double lat, double long) async {
    const apiKey = google_api_key;
    const baseURL = 'https://maps.googleapis.com/maps/api/geocode/json';
    final request = '$baseURL?latlng=$lat,$long&key=$apiKey';

    try {
      final response = await Dio().get(request);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        final List<dynamic> results = data['results'] as List<dynamic>; // Accessing as List

        if (results.isNotEmpty) {
          final Map<String, dynamic> placeDetails = results[0] as Map<String, dynamic>; // Accessing the first element of the list
          final String destinationPlaceFullAddress = placeDetails['formatted_address'] as String;
          print(destinationPlaceFullAddress);

          setState(() {
            adresAciklamasiController.text = destinationPlaceFullAddress;
          });
        } else {
          print("No results found");
          // Handle the case where no results are found
        }
      } else {
        print("Failed to get place details: ${response.statusCode}");
        throw Exception('Failed to get place details');
      }
    } catch (e) {
      print("Error fetching place details: $e");
    }
  }
}
