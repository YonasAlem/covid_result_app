import 'package:flutter_easyloading/flutter_easyloading.dart';

enum LoadingType { success, error, onProgress, dismiss }

loadingWidget(LoadingType loadingType, {String? message}) async {
  if (loadingType == LoadingType.success) {
    await EasyLoading.showSuccess(message!);
  } else if (loadingType == LoadingType.error) {
    await EasyLoading.showError(message!);
  } else if (loadingType == LoadingType.onProgress) {
    await EasyLoading.show(status: message);
  } else if (loadingType == LoadingType.dismiss) {
    await EasyLoading.dismiss();
  }
}
