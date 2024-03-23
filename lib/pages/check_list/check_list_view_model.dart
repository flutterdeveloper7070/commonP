import 'dart:async';
import 'dart:convert';

import 'package:predator_pest/app/common_imports/common_imports.dart';

class CheckListViewModel {
  CheckListPageState state;
  ScrollController? scrollController;
  ApiStatus apiStatus = ApiStatus.initial;
  int selectedTile = -1;
  LoginResponse? loginResponse;
  List<CheckListModel> checkListData = [
    CheckListModel(
      title: AppStringConstants.account.tr,
      isCheck: false,
      tileColor: AppColorConstants.appPrimary,
    ),
    CheckListModel(
      title: AppStringConstants.pestProblems.tr,
      isCheck: false,
      tileColor: AppColorConstants.charcoalGray,
    ),
    CheckListModel(
      title: AppStringConstants.sanitationIssues.tr,
      isCheck: false,
    ),
    CheckListModel(
      title: AppStringConstants.structuralIssues.tr,
      isCheck: false,
      tileColor: AppColorConstants.charcoalGray,
    ),
    CheckListModel(
      title: AppStringConstants.recommendCorrectiveMeasures.tr,
      isCheck: false,
      tileColor: AppColorConstants.charcoalGray,
    ),
    CheckListModel(
      title: AppStringConstants.inspectionMonitorResults.tr,
      isCheck: false,
    ),
    CheckListModel(
      title: AppStringConstants.selectLocations.tr,
      isCheck: false,
    ),
  ];

  CheckListViewModel(this.state) {
    scrollController = ScrollController();
    scrollController?.addListener(() {
      if (ChipsInputState.suggestionsBoxController!.isOpened) {
        ChipsInputState.suggestionsBoxController?.close();
      }
    });
    Future.delayed(
      const Duration(milliseconds: 150),
      () async {
        await ConnectivityService.instance.isCheckConnectivity();
        await getCheckListDetail();
      },
    );
  }

  ///====================== Functions ==============================

  Future<void> getUserData() async {
    String userDetails = await getPrefStringValue(AppSharedPreference.loginResponse) ?? '';
    if (userDetails.isNotEmpty) {
      loginResponse = LoginResponse.fromJson(jsonDecode(userDetails));
    }
  }

  Future<void> getCheckListDetail() async {
    try {
      apiStatus = ApiStatus.loading;
      state.checkListController.update();
      getUserData();
      await state.checkListController.getCheckListDetail();
      if (state.checkListController.getDetailsModel != null) {
        apiStatus = ApiStatus.success;
        if (state.checkListController.getDetailsModel?.details != null) {
          for (var element in checkListData) {
            if (element.title == AppStringConstants.account.tr) {
              element.getDetailsList = state.checkListController.getDetailsModel?.details?.account;
            } else if (element.title == AppStringConstants.pestProblems.tr) {
              element.getDetailsList = state.checkListController.getDetailsModel?.details?.problem;
            } else if (element.title == AppStringConstants.sanitationIssues.tr) {
              element.getDetailsList = state.checkListController.getDetailsModel?.details?.sanitation;
            } else if (element.title == AppStringConstants.structuralIssues.tr) {
              element.getDetailsList = state.checkListController.getDetailsModel?.details?.structural;
            } else if (element.title == AppStringConstants.recommendCorrectiveMeasures.tr) {
              element.getDetailsList = state.checkListController.getDetailsModel?.details?.measure;
            } else if (element.title == AppStringConstants.inspectionMonitorResults.tr) {
              element.getDetailsList = state.checkListController.getDetailsModel?.details?.inspection;
            } else if (element.title == AppStringConstants.selectLocations.tr) {
              element.getDetailsList = state.checkListController.getDetailsModel?.details?.location;
            }
          }
        }
      } else {
        apiStatus = ApiStatus.failed;
      }
      state.checkListController.update();
    } on Exception catch (e) {
      // TODO
      logs("Exception ${e.toString()}");
    }
  }

