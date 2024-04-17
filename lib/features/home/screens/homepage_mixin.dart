part of 'homepage_view.dart';

mixin HomePageMixin on State<HomePage> {
  // Services
  final LocalDataService localDataService = LocalDataService();
  UserProvider userProvider = UserProvider();

  // Sayfa boyutlarını almak için
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  // Kullanıcı bilgileri
  String? email;
  String? uid;
  String? namesurname;

  // Kullanıcı bilgilerini Local'den getir
  Future<void> loadUserDataFromStorage() async {
    email = await localDataService.getStringData('userEmail');
    uid = await localDataService.getStringData('userId');
    setState(() {});
  }

  //Fetch user data from with getUserDetails method and set username
  Future<void> getUserDetails() async {
    final userData = await AuthService().getUserDetails(email!);
    namesurname = userData.namesurname;
    Provider.of<UserProvider>(context, listen: false).setNameSurname(namesurname!);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadUserDataFromStorage().then((value) async {
      await AuthService().getUserDetails(email!);
      await getUserDetails();

      Provider.of<UserProvider>(context, listen: false).setUid(uid!);
    });
  }
}
