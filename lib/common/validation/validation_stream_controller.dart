import 'validation_string.dart';

String emailValidationMsg(String email) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (email.isEmpty) {
    return error_required_email;
  } else if (regex.hasMatch(email)) {
    return error_valid;
  } else
    return error_valid_email;
}

String passwordValidationMsg(String password) {
  if (password.isEmpty || password == "")
    return error_required_password;
  else if (password.length < 6)
    return error_minimum_6_character;
  else
    return "";
}

String mobileValidationMsg(String mobile) {
  if (mobile.isEmpty || mobile == "")
    return error_required_mobile_number;
  else if (mobile.length < 10 || mobile.length > 10)
    return error_valid_mobile_number;
  else
    return "";
}

String nameValidationMsg(String name) =>
    name.isEmpty || name == "" ? error_required_name : "";

String ageValidationMsg(String age) =>
    age.isEmpty || age == "" ? error_required_age : "";

String dobValidationMsg(String dob) =>
    dob.isEmpty || dob == "" ? error_required_dob : "";