  Future<void> submitCheckListDetail({required Map<String, String> body}) async {
    apiStatus = ApiStatus.loading;
    state.checkListController.update();
    String response = await state.checkListController.submitCheckListDetail(body: body);
    if (response.isNotEmpty) {
      Map<String, dynamic> responseMap = jsonDecode(response);
      if (responseMap.containsKey('success') && responseMap['success'] == true) {
        apiStatus = ApiStatus.success;
        String msg = responseMap['message'] ?? '';
        if (msg.isNotEmpty) {
          successToast(msg);
        }
        goToUploadMedia(formId: responseMap['data']['_id']);
      }
    } else {
      apiStatus = ApiStatus.failed;
    }
    apiStatus = ApiStatus.success;
    state.checkListController.update();
  }

  CheckListModel? checkListDataShorting({required String isTitle}) {
    CheckListModel? checkListModel;
    for (var element in checkListData) {
      if (element.title == isTitle) {
        checkListModel = element;
        break;
      }
    }
    return checkListModel;
  }

  void nextButtonOnTap() async {
    CheckListModel? account = checkListDataShorting(isTitle: AppStringConstants.account.tr);
    CheckListModel? problem = checkListDataShorting(isTitle: AppStringConstants.pestProblems.tr);
    CheckListModel? sanitation = checkListDataShorting(isTitle: AppStringConstants.sanitationIssues.tr);
    CheckListModel? structural = checkListDataShorting(isTitle: AppStringConstants.structuralIssues.tr);
    CheckListModel? measure = checkListDataShorting(isTitle: AppStringConstants.recommendCorrectiveMeasures.tr);
    CheckListModel? inspection = checkListDataShorting(isTitle: AppStringConstants.inspectionMonitorResults.tr);
    CheckListModel? location = checkListDataShorting(isTitle: AppStringConstants.selectLocations.tr);

    if (account != null && account.inputList == null || account!.inputList!.isEmpty) {
      errorToast(AppStringConstants.accountFieldShouldNotBeEmpty.tr);
    } else if (account.inputList!.isNotEmpty) {
      await submitCheckListDetail(body: {
        'user': loginResponse?.id ?? '',
        'account_name': account.inputList?.join(',') ?? '',
        'account_remark':
            account.descriptionController.text.trim().isNotEmpty ? account.descriptionController.text.toString() : '',
        'inspection_monitor_name': inspection?.inputList?.join(',') ?? '',
        'inspection_monitor_remark': inspection!.descriptionController.text.trim().isNotEmpty
            ? inspection.descriptionController.text.toString()
            : '',
        'reco_correc_meas_name': measure?.inputList?.join(',') ?? '',
        'reco_correc_meas_remark':
            measure!.descriptionController.text.trim().isNotEmpty ? measure.descriptionController.text.toString() : '',
        'pestProblem_name': problem?.inputList?.join(',') ?? '',
        'pestProblem_remark':
            problem!.descriptionController.text.trim().isNotEmpty ? problem.descriptionController.text.toString() : '',
        'sanitationIssue_name': sanitation?.inputList?.join(',') ?? '',
        'sanitationIssue_remark': sanitation!.descriptionController.text.trim().isNotEmpty
            ? sanitation.descriptionController.text.toString()
            : '',
        'structuralIssue_name': structural?.inputList?.join(',') ?? '',
        'structuralIssue_remark': structural!.descriptionController.text.trim().isNotEmpty
            ? structural.descriptionController.text.toString()
            : '',
        'location_name': location?.inputList?.join(',') ?? '',
        'location_remark': location!.descriptionController.text.trim().isNotEmpty
            ? location.descriptionController.text.toString()
            : '',
      });

      /// Old api body parameters
      // await submitCheckListDetail(body: {
      //   'action': RestConstants.instance.uploadInfo,
      //   'accountId': account.inputList.toString(),
      //   'accountRemark': account.descriptionController.text.toString(),
      //   'inspectionId': inspection!.inputList!.isNotEmpty ? inspection.inputList.toString() : '',
      //   'inspectionRemark': inspection.descriptionController.text.toString(),
      //   'locationId': location!.inputList!.isNotEmpty ? location.inputList.toString() : '',
      //   'locationRemark': location.descriptionController.text.toString(),
      //   'measureId': measure!.inputList!.isNotEmpty ? location.inputList.toString() : '',
      //   'measureRemark': measure.descriptionController.text.toString(),
      //   'problemId': problem!.inputList!.isNotEmpty ? problem.inputList.toString() : '',
      //   'problemRemark': problem.descriptionController.text.toString(),
      //   'sanitationId': sanitation!.inputList!.isNotEmpty ? problem.inputList.toString() : '',
      //   'sanitationRemark': sanitation.descriptionController.text.toString(),
      //   'structuralId': structural!.inputList!.isNotEmpty ? problem.inputList.toString() : '',
      //   'structuralRemark': structural.descriptionController.text.toString(),
      //   'userId': loginResponse?.id ?? '',
      // });
    }
  }

