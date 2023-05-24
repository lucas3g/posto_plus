abstract class LicenseStates {}

class InitialLicense extends LicenseStates {}

class LoadingLicense extends LicenseStates {}

class DateLicense extends LicenseStates {
  final DateTime dateTime;

  DateLicense({
    required this.dateTime,
  });
}

class LicenseActive extends LicenseStates {}

class LicenseNotActive extends LicenseStates {}

class LicenseNotFound extends LicenseStates {}

class ErrorLicense extends LicenseStates {
  final String message;

  ErrorLicense({
    required this.message,
  });
}
