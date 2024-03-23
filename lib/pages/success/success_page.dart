import 'package:predator_pest/app/common_imports/common_imports.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => SuccessPageState();
}

class SuccessPageState extends State<SuccessPage> {
  SuccessViewModel? successViewModel;
  late SuccessController successController;

  @override
  Widget build(BuildContext context) {
    successViewModel ?? (successViewModel = SuccessViewModel(this));
    return GetBuilder(
      init: SuccessController(),
      builder: (controller) {
        successController = controller;
        return WillPopScope(
          onWillPop: () async {
            goToCheckList();
            return false;
          },
          child: Scaffold(
            appBar: AppAppbar(
              title: AppStringConstants.success.tr,
              backOnTap: () => goToCheckList(),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: successViewModel?.successBodyView(),
            ),
          ),
        );
      },
    );
  }
}