  void onExpansionChangedAction(value, int index) {
    if (value) {
      selectedTile = index;
      state.checkListController.update();
    } else {
      selectedTile = -1;
      state.checkListController.update();
    }
  }

  ///====================== Views ==================================

  Widget checkListView() {
    return Expanded(
        child: ListView(
      shrinkWrap: true,
      controller: scrollController,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: AppText(
            text: AppStringConstants.checkListTitle.tr,
            fontWeight: FontWeight.w700,
            fontSize: 14.5,
            fontFamily: AppAssetsConstants.nunito,
          ),
        ),
        checkListDataView(),
        const SizedBox(height: 45),
        nextButtonView()
      ],
    ));
  }

  Widget checkListDataView() {
    return ListView.separated(
        shrinkWrap: true,
        key: Key('builder ${selectedTile.toString()}'),
        padding: const EdgeInsets.symmetric(vertical: 16),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          CheckListModel checkListModel = checkListData[index];
          return AppExpansionTile(
            key: Key(index.toString()),
            initiallyExpanded: index == selectedTile,
            onExpansionChanged: (value) => onExpansionChangedAction(value, index),
            leading: checkListModel.isCheck! ? AppAssetsConstants.checkBoxTick : AppAssetsConstants.checkBox,
            title: checkListModel.title,
            fontColor: checkListModel.tileColor,
            fontWeight: index == 0 ? FontWeight.w700 : FontWeight.w600,
            leadingOnTap: () {
              checkListModel.isCheck = !checkListModel.isCheck!;
              state.checkListController.update();
            },
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColorConstants.appBlack,
              size: 17,
            ),
            customChildren: expansionTileCustomChildrenView(checkListModel: checkListModel),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 8,
          );
        },
        itemCount: checkListData.length);
  }

  List<Widget> expansionTileCustomChildrenView({required CheckListModel checkListModel}) {
    return [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10).copyWith(bottom: 13),
        color: AppColorConstants.appWhite,
        child: Column(
          children: [
            problemSelectTextFieldView(checkListModel: checkListModel),
            // (checkListModel.isCheck != null && checkListModel.isCheck!)
            //     ? problemDescriptionTextFieldView(checkListModel: checkListModel)
            //     : const SizedBox(),
            submitButtonView(checkListModel: checkListModel)
          ],
        ),
      )
    ];
  }

  Widget problemSelectTextFieldView({required CheckListModel checkListModel}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        constraints: const BoxConstraints(minHeight: 109),
        decoration: BoxDecoration(color: AppColorConstants.veryLightGray, borderRadius: BorderRadius.circular(10)),
        child: ChipsInput(
          key: checkListModel.chipKey,
          autofocus: false,
          initialValue: checkListModel.inputList ?? [],
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            constraints: const BoxConstraints(minHeight: 109),
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            fillColor: AppColorConstants.appTransparent,
            hintText: "Type hear",
            hintStyle:
                const TextStyle(fontFamily: AppAssetsConstants.nunito, fontWeight: FontWeight.w600, fontSize: 12.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: AppColorConstants.appTransparent),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: AppColorConstants.appTransparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: AppColorConstants.appTransparent),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: AppColorConstants.appRed),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: AppColorConstants.appTransparent),
            ),
          ),
          findSuggestions: (String query) {
            if (query.isNotEmpty) {
              var lowercaseQuery = query.toLowerCase();
              return checkListModel.getDetailsList!.where((getDetailsAccount) {
                return getDetailsAccount.name!.toLowerCase().contains(query.toLowerCase()) ||
                    getDetailsAccount.name!.toLowerCase().contains(query.toLowerCase());
              }).toList(growable: false)
                ..sort((a, b) => a.name!
                    .toLowerCase()
                    .indexOf(lowercaseQuery)
                    .compareTo(b.name!.toLowerCase().indexOf(lowercaseQuery)));
            } else {
              return [];
            }
          },
          onChanged: (data) {
            checkListModel.inputList = data;
          },
          chipBuilder: (context, state, profile) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
              decoration: BoxDecoration(
                  color: AppColorConstants.goldenrod.withOpacity(0.4), borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: AppText(
                      text: '$profile',
                      fontSize: 9,
                      fontFamily: AppAssetsConstants.nunito,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                      fontColor: AppColorConstants.appPrimary,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  InkWell(
                      onTap: () => state.deleteChip(profile),
                      child: const Icon(Icons.close, color: AppColorConstants.appBlack, size: 16)),
                ],
              ),
            );
          },
          suggestionBuilder: (context, state, getDetailsAccount) {
            return InkWell(
              overlayColor: const MaterialStatePropertyAll(AppColorConstants.appTransparent),
              onTap: () => state.selectSuggestion(getDetailsAccount.name!),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: getDetailsAccount.name!,
                      fontSize: 11.5,
                      fontColor: AppColorConstants.appBlack,
                      fontFamily: AppAssetsConstants.nunito,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Divider(
                      color: AppColorConstants.appBlack.withOpacity(0.5),
                      thickness: 0.5,
                      height: 2,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget problemDescriptionTextFieldView({required CheckListModel checkListModel}) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 12.5),
      child: AppTextFormField(
        controller: checkListModel.descriptionController,
        textFieldHeight: 109,
        maxLines: 5,
        hint: AppStringConstants.typeHere.tr,
        hintStyle: const TextStyle(fontFamily: AppAssetsConstants.nunito, fontWeight: FontWeight.w600),
        borderColor: AppColorConstants.appTransparent,
        fillColor: AppColorConstants.veryLightGray,
      ),
    );
  }

  Widget submitButtonView({required CheckListModel checkListModel}) {
    return AppButton(
      onTap: () {
        if (checkListModel.inputList != null && checkListModel.inputList!.isNotEmpty) {
          selectedTile = -1;
          checkListModel.isCheck = true;
        }
        state.checkListController.update();
      },
      text: AppStringConstants.submit.tr,
      fontSize: 12.5,
      fontWeight: FontWeight.w700,
      fontFamily: AppAssetsConstants.nunito,
      textColor: AppColorConstants.appBlack,
      borderRadius: BorderRadius.circular(40),
      color: AppColorConstants.goldenrod,
    );
  }

  Widget nextButtonView() {
    return AppButton(
      onTap: nextButtonOnTap,
      text: AppStringConstants.next.tr,
      height: 46,
      fontWeight: FontWeight.w600,
      fontFamily: AppAssetsConstants.nunito,
      borderRadius: BorderRadius.circular(40),
    );
  }
}
