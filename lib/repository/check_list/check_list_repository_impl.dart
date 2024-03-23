import 'package:predator_pest/app/common_imports/common_imports.dart';

class CheckListRepositoryImpl implements CheckListRepository {
  @override
  Future getCheckListDetail() async {
    final response = await RestServices.instance.getRestCall(
      endpoint: RestConstants.instance.getDetailsEndPoint,
    );
    return response;
  }

  @override
  Future submitCheckListDetail({required Map<String, String> body}) async {
    final response = await RestServices.instance.postRestCall(
      endpoint: RestConstants.instance.uploadInfoEndPoint,
      body: body,
    );
    return response;
  }
}
