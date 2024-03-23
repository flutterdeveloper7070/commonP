import 'package:predator_pest/app/common_imports/common_imports.dart';

abstract class UploadMediaRepository {
  Future uploadMedia({required String formId, required Map<String, String> body, required List<MultipartFile> fileList});
}
