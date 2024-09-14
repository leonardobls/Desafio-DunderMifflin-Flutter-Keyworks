import 'dart:convert';
import 'dart:io';

import 'package:dunder_mifflin/components/loading_global.dart';
import 'package:dunder_mifflin/config/app_styles.dart';
import 'package:dunder_mifflin/data/blocs/profile_bloc.dart';
import 'package:dunder_mifflin/data/blocs/profile_event.dart';
import 'package:dunder_mifflin/data/blocs/profile_state.dart';
import 'package:dunder_mifflin/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
  });
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late final ProfileBloc _profileBloc;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _biographyController = TextEditingController();

  bool wasInserted = false;
  File? _selectedImage;

  User userToUpdate = User();

  @override
  void initState() {
    super.initState();
    _profileBloc = ProfileBloc();
    _profileBloc.inputProfile.add(GetProfile());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProfileState>(
      stream: _profileBloc.outputProfile,
      builder: (context, state) {
        if (state.data is ProfileLoadingState) {
          return const LoadingGlobal();
        }
        if (state.data is ProfileLoadedState) {
          final UserProfile profile = state.data?.userProfile ?? UserProfile();
          _nameController.text = profile.user!.name != null && profile.user!.name!.isNotEmpty ? profile.user!.name! : "";

          _emailController.text = profile.user!.emailAddress != null && profile.user!.emailAddress!.isNotEmpty ? profile.user!.emailAddress! : "";

          _biographyController.text = profile.user!.biography != null && profile.user!.biography!.isNotEmpty ? profile.user!.biography! : "";

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              backgroundColor: Colors.white,
              title: const SizedBox(
                width: double.infinity,
                child: Text(
                  "Perfil",
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            useRootNavigator: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            backgroundColor: Colors.white,
                            builder: (BuildContext context) {
                              return imageModal();
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          decoration: const BoxDecoration(
                            color: Color(0xFFD8E2FF),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(500),
                                ),
                                child: SizedBox(
                                  width: 62,
                                  height: 62,
                                  child: profile.user!.userPhoto != null && profile.user!.userPhoto!.isEmpty && !wasInserted
                                      ? Image.asset(
                                          "assets/images/default-profile.png",
                                          fit: BoxFit.cover,
                                        )
                                      : !wasInserted
                                          ? Image.file(
                                              File(
                                                profile.user!.userPhoto!,
                                              ),
                                              fit: BoxFit.cover,
                                            )
                                          : Image.file(
                                              _selectedImage!,
                                              fit: BoxFit.cover,
                                            ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: "Nome Completo",
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 16,
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                errorStyle: TextStyle(
                                  color: AppStyles.errorColor,
                                ),
                                focusColor: AppStyles.primaryColor,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppStyles.primaryColor,
                                    width: 1,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppStyles.errorColor,
                                    width: 1,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppStyles.errorColor,
                                    width: 1,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                    width: 1,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Campo obrigatório";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 45),
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: "E-mail",
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 16,
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                errorStyle: TextStyle(
                                  color: AppStyles.errorColor,
                                ),
                                focusColor: AppStyles.primaryColor,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppStyles.primaryColor,
                                    width: 1,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppStyles.errorColor,
                                    width: 1,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppStyles.errorColor,
                                    width: 1,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                    width: 1,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Campo obrigatório";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 45),
                            TextFormField(
                              controller: _biographyController,
                              maxLines: 8,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                hintText: "Biografia (opcional)",
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 16,
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  color: AppStyles.primaryGrayColor,
                                ),
                                errorStyle: TextStyle(
                                  color: AppStyles.errorColor,
                                ),
                                focusColor: AppStyles.primaryColor,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppStyles.primaryColor,
                                    width: 1,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppStyles.errorColor,
                                    width: 1,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppStyles.errorColor,
                                    width: 1,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                    width: 1,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Campo obrigatório";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 45),
                            InkWell(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  userToUpdate.id = profile.user!.id;
                                  userToUpdate.emailAddress = _emailController.text;
                                  userToUpdate.name = _nameController.text;
                                  userToUpdate.biography = _biographyController.text;

                                  if (_selectedImage != null) {
                                    String imageBase64 = base64Encode(_selectedImage!.readAsBytesSync());
                                    userToUpdate.userPhoto = imageBase64;
                                  }

                                  _profileBloc.inputProfile.add(PostProfileChange(user: userToUpdate));
                                }
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: AppStyles.primaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(200),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.save,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Salvar",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: Text("Error"),
          );
        }
      },
    );
  }

  Widget imageModal() {
    return SafeArea(
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.photo_library,
                            color: Color(0xFF4D4D4D),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Escolher na biblioteca",
                            style: TextStyle(
                              color: Color(0xFF4D4D4D),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        _takePickFromCamera();
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Color(0xFF4D4D4D),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Tirar foto",
                            style: TextStyle(
                              color: Color(0xFF4D4D4D),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: Color(0xFFC00000),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Remover foto atual",
                            style: TextStyle(
                              color: Color(0xFFC00000),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 4,
              child: Center(
                child: Container(
                  width: 32,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: Color(0xFF77777A),
                    borderRadius: BorderRadius.all(
                      Radius.circular(200),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage != null) {
      setState(() {
        wasInserted = true;
        _selectedImage = File(returnedImage.path);
      });
    }
  }

  Future _takePickFromCamera() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage != null) {
      setState(() {
        wasInserted = true;
        _selectedImage = File(returnedImage.path);
      });
    }
  }
}
