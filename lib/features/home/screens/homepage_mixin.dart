part of 'homepage_view.dart';

mixin HomePageMixin on State<HomePage> {
  // Services
  final LocalDataService localDataService = LocalDataService();
  UserProvider userProvider = UserProvider();
  final homePageBloc = HomePageBloc();

  // Sayfa boyutlarını almak için
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  // get logged in users email
  final email = FirebaseAuth.instance.currentUser!.email;

  // Variables for selecting Province and District
  List<String> ilcelerr = [];
  late String selectedProvince;
  late String selectedDistrict;

  // Kullanıcı bilgilerini Local'den getir
  // Future<void> loadUserDataFromStorage() async {
  //   email = await localDataService.getStringData('userEmail');
  //   uid = await localDataService.getStringData('userId');
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    // loadUserDataFromStorage().then((value) async {
    //   await AuthService().getUserDetails(email!);
    //   await getUserDetails();
    //   Provider.of<UserProvider>(context, listen: false).setUid(uid!);
    // });
    homePageBloc.add(GetHomePageData(userEmail: email!));
  }
}
