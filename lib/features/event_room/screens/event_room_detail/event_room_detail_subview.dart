part of 'event_room_detail_view.dart';

class UserIsCreatorUI extends StatelessWidget {
  const UserIsCreatorUI({
    super.key,
    required this.anaResimHeight,
    required this.widget,
    required this.top,
    required this.containerHeight,
    required this.mapTheme,
    required this.googleMapController,
  });

  final double anaResimHeight;
  final EventRoomDetail widget;
  final double top;
  final double containerHeight;
  final String mapTheme;
  final Completer<GoogleMapController> googleMapController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Image.asset(
                'assets/images/login_background.jpg',
                fit: BoxFit.cover,
                height: anaResimHeight,
                width: double.infinity,
              ),
              Positioned(
                top: 30,
                right: 25,
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PendingApprovalUsersView(
                        event: widget.event,
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: buttonColor2,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 50,
                    width: 50,
                    child: Center(
                      child: Icon(
                        Icons.emoji_people_sharp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 120,
                right: 25,
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Messages(
                        event: widget.event,
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: buttonColor2,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 50,
                    width: 50,
                    child: Center(
                      child: Icon(
                        Icons.message,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 25,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: buttonColor2,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 50,
                    width: 50,
                    child: Center(
                      child: Icon(
                        Icons.navigate_before_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 15,
                top: top,
                child: Container(
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: containerHeight,
                  width: 85,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Çar', style: TextStyle(color: thirdTextColor, fontSize: 20)),
                      Text('28', style: TextStyle(color: primaryColor, fontSize: 27, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const HeightBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 26, right: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.event.eventName,
                  style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.w500),
                ),
                const HeightBox(height: 5),
                const HeightBox(height: 10),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.event.categories.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 40,
                        width: 90,
                        decoration: BoxDecoration(
                          color: buttonColor2,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Center(
                          child: Text(
                            widget.event.categories[index].name,
                            style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const HeightBox(height: 15),
                Container(
                    height: 150,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: buttonColor2,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.location_city),
                            Icon(Icons.people),
                          ],
                        ),
                        //ince bir çizgi çekmek için
                        Container(
                          height: 1,
                          width: MediaQuery.sizeOf(context).width,
                          color: Colors.grey[800],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.event.province + ' / ' + widget.event.district,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            Text(widget.event.approvedUsers.length.toString() + 'Katılımcı: '),
                          ],
                        )
                      ],
                    )),
                const HeightBox(height: 15),
                Text(
                  'Açıklama',
                  style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
                ),
                const HeightBox(height: 10),
                Text(
                  widget.event.eventDetail,
                  style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 1),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  height: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: InteractiveViewer(
                      child: GoogleMap(
                        onMapCreated: (GoogleMapController controller) {
                          controller.setMapStyle(mapTheme);
                          googleMapController.complete(controller);
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(41.3766, 33.7765),
                          zoom: 16,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId('_currentLocation'),
                            position: LatLng(41.3766, 33.7765),
                          ),
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserisPendingUI extends StatelessWidget {
  const UserisPendingUI({
    super.key,
    required this.anaResimHeight,
    required this.top,
    required this.containerHeight,
    required this.widget,
  });

  final double anaResimHeight;
  final double top;
  final double containerHeight;
  final EventRoomDetail widget;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Image.asset(
                'assets/images/login_background.jpg',
                fit: BoxFit.cover,
                height: anaResimHeight,
                width: double.infinity,
              ),
              Positioned(
                top: 30,
                left: 25,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: buttonColor2,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 50,
                    width: 50,
                    child: Center(
                      child: Icon(
                        Icons.navigate_before_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 15,
                top: top,
                child: Container(
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: containerHeight,
                  width: 85,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Çar', style: TextStyle(color: thirdTextColor, fontSize: 20)),
                      Text('28', style: TextStyle(color: primaryColor, fontSize: 27, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const HeightBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 26, right: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.event.eventName,
                  style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.w500),
                ),
                const HeightBox(height: 5),
                const HeightBox(height: 10),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.event.categories.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 40,
                        width: 90,
                        decoration: BoxDecoration(
                          color: buttonColor2,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Center(
                          child: Text(
                            widget.event.categories[index].name,
                            style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const HeightBox(height: 15),
                Container(
                    height: 150,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: buttonColor2,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.location_city),
                            Icon(Icons.people),
                          ],
                        ),
                        //ince bir çizgi çekmek için
                        Container(
                          height: 1,
                          width: MediaQuery.sizeOf(context).width,
                          color: Colors.grey[800],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.event.province + ' / ' + widget.event.district,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            Text(widget.event.approvedUsers.length.toString() + 'Katılımcı: '),
                          ],
                        )
                      ],
                    )),
                const HeightBox(height: 15),
                Text(
                  'Açıklama',
                  style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
                ),
                const HeightBox(height: 10),
                Text(
                  widget.event.eventDetail,
                  style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 1),
                ),
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.1,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text('Katılma isteği gönderildi. Onay bekleniyor.', style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserisApprovedUI extends StatelessWidget {
  const UserisApprovedUI({
    super.key,
    required this.anaResimHeight,
    required this.top,
    required this.containerHeight,
    required this.widget,
    required this.mapTheme,
    required this.googleMapController,
  });

  final double anaResimHeight;
  final double top;
  final double containerHeight;
  final EventRoomDetail widget;
  final String mapTheme;
  final Completer<GoogleMapController> googleMapController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Image.asset(
                'assets/images/login_background.jpg',
                fit: BoxFit.cover,
                height: anaResimHeight,
                width: double.infinity,
              ),
              Positioned(
                top: 30,
                left: 25,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: buttonColor2,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 50,
                    width: 50,
                    child: Center(
                      child: Icon(
                        Icons.navigate_before_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                right: 25,
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Messages(
                        event: widget.event,
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: buttonColor2,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 50,
                    width: 50,
                    child: Center(
                      child: Icon(
                        Icons.message,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 15,
                top: top,
                child: Container(
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: containerHeight,
                  width: 85,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Çar', style: TextStyle(color: thirdTextColor, fontSize: 20)),
                      Text('28', style: TextStyle(color: primaryColor, fontSize: 27, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const HeightBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 26, right: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.event.eventName,
                  style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.w500),
                ),
                const HeightBox(height: 5),
                const HeightBox(height: 10),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.event.categories.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 40,
                        width: 90,
                        decoration: BoxDecoration(
                          color: buttonColor2,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Center(
                          child: Text(
                            widget.event.categories[index].name,
                            style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const HeightBox(height: 15),
                Container(
                    height: 150,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: buttonColor2,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.location_city),
                            Icon(Icons.people),
                          ],
                        ),
                        //ince bir çizgi çekmek için
                        Container(
                          height: 1,
                          width: MediaQuery.sizeOf(context).width,
                          color: Colors.grey[800],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.event.province + ' / ' + widget.event.district,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            Text(widget.event.approvedUsers.length.toString() + 'Katılımcı: '),
                          ],
                        )
                      ],
                    )),
                const HeightBox(height: 15),
                Text(
                  'Açıklama',
                  style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
                ),
                const HeightBox(height: 10),
                Text(
                  widget.event.eventDetail,
                  style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 1),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  height: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: InteractiveViewer(
                      child: GoogleMap(
                        onMapCreated: (GoogleMapController controller) {
                          controller.setMapStyle(mapTheme);
                          googleMapController.complete(controller);
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(41.3766, 33.7765),
                          zoom: 16,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId('_currentLocation'),
                            position: LatLng(41.3766, 33.7765),
                          ),
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserisNotCreatorUI extends StatelessWidget {
  const UserisNotCreatorUI({
    super.key,
    required this.anaResimHeight,
    required this.top,
    required this.containerHeight,
    required this.widget,
    required this.eventRoomService,
    required this.uid,
    required this.nameSurname,
  });

  final double anaResimHeight;
  final double top;
  final double containerHeight;
  final EventRoomDetail widget;
  final EventRoomService eventRoomService;
  final String uid;
  final String nameSurname;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Image.asset(
                'assets/images/login_background.jpg',
                fit: BoxFit.cover,
                height: anaResimHeight,
                width: double.infinity,
              ),
              Positioned(
                top: 30,
                left: 25,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: buttonColor2,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 50,
                    width: 50,
                    child: Center(
                      child: Icon(
                        Icons.navigate_before_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 15,
                top: top,
                child: Container(
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: containerHeight,
                  width: 85,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Çar', style: TextStyle(color: thirdTextColor, fontSize: 20)),
                      Text('28', style: TextStyle(color: primaryColor, fontSize: 27, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const HeightBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 26, right: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.event.eventName,
                  style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.w500),
                ),
                const HeightBox(height: 5),
                const HeightBox(height: 10),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.event.categories.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 40,
                        width: 90,
                        decoration: BoxDecoration(
                          color: buttonColor2,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Center(
                          child: Text(
                            widget.event.categories[index].name,
                            style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const HeightBox(height: 15),
                Container(
                    height: 150,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: buttonColor2,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.location_city),
                            Icon(Icons.people),
                          ],
                        ),
                        //ince bir çizgi çekmek için
                        Container(
                          height: 1,
                          width: MediaQuery.sizeOf(context).width,
                          color: Colors.grey[800],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.event.province + ' / ' + widget.event.district,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            Text(widget.event.approvedUsers.length.toString() + 'Katılımcı: '),
                          ],
                        )
                      ],
                    )),
                const HeightBox(height: 15),
                Text(
                  'Açıklama',
                  style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
                ),
                const HeightBox(height: 10),
                Text(
                  widget.event.eventDetail,
                  style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 1),
                ),
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.1,
                  margin: EdgeInsets.only(bottom: 10),
                  child: SlideAction(
                    textStyle: TextStyle(fontSize: 16, color: thirdTextColor),
                    sliderRotate: false, // açıkken slide döne döne gidiyor
                    text: 'Katılma İsteği Gönder',
                    elevation: 0, // olmazsa aşağıdan gölge veriyo
                    sliderButtonIcon: Icon(Icons.cancel, color: primaryColor),
                    innerColor: buttonColor2, // İç buton rengi
                    outerColor: buttonColor, // Genel kapsayan rengi
                    onSubmit: () {
                      eventRoomService.addPendingUser(docId: widget.event.docId!, uid: uid, namesurname: nameSurname);
                    },
                  ),
                ),
                ElevatedButton(onPressed: () => eventRoomService.addPendingUser(docId: widget.event.docId!, uid: uid, namesurname: nameSurname), child: Text('istek gönder'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class UserIsNotCreatorUI extends StatelessWidget {
//   const UserIsNotCreatorUI({
//     super.key,
//     required this.anaResimHeight,
//     required this.top,
//     required this.containerHeight,
//     required this.widget,
//   });

//   final double anaResimHeight;
//   final double top;
//   final double containerHeight;
//   final EventRoomDetail widget;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             clipBehavior: Clip.none,
//             children: <Widget>[
//               Image.asset(
//                 'assets/images/login_background.jpg',
//                 fit: BoxFit.cover,
//                 height: anaResimHeight,
//                 width: double.infinity,
//               ),
//               Positioned(
//                 top: 30,
//                 left: 25,
//                 child: InkWell(
//                   onTap: () => Navigator.pop(context),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: buttonColor2,
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     height: 50,
//                     width: 50,
//                     child: Center(
//                       child: Icon(
//                         Icons.navigate_before_outlined,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 right: 15,
//                 top: top,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: buttonColor,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   height: containerHeight,
//                   width: 85,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('Çar', style: TextStyle(color: thirdTextColor, fontSize: 20)),
//                       Text('28', style: TextStyle(color: primaryColor, fontSize: 27, fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const HeightBox(height: 25),
//           Padding(
//             padding: const EdgeInsets.only(left: 26, right: 26),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.event.eventName,
//                   style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.w500),
//                 ),
//                 const HeightBox(height: 5),
//                 const HeightBox(height: 10),
//                 Container(
//                   height: 40,
//                   width: MediaQuery.of(context).size.width,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: widget.event.categories.length,
//                     itemBuilder: (context, index) {
//                       return Container(
//                         height: 40,
//                         width: 90,
//                         decoration: BoxDecoration(
//                           color: buttonColor2,
//                           borderRadius: BorderRadius.circular(13),
//                         ),
//                         child: Center(
//                           child: Text(
//                             widget.event.categories[index].name,
//                             style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 const HeightBox(height: 15),
//                 Container(
//                     height: 150,
//                     width: MediaQuery.sizeOf(context).width,
//                     decoration: BoxDecoration(
//                       color: buttonColor2,
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Icon(Icons.location_city),
//                             Icon(Icons.people),
//                           ],
//                         ),
//                         //ince bir çizgi çekmek için
//                         Container(
//                           height: 1,
//                           width: MediaQuery.sizeOf(context).width,
//                           color: Colors.grey[800],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Text(
//                               widget.event.province + ' / ' + widget.event.district,
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 14,
//                               ),
//                             ),
//                             Text(widget.event.approvedUsers.length.toString() + 'Katılımcı: '),
//                           ],
//                         )
//                       ],
//                     )),
//                 const HeightBox(height: 15),
//                 Text(
//                   'Açıklama',
//                   style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
//                 ),
//                 const HeightBox(height: 10),
//                 Text(
//                   widget.event.eventDetail,
//                   style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 1),
//                 ),
//                 Container(
//                   height: MediaQuery.sizeOf(context).height * 0.1,
//                   margin: EdgeInsets.only(bottom: 10),
//                   child: SlideAction(
//                     textStyle: TextStyle(fontSize: 16, color: thirdTextColor),
//                     sliderRotate: false, // açıkken slide döne döne gidiyor
//                     text: 'Katılma İsteği Gönder',
//                     elevation: 0, // olmazsa aşağıdan gölge veriyo
//                     sliderButtonIcon: Icon(Icons.cancel, color: primaryColor),
//                     innerColor: buttonColor2, // İç buton rengi
//                     outerColor: buttonColor, // Genel kapsayan rengi
//                     onSubmit: () {
//                       eventRoomService.addPendingUser(docId: eventRoomData!.docId!, uid: uid!, namesurname: namesurname!);
//                     },
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
