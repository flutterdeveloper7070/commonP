import 'dart:ui';

import 'package:predator_pest/app/common_imports/common_imports.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      color: AppColorConstants.appTransparent,
      child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), child: const CircularProgressIndicator()),
    );
  }
}
