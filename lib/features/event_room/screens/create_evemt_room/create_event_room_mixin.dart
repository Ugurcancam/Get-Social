part of 'create_event_room_view.dart';

mixin CreateEventRoomPageMixin on State<CreateEventRoomPage> {
  // For getting the width and height of the screen
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  //Current Position
  LatLng? _currentP;

  //For getting the coordinate of the place which clicked on the map
  String selectedPlaceCoordinate = '';

  //Services
  final EventRoomService _eventRoomService = EventRoomService();

  //View Model
  final CreateEventRoomViewModel _createEventRoomViewModel = CreateEventRoomViewModel();

  //Provider
  String? get nameSurname => Provider.of<UserProvider>(context, listen: false).namesurname;
  String? get uid => Provider.of<UserProvider>(context, listen: false).uid;

  //Variables for selecting Province and District
  List<String> ilcelerr = [];
  late String selectedProvince;
  late String selectedDistrict;

  //Variables for selecting Category
  late List<String>? selectedCategoryList;
  late String selectedCategory;

  //bloc
  late CreateRoomBloc _createRoomBloc;

  @override
  void initState() {
    super.initState();
    selectedCategoryList = [];
    selectedProvince = '';
    selectedDistrict = '';
    LocationPermissionManager(_currentP, _createEventRoomViewModel.locationController, onLocationChanged: (LatLng location) {
      setState(() {
        _currentP = location;
      });
    }).getLocationUpdates();
    _createRoomBloc = CreateRoomBloc();
    _createRoomBloc.add(FetchDataEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _createRoomBloc.close();
    _createEventRoomViewModel.eventPlaceDescriptionController.dispose();
    _createEventRoomViewModel.eventDateController.dispose();
    _createEventRoomViewModel.eventDescriptionController.dispose();
    _createEventRoomViewModel.eventNameController.dispose();
    _createEventRoomViewModel.eventTimeController.dispose();
    _createEventRoomViewModel.eventCategoryController.dispose();
  }

  // Completing CallBack Function on getPlaceDetails function
  void setAddress(String address) {
    setState(() {
      _createEventRoomViewModel.eventPlaceDescriptionController.text = address;
    });
  }

  Future<void> _selectDate() async {
    await _createEventRoomViewModel.selectDate(context);
  }

  Future<void> _selectTime() async {
    await _createEventRoomViewModel.selectTime(context);
  }
}
