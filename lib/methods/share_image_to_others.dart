import 'dart:io';

import 'package:covid_result_app/widgets/qr_generated_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

Future<void> shareImageToOthers({
  void loadingOn,
  void loadingOff,
  required String qrDataHolder,
  required String firstName,
  required String lastName,
}) async {
  final ScreenshotController screenshotController = ScreenshotController();
  // turn on loading widget
  loadingOn;
  // capture widget as image
  final image = await screenshotController.captureFromWidget(
    QrGeneratedImage(
      qrDataHolder: qrDataHolder,
      firstName: firstName,
      lastName: lastName,
    ),
  );
  // turn off loading widget
  loadingOff;
  // get phone's system directory
  final dir = await getApplicationDocumentsDirectory();
  // create a file in system directory
  final imageDir = File("${dir.path}/flutter.png");
  // copy the captured widget to the file that have been created before
  imageDir.writeAsBytesSync(image);
  // share the file to other platforms
  await Share.shareFiles([imageDir.path]);
}
