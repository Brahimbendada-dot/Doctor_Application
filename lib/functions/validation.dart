String? validation(String? val, String type) {
  if (val!.isEmpty || val == ' ') {
    return 'Field is Empty';
  }
  if (type == 'user_name') {
    if (val.length < 5) {
      return 'Great then 5 letter';
    }
  }
  if (type == 'address') {
    if (val.length < 5) {
      return 'Great then 5 letter';
    }
  }
  if (type == 'phone') {
    if (val.length > 10 || val.length < 10) {
      return 'it\'s necessary enter just 10 numbers';
    }
  }
  return null;
}
