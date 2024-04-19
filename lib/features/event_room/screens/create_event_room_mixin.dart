part of 'create_event_room_view.dart';

mixin CreateEventRoomPageMixin on State<CreateEventRoomPage> {
  // Sayfa boyutlarını almak için
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
  late CreateRoomBloc _createRoomBloc;
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
    _createRoomBloc = CreateRoomBloc();
    _createRoomBloc.add(FetchDataEvent());
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        final formattedDate = DateFormat('dd/MM/yyyy').format(value);
        _roomViewModel.eventDateController.text = formattedDate;
      }
    });
  }

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        final formattedTime = value.format(context);
        _roomViewModel.eventTimeController.text = formattedTime;
      }
    });
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
