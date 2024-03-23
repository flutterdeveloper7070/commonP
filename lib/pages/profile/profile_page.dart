import 'package:predator_pest/app/common_imports/common_imports.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  ProfileViewModel? profileViewModel;
  late ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    profileViewModel ?? (profileViewModel = ProfileViewModel(this));
    return GetBuilder(
      init: ProfileController(),
      builder: (controller) {
        profileController = controller;
        return Scaffold(
          appBar: AppAppbar(title: AppStringConstants.profile.tr, backOnTap: () => goToBack()),
          body: Column(
            children: [
              const Divider(),
              profileViewModel!.profileView(),
            ],
          ),
        );
      },
    );
  }
}
