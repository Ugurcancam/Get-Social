class RegisterViewModel {
  String? validateNameSurname(String? value) {
    if (value!.isEmpty) {
      return 'Ad ve soyad alanı boş bırakılamaz';
    } else if (value.contains(RegExp(r'\d'))) {
      return 'Ad ve soyad rakam içeremez';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'E-posta alanı boş bırakılamaz';
    } else if (value.length < 6) {
      return 'E-posta en az 6 karakter olmalıdır';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Şifre alanı boş bırakılamaz';
    } else if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalıdır';
    }
    return null;
  }

  String? validateCheckPassword(String? value, String password) {
    if (value!.isEmpty) {
      return 'Şifre tekrar alanı boş bırakılamaz';
    } else if (value != password) {
      return 'Şifreler uyuşmuyor';
    }
    return null;
  }
}
