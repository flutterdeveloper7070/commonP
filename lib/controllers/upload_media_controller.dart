import 'package:predator_pest/app/common_imports/common_imports.dart';

class UploadMediaController extends GetxController {
  UploadMediaRepository uploadMediaRepository = getIt<UploadMediaRepository>();

  Future<String> uploadMedia({required String formId,required Map<String, String> body, required List<MultipartFile> fileList}) async {
    String? response = await uploadMediaRepository.uploadMedia(formId: formId,body: body, fileList: fileList);
    return response ?? "";
  }
}
