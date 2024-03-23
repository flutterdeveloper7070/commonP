import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:predator_pest/app/common_imports/common_imports.dart';

class UploadMediaViewModel {
  UploadMediaPageState state;
  LoginResponse? loginResponse;
  String formId = '';
  List<File> selectImage = [];
  bool isMediaSelected = false;
  final picker = ImagePicker();
  ApiStatus apiStatus = ApiStatus.initial;
  TextEditingController descriptionController = TextEditingController();
  PageController photoViewPageController = PageController();
  ScrollController scrollController = ScrollController();

  UploadMediaViewModel(this.state) {
    formId = Get.arguments['formId'];
    getUserData();
  }

  ///====================== Functions ==============================

  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<void> submitButtonAction() async {
    if (selectImage.isNotEmpty) {
      List<MultipartFile> imageList = [];
      for (int i = 0; i < selectImage.length; i++) {
        imageList.add(await MultipartFile.fromPath('issueImages', selectImage[i].path));
      }

      if (imageList.length == selectImage.length) {
        apiStatus = ApiStatus.loading;
        state.uploadMediaController.update();
        String response = await state.uploadMediaController.uploadMedia(
            formId: formId,
            body: {
              'description': descriptionController.text.trim().isNotEmpty ? descriptionController.text.toString() : '',
            },
            fileList: imageList);

        if (response.isNotEmpty) {
          Map<String, dynamic> responseMap = jsonDecode(response);
          if (responseMap.containsKey('success') && responseMap['success'] == true) {
            apiStatus = ApiStatus.success;
            String successMessage = responseMap['message'] ?? '';
            if(successMessage.isNotEmpty){
              successToast(successMessage);
            }
            goToSuccess();
          }
        } else {
          apiStatus = ApiStatus.failed;
          // errorToast('This functionality is not available now.');
        }
      }
    } else {
      errorToast(AppStringConstants.pleaseSelectImage.tr);
    }
    state.uploadMediaController.update();
  }

  Future<void> getUserData() async {
    String userDetails = await getPrefStringValue(AppSharedPreference.loginResponse) ?? '';
    if (userDetails.isNotEmpty) {
      loginResponse = LoginResponse.fromJson(jsonDecode(userDetails));
    }
    state.uploadMediaController.update();
  }

  Future<void> cameraButtonAction() async {
    bool permissionStatus = await getPermissionStatus(Get.context!, PermissionType.camera);
    if (permissionStatus) {
      getImageFromCamera();
      isMediaSelected = false;
      state.uploadMediaController.update();
    }
  }

