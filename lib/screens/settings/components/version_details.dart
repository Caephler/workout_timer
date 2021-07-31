import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:workout_timer/common/storage/shared_prefs.dart';
import 'package:workout_timer/common/text.dart';

class VersionDetails extends StatelessWidget {
  const VersionDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PackageInfo.fromPlatform(),
      builder: (context, AsyncSnapshot<PackageInfo> snapshot) {
        String version = snapshot.data?.version ?? '';
        String buildNumber = snapshot.data?.buildNumber ?? '';
        return Column(
          children: [
            Text(
              'Version $version build $buildNumber',
              style: AppTextStyles.body.getStyleFor(6, color: Colors.black38),
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     bool value = await SharedPreferencesService.instance
            //         .getHasBoughtAdRemoval();
            //     return SharedPreferencesService.instance
            //         .setHasBoughtAdRemoval(!value);
            //   },
            //   child: Text('Toggle Ad (Dev)'),
            // ),
          ],
        );
      },
    );
  }
}
