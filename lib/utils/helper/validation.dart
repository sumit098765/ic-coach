class Validation {
  static String? firstName(String? value) {
    if (value!.isEmpty) return 'First Name is Required';
    return null;
  }

  static String? lastName(String? value) {
    if (value!.isEmpty) return 'Last Name is Required';
    return null;
  }

  static String? address1(String? value) {
    if (value!.isEmpty) return 'Address 1 is Required';
    return null;
  }

  static String? phoneNumber(String? value) {
    if (value!.isEmpty) {
      return 'Phone No. is Required';
    } else if (value.length < 10) {
      return 'Phone No. should be of 10 digits';
    }
    return null;
  }

  static String? address2(String? value) {
    if (value!.isEmpty) return 'Address 2 is Required';
    return null;
  }

  static String? pincode(String? value) {
    if (value!.isEmpty) {
      return 'Pincode is Required';
    } else if (value.length < 6 || value.length > 6) {
      return 'Pincode should be of 6 digits';
    }

    return null;
  }

  static String? city(String? value) {
    if (value!.isEmpty) return 'City name is Required';
    return null;
  }

  static String? country(String? value) {
    if (value!.isEmpty) return 'Country name is Required';
    return null;
  }

  static String? state(String? value) {
    if (value == null || value.isEmpty || value == "Select State") {
      return 'State name is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!_isValidEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static bool _isValidEmail(String value) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
  }

  static String? coupon(String? value) {
    if (value!.isEmpty) return 'Coupon is Required';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8 && !hasLetterAndNumber(value)) {
      return 'Password must be at least 8 characters long';
    } 
    else if (!hasLetterAndNumber(value)) {
      return '''Password must contain numeric character.''';
    }

    return null;
  }

  static String? confirmPassword({String? value, String? newPassword}) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required';
    } else if (value != newPassword) {
      return 'Confirm Password is not same as New password';
    }

    return null;
  }

  static bool hasLetterAndNumber(String value) {
    RegExp regex = RegExp(r'^(?=.{8,})(?=.*[a-z])(?=.*\d).*$');
    // RegExp regex = RegExp(r'^(?=.{8,})(?=.*[a-z])(?=.*[A-Z])(?=.*[^\w\d]).*$');
    return regex.hasMatch(value);
  }

  static String? emailOrPhone(String input) {
    final emailRegex = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");
    final phoneRegex = RegExp(r"^\+?\d{10,15}$");

    if (input.isEmpty) return 'Please Enter Email or Phone';
    if (emailRegex.hasMatch(input)) {
      return null;
    } else if (phoneRegex.hasMatch(input)) {
      return null;
    } else if (input.contains(RegExp("[a-zA-Z@.]"))) {
      return 'Please enter a valid email address';
    } else if (input.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}
