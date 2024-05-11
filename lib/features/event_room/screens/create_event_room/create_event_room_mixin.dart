part of 'create_event_room_view.dart';

mixin CreateEventRoomPageMixin on State<CreateEventRoomPage> {
  // For getting the width and height of the screen
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  //Services
  final EventRoomService _eventRoomService = EventRoomService();

  //View Model
  final CreateEventRoomViewModel _createEventRoomViewModel = CreateEventRoomViewModel();

  //Provider
  String? get nameSurname => Provider.of<UserProvider>(context, listen: false).namesurname;
  String? get uid => Provider.of<UserProvider>(context, listen: false).uid;

  //Variables for selecting Category
  late List<String>? selectedCategoryList;
  late String selectedCategory;

  //bloc
  late CreateRoomBloc _createRoomBloc;

  @override
  void initState() {
    super.initState();
    selectedCategoryList = [];
    _createRoomBloc = CreateRoomBloc();
    _createRoomBloc.add(FetchDataEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _createRoomBloc.close();
    _createEventRoomViewModel.eventDateController.dispose();
    _createEventRoomViewModel.eventDescriptionController.dispose();
    _createEventRoomViewModel.eventNameController.dispose();
    _createEventRoomViewModel.eventTimeController.dispose();
    _createEventRoomViewModel.eventCategoryController.dispose();
  }

  Future<void> navigateToHomeOnComplete() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushNamed(context, '/homepage');
  }

  Future<void> _selectDate() async {
    await _createEventRoomViewModel.selectDate(context);
  }

  Future<void> _selectTime() async {
    await _createEventRoomViewModel.selectTime(context);
  }
}
