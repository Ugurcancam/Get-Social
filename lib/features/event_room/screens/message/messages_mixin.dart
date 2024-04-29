part of 'messages_view.dart';

mixin MessagesMixin on State<Messages> {
  // For getting the width and height of the screen
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  // get the logged in users data
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  String get nameSurname => Provider.of<UserProvider>(context, listen: false).namesurname!;

  //Service
  final _eventRoomService = EventRoomService();

  //ViewModel
  final _messageViewModel = MessageViewModel();

  // Send message to the firestore
  Future<void> sendMessage() async {
    await _messageViewModel.sendMessage(widget.event.docId!, uid, nameSurname);
  }

  @override
  void dispose() {
    super.dispose();
    _messageViewModel.sendMessageController.dispose();
    _eventRoomService.getMessagesStream(docId: widget.event.docId!).listen((event) {}).cancel();
  }
}