  Future<void> galleryButtonAction() async {
    bool permissionStatus = await getPermissionStatus(Get.context!, PermissionType.storage);
    if (permissionStatus) {
      getImageFromGallery();
      isMediaSelected = false;
      state.uploadMediaController.update();
    }
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickMultiImage();
    int userOnlySelectImageCount = selectImage.length <= 6 ? 6 - selectImage.length : 0;

    for (int i = 0; i < userOnlySelectImageCount; i++) {
      if (pickedFile.length > i) {
        selectImage.add(File(pickedFile[i].path));
      }
    }

    if (pickedFile.length > userOnlySelectImageCount) {
      warningToast(AppStringConstants.youAreAbleToUploadOnlyImages.tr, AppColorConstants.goldenrod);
    }
    state.uploadMediaController.update();
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      selectImage.add(File(pickedFile.path));
    }
    state.uploadMediaController.update();
  }

  void imageAction(int index) {
    showDialog(
      context: Get.context!,
      barrierColor: AppColorConstants.appTransparent,
      builder: (context) {
        photoViewPageController = PageController(initialPage: index);
        return viewImage(index);
      },
    );
  }

  void uploadedMediaButtonAction() {
    isMediaSelected = !isMediaSelected;
    if (isMediaSelected) {
      scrollDown();
    }
    state.uploadMediaController.update();
  }

  ///====================== Views ==================================

  Widget noMediaFoundView() {
    return Expanded(
      child: ListView(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).copyWith(top: Get.height * 0.13),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          const AppImageAsset(image: AppAssetsConstants.uploadMedia),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: AppText(
              text: AppStringConstants.noMediaFound.tr,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              fontFamily: AppAssetsConstants.nunito,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: AppText(
              text: AppStringConstants.uploadImagesFromMediaLibrary.tr,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: AppAssetsConstants.nunito,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          uploadedMediaButtonView(),
          const SizedBox(
            height: 33,
          ),
          isMediaSelected ? mediaSelectDialogView() : const SizedBox()
        ],
      ),
    );
  }

  Widget uploadedMediaButtonView() {
    return AppButton(
      onTap: uploadedMediaButtonAction,
      text: AppStringConstants.uploadFile.tr,
      height: 46,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: AppAssetsConstants.nunito,
      borderRadius: BorderRadius.circular(40),
    );
  }

  Widget mediaSelectedView() {
    return Expanded(
        child: ListView(
      shrinkWrap: true,
      controller: scrollController,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      children: [
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          primary: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 3 / 3.3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: List.generate(selectImage.length, (index) {
            return Stack(
              children: [
                InkWell(
                  onTap: () => imageAction(index),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColorConstants.appTransparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color.fromRGBO(234, 236, 240, 1)),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(9),
                        child: Image.file(
                          selectImage[index],
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7, right: 7),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        selectImage.removeAt(index);
                        state.uploadMediaController.update();
                      },
                      child: Container(
                        width: 20.5,
                        height: 20.5,
                        decoration: BoxDecoration(
                          color: AppColorConstants.appWhite,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColorConstants.appBlack, width: 1),
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          size: 15,
                          color: AppColorConstants.appBlack,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
        ),
        SizedBox(
          height: selectImage.length >= 6 ? 0 : 20,
        ),
        selectImage.length >= 6 ? const SizedBox() : uploadedMediaButtonView(),
        SizedBox(
          height: isMediaSelected ? 33 : 0,
        ),
        isMediaSelected ? mediaSelectDialogView() : const SizedBox(),
        const SizedBox(
          height: 12,
        ),
        AppText(
          text: AppStringConstants.description.tr,
          fontFamily: AppAssetsConstants.nunito,
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 8),
          child: AppTextFormField(
            textFieldHeight: 130,
            maxLines: 5,
            controller: descriptionController,
            hint: AppStringConstants.writeHere.tr,
            hintStyle: const TextStyle(fontFamily: AppAssetsConstants.nunito, fontWeight: FontWeight.w600),
            borderColor: AppColorConstants.appTransparent,
            fillColor: AppColorConstants.lightGray,
          ),
        ),
        AppButton(
          onTap: submitButtonAction,
          text: AppStringConstants.submit.tr,
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          fontFamily: AppAssetsConstants.nunito,
          borderRadius: BorderRadius.circular(40),
          color: AppColorConstants.appPrimary,
        )
      ],
    ));
  }

  Widget mediaSelectDialogView() {
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20).copyWith(bottom: 30),
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: TooltipShapeBorder(arrowArc: 0.3, radius: 25, arrowHeight: 12, arrowWidth: 45),
          shadows: [BoxShadow(color: Colors.black26, blurRadius: 1, offset: Offset(0.6, 0.6))],
        ),
        child: Row(
          children: [
            Expanded(child: InkWell(onTap: cameraButtonAction, child: selectCameraView())),
            const SizedBox(
              width: 10,
            ),
            Expanded(child: InkWell(onTap: galleryButtonAction, child: selectGalleryView())),
          ],
        ),
      ),
    );
  }

  Widget selectCameraView() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10).copyWith(bottom: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromRGBO(234, 236, 240, 1),
        ),
      ),
      child: Column(
        children: [
          const AppImageAsset(
            image: AppAssetsConstants.cameraIcon,
            height: 27,
          ),
          const SizedBox(
            height: 13,
          ),
          AppText(
            text: AppStringConstants.clickWithCamera.tr,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            fontFamily: AppAssetsConstants.nunito,
          ),
        ],
      ),
    );
  }

  Widget selectGalleryView() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10).copyWith(bottom: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromRGBO(234, 236, 240, 1),
        ),
      ),
      child: Column(
        children: [
          const AppImageAsset(
            image: AppAssetsConstants.galleryIcon,
            height: 25,
          ),
          const SizedBox(
            height: 13,
          ),
          AppText(
            text: AppStringConstants.uploadFile.tr,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            fontFamily: AppAssetsConstants.nunito,
          ),
        ],
      ),
    );
  }

  Widget viewImage(int index) {
    return StatefulBuilder(
      builder: (context, setState) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColorConstants.literGray,
                    ),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: PhotoViewGallery.builder(
                                itemCount: selectImage.length,
                                builder: buildItem,
                                backgroundDecoration: const BoxDecoration(color: AppColorConstants.literGray),
                                pageController: photoViewPageController,
                                // onPageChanged: onPageChanged,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () => goToBack(),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: AppColorConstants.appWhite,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColorConstants.appBlack, width: 1),
                                ),
                                child: const Icon(
                                  Icons.close_rounded,
                                  size: 20,
                                  color: AppColorConstants.appBlack,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  PhotoViewGalleryPageOptions buildItem(BuildContext context, int index1) {
    return PhotoViewGalleryPageOptions(
      imageProvider: Image.file(selectImage[index1], fit: BoxFit.fill).image,
      minScale: PhotoViewComputedScale.contained * 0.8,
    );
  }
}
