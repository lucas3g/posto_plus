// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posto_plus/app/core_module/services/license/bloc/events/license_events.dart';
import 'package:posto_plus/app/core_module/services/license/bloc/states/license_states.dart';
import 'package:posto_plus/app/core_module/services/license/domain/usecases/get_date_license_usecase.dart';
import 'package:posto_plus/app/core_module/services/license/domain/usecases/verify_license_usecase.dart';

class LicenseBloc extends Bloc<LicenseEvents, LicenseStates> {
  final IVerifyLicenseUseCase verifyLicenseUseCase;
  final IGetDateLicenseUseCase getDateLicenseUseCase;

  LicenseBloc({
    required this.verifyLicenseUseCase,
    required this.getDateLicenseUseCase,
  }) : super(InitialLicense()) {
    on<VerifyLicenseEvent>(_verifyLicense);
    on<GetDateLicenseEvent>(_getDateLicense);
  }

  Future _verifyLicense(VerifyLicenseEvent event, emit) async {
    emit(LoadingLicense());

    final result = await verifyLicenseUseCase(event.deviceInfo);

    result.fold(
      (success) {
        if (success.ativa == 'S') {
          return emit(LicenseActive());
        }

        if (success.ativa == 'N') {
          return emit(LicenseNotActive());
        }

        return emit(LicenseNotFound());
      },
      (failure) => emit(ErrorLicense(message: failure.message)),
    );
  }

  Future _getDateLicense(GetDateLicenseEvent event, emit) async {
    emit(LoadingLicense());

    final result = await getDateLicenseUseCase();

    result.fold(
      (success) => emit(DateLicense(dateTime: success)),
      (failure) => emit(ErrorLicense(message: failure.message)),
    );
  }
}
