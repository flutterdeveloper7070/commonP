import 'package:predator_pest/app/common_imports/common_imports.dart';

class UploadMediaRepositoryImpl implements UploadMediaRepository {

  @override
  Future uploadMedia({required String formId, required Map<String, String> body, required List<MultipartFile> fileList}) async {
    final response = await RestServices.instance.multiPartRestCall(
      endpoint: '${RestConstants.instance.uploadImageEndPoint}$formId',
      body: body,
      filesList: fileList,
    );
    return response;
  }
}