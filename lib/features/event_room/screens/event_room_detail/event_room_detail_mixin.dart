part of 'event_room_detail_view.dart';

mixin EventRoomDetailMixin on State<EventRoomDetail> {
  // For getting the width and height of the screen
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  final EventRoomService eventRoomService = EventRoomService();
  String get nameSurname => Provider.of<UserProvider>(context, listen: false).namesurname!;

  // get the logged in users uid
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  late EventDetailBloc _eventRoomDetailBloc;

  final Completer<GoogleMapController> googleMapController = Completer();

  void share() {
    Share.share('https://etkinlikapp.com/event/${widget.event.eventName}');
    print('object');
  }

  @override
  void initState() {
    super.initState();
    _eventRoomDetailBloc = EventDetailBloc(widget.event);
    _eventRoomDetailBloc.add(GetEventDetail(uid: uid));
  }
}
