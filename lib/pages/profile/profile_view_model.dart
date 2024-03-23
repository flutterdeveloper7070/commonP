import 'dart:convert';

import 'package:predator_pest/app/common_imports/common_imports.dart';

class ProfileViewModel {
  ProfilePageState state;
  LoginResponse? loginResponse;

  ProfileViewModel(this.state) {
    getUserData();
  }

  Future<void> getUserData() async {
    String userDetails = await getPrefStringValue(AppSharedPreference.loginResponse) ?? '';
    if (userDetails.isNotEmpty) {
      loginResponse = LoginResponse.fromJson(jsonDecode(userDetails));
    }
    state.profileController.update();
  }

  Widget profileView() {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        children: [
          CircleAvatar(
            backgroundColor: AppColorConstants.appTransparent,
            radius: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AppImageAsset(
                image: loginResponse != null &&
                        loginResponse?.profileImage != null &&
                        !loginResponse!.profileImage!.contains('localhost:') &&
                        loginResponse!.profileImage!.isNotEmpty
                    ? loginResponse!.profileImage
                    : AppAssetsConstants.defaultUser,
                // image: AppAssetsConstants.defaultUser,
                fit: BoxFit.fill,
                height: double.infinity,
                width: double.infinity,
                color: AppColorConstants.mediumGray,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                  child: userFirstNameView(
                      title: AppStringConstants.firstName.tr, userName: loginResponse?.firstName ?? '')),
              const SizedBox(width: 10),
              Expanded(
                  child:
                      userFirstNameView(title: AppStringConstants.lastName.tr, userName: loginResponse?.lastName ?? ''))
            ],
          ),
          const SizedBox(height: 10),
          userFirstNameView(title: AppStringConstants.emailAddress.tr, userName: loginResponse?.email ?? ''),
          const SizedBox(height: 10),
          userFirstNameView(
              title: AppStringConstants.dateOfBirth.tr,
              userName: loginResponse?.birthDate != null ? parseDate(loginResponse!.birthDate!) : ''),
          const SizedBox(height: 10),
          userFirstNameView(title: AppStringConstants.phoneNumber.tr, userName: loginResponse?.mobile ?? ''),
          const SizedBox(height: 10),
          userFirstNameView(title: AppStringConstants.location.tr, userName: loginResponse?.location ?? ''),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget userFirstNameView({String title = '', String userName = ''}) {
    return AppTextFormField(
      controller: TextEditingController(text: userName),
      title: title,
      hintStyle: TextStyle(
        color: AppColorConstants.appPrimary,
        fontSize: 12,
        fontFamily: AppAssetsConstants.nunito,
      ),
      borderColor: AppColorConstants.lightGray,
      readOnly: true,
      fillColor: AppColorConstants.lightGray,
    );
  }
}
