part of 'create_event_room_select_location_view.dart';

mixin CreateEventRoomSelectLocationViewMixin on State<CreateEventRoomSelectLocationView> {
  // For getting the width and height of the screen
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  //Controllers for Textfield which is used for show the address of the clicked place on the map
  final TextEditingController eventPlaceDescriptionController = TextEditingController();

  //Current Position
  LatLng? _currentP;

  //For getting the coordinate of the place which clicked on the map
  String selectedPlaceCoordinate = '';

  //Services
  final LocationService _locationService = LocationService();

  //controller for location
  final Location locationController = Location();

  //Variables for selecting Province and District
  List<String> ilcelerr = [];
  late String selectedProvince;
  late String selectedDistrict;

  //bloc
  late CreateRoomBloc _createRoomBloc;

  void setAddress(String address) {
    setState(() {
      eventPlaceDescriptionController.text = address;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedProvince = '';
    selectedDistrict = '';
    LocationPermissionManager(_currentP, locationController, onLocationChanged: (LatLng location) {
      setState(() {
        _currentP = location;
      });
    }).getLocationUpdates();
    _createRoomBloc = CreateRoomBloc();
    _createRoomBloc.add(FetchDataEvent());
  }
}
