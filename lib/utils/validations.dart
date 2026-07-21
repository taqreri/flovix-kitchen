class Validations {
  static bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return password.length >= 6;
  }

  static bool isValidPhone(String phone) {
    return RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(phone);
  }

  static bool isValidName(String name) {
    return name.isNotEmpty;
  }

  static bool isValidUrl(String url) {
    return RegExp(
            r"^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$")
        .hasMatch(url);
  }

  static bool isValidNumber(String number) {
    return RegExp(r'^[0-9]+$').hasMatch(number);
  }

  static bool isValidPercentage(String percentage) {
    return RegExp(r'^[0-9]+$').hasMatch(percentage);
  }

  static bool isValidDate(String date) {
    return RegExp(r'^\d{4}-(0?[1-9]|1[012])-(0?[1-9]|[12][0-9]|3[01])$')
        .hasMatch(date);
  }

  static bool isValidTime(String time) {
    return RegExp(r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$').hasMatch(time);
  }

  static bool isValidDateTime(String dateTime) {
    return RegExp(
            r'^\d{4}-(0?[1-9]|1[012])-(0?[1-9]|[12][0-9]|3[01]) ([01]?[0-9]|2[0-3]):[0-5][0-9]$')
        .hasMatch(dateTime);
  }

  static bool isValidZipCode(String zipCode) {
    return RegExp(r'^[0-9]{5}$').hasMatch(zipCode);
  }

  static bool isValidIBAN(String iban) {
    return RegExp(r'^[A-Z]{2}[0-9]{2}[a-zA-Z0-9]{1,30}$').hasMatch(iban);
  }

  static bool isValidCVV(String cvv) {
    return RegExp(r'^[0-9]{3,4}$').hasMatch(cvv);
  }

  static bool isValidCardNumber(String cardNumber) {
    return RegExp(r'^[0-9]{16}$').hasMatch(cardNumber);
  }
}
