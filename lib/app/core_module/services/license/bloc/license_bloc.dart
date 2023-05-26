// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posto_plus/app/core_module/services/license/bloc/events/license_events.dart';
import 'package:posto_plus/app/core_module/services/license/bloc/states/license_states.dart';
import 'package:posto_plus/app/core_module/services/license/domain/usecases/verify_license_usecase.dart';

class LicenseBloc extends Bloc<LicenseEvents, LicenseStates> {
  final IVerifyLicenseUseCase verifyLicenseUseCase;

  LicenseBloc({
    required this.verifyLicenseUseCase,
  }) : super(InitialLicense()) {
    on<VerifyLicenseEvent>(_verifyLicense);
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
}
