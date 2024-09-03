import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dunder_mifflin/data/blocs/profile_event.dart';
import 'package:dunder_mifflin/data/blocs/profile_state.dart';
import 'package:dunder_mifflin/data/models/user_model.dart';
import 'package:dunder_mifflin/data/repositories/user_repository.dart';
import 'package:path_provider/path_provider.dart';

class ProfileBloc {
  final _repository = UserRepository();

  final StreamController<ProfileEvent> _inputProfileController = StreamController<ProfileEvent>();

  final StreamController<ProfileState> _outputProfileController = StreamController<ProfileState>();

  Sink<ProfileEvent> get inputProfile => _inputProfileController.sink;
  Stream<ProfileState> get outputProfile => _outputProfileController.stream;

  ProfileBloc() {
    _inputProfileController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(ProfileEvent event) async {
    UserProfile userProfileResponse = UserProfile();

    _outputProfileController.add(ProfileLoadingState());

    if (event is GetProfile) {
      try {
        userProfileResponse = await _repository.getProfile();

        if (userProfileResponse.user != null && userProfileResponse.user!.userPhoto != null && userProfileResponse.user!.userPhoto!.isNotEmpty) {
          File userImage = await convertBase64ToFile(userProfileResponse.user!.userPhoto!, 'user_photo.png');

          userProfileResponse.user!.userPhoto = userImage.path;
        }

        _outputProfileController.add(ProfileLoadedState(userProfile: userProfileResponse));
      } catch (e) {
        final Exception exception;
        exception = Exception('Unknown error occurred: $e');
        _outputProfileController.add(ProfileErrorState(exception: exception));
      }
    }

    if (event is PostProfileChange) {
      if (event.user.userPhoto != null && event.user.userPhoto!.isNotEmpty) {
        await _repository.updateImageProfile(event.user.userPhoto!);
      }
      var responseProfileUpdate = await _repository.updateProfile(event.user);

      if (responseProfileUpdate) {
        userProfileResponse = await _repository.getProfile();

        if (userProfileResponse.user != null && userProfileResponse.user!.userPhoto != null && userProfileResponse.user!.userPhoto!.isNotEmpty) {
          File userImage = await convertBase64ToFile(userProfileResponse.user!.userPhoto!, 'user_photo.png');

          userProfileResponse.user!.userPhoto = userImage.path;
        }

        _outputProfileController.add(ProfileLoadedState(userProfile: userProfileResponse));
      }
    }
  }

  Future<File> convertBase64ToFile(String base64String, String fileName) async {
    // Decodifica a string Base64 em bytes
    Uint8List bytes = base64Decode(base64String);

    // Obtém o diretório temporário ou um diretório específico para salvar a imagem
    Directory tempDir = await getTemporaryDirectory();
    String filePath = '${tempDir.path}/$fileName';

    // Cria o arquivo e grava os bytes nele
    File file = File(filePath);
    await file.writeAsBytes(bytes);

    return file;
  }
}
