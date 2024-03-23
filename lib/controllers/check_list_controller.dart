import 'package:predator_pest/app/common_imports/common_imports.dart';

class CheckListController extends GetxController {
  CheckListRepository checkListRepository = getIt<CheckListRepository>();
  GetDetailsModel? getDetailsModel;

  Future<void> getCheckListDetail() async {
    String? response = await checkListRepository.getCheckListDetail();

    if (response != null && response.isNotEmpty) {
      getDetailsModel = getDetailsModelFromJson(response);
    }
  }

  Future<String> submitCheckListDetail({required Map<String, String> body}) async {
    String? response = await checkListRepository.submitCheckListDetail(body: body);

    return response ?? "";
  }
}
