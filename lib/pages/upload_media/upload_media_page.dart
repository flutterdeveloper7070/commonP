import 'package:predator_pest/app/common_imports/common_imports.dart';

class UploadMediaPage extends StatefulWidget {
  const UploadMediaPage({super.key});

  @override
  State<UploadMediaPage> createState() => UploadMediaPageState();
}

class UploadMediaPageState extends State<UploadMediaPage> {
  UploadMediaViewModel? uploadMediaViewModel;
  late UploadMediaController uploadMediaController;

  @override
  Widget build(BuildContext context) {
    uploadMediaViewModel ?? (uploadMediaViewModel = UploadMediaViewModel(this));
    return GetBuilder(
      init: UploadMediaController(),
      builder: (controller) {
        uploadMediaController = controller;
        return GestureDetector(
          onTap: () {
            if (uploadMediaViewModel!.isMediaSelected) {
              uploadMediaViewModel!.isMediaSelected = false;
              controller.update();
            }
          },
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: AppColorConstants.appTransparent),
            child: Scaffold(
              backgroundColor: AppColorConstants.literGray,
              appBar: AppAppbar(
                userName: uploadMediaViewModel?.loginResponse?.firstName ?? '',
                userImageUrl: uploadMediaViewModel?.loginResponse?.profileImage ?? '',
              ),
              body: Stack(
                children: [
                  Column(
                    children: [
                      const Divider(),
                      uploadMediaViewModel?.selectImage != null && uploadMediaViewModel!.selectImage.isNotEmpty
                          ? uploadMediaViewModel!.mediaSelectedView()
                          : uploadMediaViewModel?.noMediaFoundView() ?? const SizedBox(),
                    ],
                  ),
                  if (uploadMediaViewModel?.apiStatus == ApiStatus.loading) const AppLoader()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
