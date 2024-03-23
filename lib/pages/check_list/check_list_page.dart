import 'package:predator_pest/app/common_imports/common_imports.dart';

class CheckListPage extends StatefulWidget {
  const CheckListPage({super.key});

  @override
  State<CheckListPage> createState() => CheckListPageState();
}

class CheckListPageState extends State<CheckListPage> {
  CheckListViewModel? checkListViewModel;
  late CheckListController checkListController;

  @override
  Widget build(BuildContext context) {
    checkListViewModel ?? (checkListViewModel = CheckListViewModel(this));
    return GetBuilder(
      init: CheckListController(),
      builder: (controller) {
        checkListController = controller;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: AppColorConstants.appTransparent),
          child: Scaffold(
            backgroundColor: AppColorConstants.literGray,
            appBar: AppAppbar(
              userName: checkListViewModel?.loginResponse?.firstName ?? '',
              userImageUrl: checkListViewModel?.loginResponse?.profileImage ?? '',
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Divider(),
                    ),
                    checkListViewModel!.checkListView(),
                  ],
                ),
                if (checkListViewModel?.apiStatus == ApiStatus.loading) const AppLoader()
              ],
            ),
          ),
        );
      },
    );
  }
}
