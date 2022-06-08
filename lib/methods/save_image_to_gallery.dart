import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../widgets/qr_generated_image.dart';

Future<void> saveImageToGallery({
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
  // request a permission for the storage
  await [Permission.storage].request();
  // create a timestamp for image file name
  final timeStamp = DateTime.now().toIso8601String().replaceAll('.', '-').replaceAll(':', '-');
  final imageName = 'screenshot_$timeStamp';
  // save the file to the gallery
  await ImageGallerySaver.saveImage(image, name: imageName);
}
