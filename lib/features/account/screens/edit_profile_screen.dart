import 'dart:async';
import 'dart:io';

import 'package:casual_app/common/widgets/custom_appbar.dart';
import 'package:casual_app/common/widgets/custom_button.dart';
import 'package:casual_app/common/widgets/loader.dart';
import 'package:casual_app/constants/global_variables.dart';
import 'package:casual_app/constants/utils.dart';
import 'package:casual_app/features/account/bloc/account_bloc.dart';
import 'package:casual_app/features/city/bloc/city_bloc.dart';
import 'package:casual_app/models/casual/casual_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  CityBLoc? cityBLoc;
  AccountBloc? accountBloc;

  final _editProfileForm = GlobalKey<FormState>();

  CasualModel casualModel = CasualModel();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  File? _avatar;
  List<File> images = [];
  List fileData = [];

  int? cityValue;
  String? oldImgUrl;
  
  @override
  void initState() {
    context.read<CityBLoc>().add(GetAllCities());
    getProfileData();
    super.initState();
  }

  getProfileData(){
    if(context.read<AccountBloc>().state.runtimeType == GetProfileState){
      var state = context.read<AccountBloc>().state as GetProfileState;
      firstNameController.text = state.casualModel.casual_first_name!;
      lastNameController.text = state.casualModel.casual_last_name!;
      phoneNoController.text = state.casualModel.casual_phone_no!;
      cityValue = state.casualModel.cityId;
      oldImgUrl = state.casualModel.casual_avatar!;
      print(oldImgUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    accountBloc = BlocProvider.of<AccountBloc>(context);
    return Scaffold(
      appBar: customAppbar(context: context, title: "Edit Profile", homeVisible: true),
      body: BlocListener<AccountBloc, AccountState>(
        bloc: accountBloc,
        listener: (context, state) {
          if(state is ProfileUpdateSuccessState){
            showFlushBar(context, state.msg, Colors.green);
            Timer(const Duration(seconds: 4),() => Navigator.pop(context),);
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _editProfileForm,
              child: Column(
                children: [
                  firstNameInput(),
                  const Gap(14),
                  lastNameInput(),
                  const Gap(14),
                  phoneNoInput(),
                  const Gap(14),
                  cityInput(),
                  const Gap(14),
                  _avatar != null ?
                  ClipOval(
                    child: Image.file(_avatar!, width: 100, height: 100, fit: BoxFit.cover,),
                  ) : const Center(),
                  _avatar == null ? CircleAvatar(
                    radius: 50,
                    backgroundImage: oldImgUrl == null
                        ? Image.asset("assets/images/person.png").image
                        : NetworkImage(
                      GlobalVariables.s3Bucket +
                          oldImgUrl!,
                      // scale: 1,
                    ),
                  ) : const Center(),
                  const Gap(14),
                  _buildPicBtn(),
                  const Gap(14),
                  updateProfileBtn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPicBtn(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor : Colors.white,
        foregroundColor: Colors.black,

        elevation: 3
        // minimumSize: Size.fromHeight(46),
        // textStyle: TextStyle(fontSize: 15)
      ),
      onPressed: () {
        openBottomSheet(context);
      },
      child: const Row(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.camera_alt_outlined, size: 28,),
          Gap(16),
          Text("Profile")
        ],
      ),
    );
  }

  void openBottomSheet(BuildContext context){
    showModalBottomSheet(context: context,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(
          top: Radius.circular(25)
      )),
      builder: (context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(onPressed: () {
                  Navigator.pop(context);
              }, icon: const Icon(Icons.close)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      pickImage(ImageSource.camera, "casual_avatar");
                    },
                    child: const Row(
                      children: [Icon(Icons.camera, size: 28,), Text("Camera")],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      pickImage(ImageSource.gallery, "casual_avatar");
                    },
                    child: const Row(
                      children: [Icon(Icons.photo_album_outlined, size: 28,), Text("Gallery")],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },);
  }

  Future pickImage(ImageSource imageSource, String fileName) async {
    print(imageSource);
    final img = await ImagePicker().pickImage(source: imageSource);
    if(img == null) return;
    final imgTemporary = File(img.path);
    setState(() {
      _avatar = imgTemporary;
    });
  }

  Widget firstNameInput(){
    return BlocBuilder<AccountBloc, AccountState>(
      bloc: accountBloc,
      builder: (context, state) {
        ProfileUpdateState? successState;
        if(state is ProfileUpdateState){
          successState = state;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: firstNameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "First Name",
                  contentPadding: EdgeInsets.all(10)
              ),
            ),
            const Gap(10),
            successState?.errors['casual_first_name'] != null ?
            Text(successState?.errors['casual_first_name'], style: const TextStyle(color: Colors.red),) : const Gap(1),
          ],
        );
      },
    );
  }

  Widget lastNameInput(){
    return BlocBuilder<AccountBloc, AccountState>(
      bloc: accountBloc,
      builder: (context, state) {
        ProfileUpdateState? successState;
        if(state is ProfileUpdateState){
          successState = state;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: lastNameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Last Name",
                  contentPadding: EdgeInsets.all(10)
              ),
            ),
            const Gap(10),
            successState?.errors['casual_last_name'] != null ?
            Text(successState?.errors['casual_last_name'], style: const TextStyle(color: Colors.red),) : const Gap(1),
          ],
        );
      },
    );
  }

  Widget phoneNoInput(){
    return BlocBuilder<AccountBloc, AccountState>(
      bloc: accountBloc,
      builder: (context, state) {
        ProfileUpdateState? successState;
        if(state is ProfileUpdateState){
          successState = state;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: phoneNoController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Phone Number",
                  contentPadding: EdgeInsets.all(10)
              ),
            ),
            const Gap(10),
            successState?.errors['casual_phone_no'] != null ?
            Text(successState?.errors['casual_phone_no'], style: const TextStyle(color: Colors.red),) : const Gap(1),
          ],
        );
      },
    );
  }

  Widget cityInput(){
    return
      BlocBuilder(
      bloc: cityBLoc,
      builder: (context, state) {
        AllCitiesState? successState;
        // print(state.runtimeType);
        if(state is CityLoadingState){
          return const CircularProgressIndicator();
        }
        if(state is AllCitiesState){
          successState = state;
          return DropdownButtonFormField(
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder()
            ),
            value: cityValue,
            isExpanded: true,
            hint: const Text("Select City"),
            icon: const Icon(Icons.keyboard_arrow_down),
            items: successState.cities.map((city){
              return DropdownMenuItem(
                value: city.id,
                child: Text(city.city_name!),
              );
            }).toList(),
            onChanged: (value) {
              print(value);
              setState(() {
                cityValue = value;
              });
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget updateProfileBtn(){
    return BlocBuilder<AccountBloc, AccountState>(
      bloc: accountBloc,
      builder: (context, state) {
        return state is LoadingState ? const Loader() : CustomButton(text: "Update", onTap: () {
          casualModel.casual_first_name = firstNameController.text;
          casualModel.casual_last_name = lastNameController.text;
          casualModel.casual_phone_no = phoneNoController.text;
          casualModel.cityId = cityValue;
          // casualModel.date_of_birth = getDOBFormat;
          // Navigator.pop(context);
          accountBloc!.add(UpdateProfileEvent(casualModel: casualModel, _avatar));
        },);
      },
    );
  }

}
