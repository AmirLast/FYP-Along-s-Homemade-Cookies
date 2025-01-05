class PasswordStrength {
  List checkpass({required String password}) {
    //check password strength
    List passStrength = [false, false, false, false]; //false for 4 category
    final lowerCase = RegExp(r'[a-z]');
    final upperCase = RegExp(r'[A-Z]');
    final specialChar =
        RegExp(r'[^a-zA-Z0-9]'); //any character that is not numbers or alphabet
    final numbers = RegExp(r'[0-9]');
    //check by criteria
    //lower case check
    passStrength[0] = lowerCase.hasMatch(password);
    //upper case check
    passStrength[1] = upperCase.hasMatch(password);
    //special character check
    passStrength[2] = specialChar.hasMatch(password);
    //numbers check
    passStrength[3] = numbers.hasMatch(password);
    return passStrength;
  }
}
