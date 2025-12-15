import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dental_pt/core/network/network_info.dart';
import 'package:dental_pt/core/strings/failure_and_exception.dart';
import 'package:dental_pt/features/Patient%20registration/domain/entities/patient.dart';
import 'package:dental_pt/features/Patient%20registration/domain/usecases/register_patient_usecase.dart';
import 'package:dental_pt/features/Patient%20registration/domain/usecases/pick_image_usecase.dart';
part 'patient_registration_event.dart';
part 'patient_registration_state.dart';

class PatientRegistrationBloc
    extends Bloc<PatientRegistrationEvent, PatientRegistrationState> {
  final NetworkInfo networkInfo;
  final RegisterPatientUseCase registerPatientUseCase;
  final PickImageUseCase pickImageUseCase;

  PatientRegistrationBloc({
    required this.networkInfo,
    required this.registerPatientUseCase,
    required this.pickImageUseCase,
  }) : super(PatientRegistrationInitial()) {
    on<RegisterPatientEvent>(_patientRegistrationRequested);
    on<PickImageEvent>(_pickImage);
  }

  Future<void> _patientRegistrationRequested(RegisterPatientEvent event,
      Emitter<PatientRegistrationState> emit) async {
    emit(PatientRegistrationLoading());
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        emit(PatientRegistrationFailure(
            error: FailureMessages.noInternetFailureMessage));
        return;
      }
      final result = await registerPatientUseCase(
        patient: event.patient,
        nationalIdFaceImage: event.nationalIdFaceImage,
        nationalIdBackImage: event.nationalIdBackImage,
      );
      result.fold((failure) {
        emit(PatientRegistrationFailure(error: failure.message));
      }, (patientId) {
        emit(PatientRegistrationSuccess(patientId: patientId));
      });
    } catch (e) {
      emit(PatientRegistrationFailure(error: e.toString()));
    }
  }

  Future<void> _pickImage(
      PickImageEvent event, Emitter<PatientRegistrationState> emit) async {
    try {
      final image = await pickImageUseCase();
      if (image != null) {
        emit(ImagePickedSuccess(image: image, imageType: event.imageType));
      } else {
        emit(PatientRegistrationFailure(error: 'No image selected'));
      }
    } catch (e) {
      emit(PatientRegistrationFailure(error: 'Failed to pick image: $e'));
    }
  }
}

