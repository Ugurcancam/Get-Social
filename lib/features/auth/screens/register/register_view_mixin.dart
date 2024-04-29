part of 'register_view.dart';

mixin RegisterViewMixin on State<RegisterView> {
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  final RegisterViewModel registerViewModel = RegisterViewModel();

  //Service
  final ProvinceService provinceService = ProvinceService();

  //Variables for selecting Province and District
  late List<String> provinces;
  List<String> ilcelerr = [];
  late String selectedProvince;
  late String selectedDistrict;
  // Textfield'lar için controller'lar
  final TextEditingController nameSurnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController checkPasswordController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();

  // Controller'dan gelen verileri almak için
  String get valueByNameSurnameController => nameSurnameController.value.text;
  String get valueByEmailController => emailController.value.text;
  String get valueByPasswordController => passwordController.value.text;
  String get valueByCheckPasswordController => checkPasswordController.value.text;
  String get valueByDateOfBirthController => dateOfBirthController.value.text;
  String get valueByProvinceController => provinceController.value.text;

  // Sayfa boyutlarını almak için
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  @override
  void initState() {
    super.initState();
    getProvinces();
  }

  Future<void> getProvinces() async {
    final provinceData = await provinceService.getProvinces();
    setState(() {
      provinces = provinceData;
    });
  }
}
