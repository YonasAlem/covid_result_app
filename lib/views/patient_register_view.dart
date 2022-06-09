import 'dart:io';
import 'package:covid_result_app/enums/hero_tags.dart';
import 'package:covid_result_app/enums/loading_type.dart';
import 'package:covid_result_app/methods/display_snackbar.dart';
import 'package:covid_result_app/methods/display_toast.dart';
import 'package:covid_result_app/methods/my_app_bar.dart';
import 'package:covid_result_app/methods/share_image_to_others.dart';
import 'package:covid_result_app/methods/warning_dialog.dart';
import 'package:covid_result_app/services/db_services/database_services.dart';

import 'package:covid_result_app/widgets/qr_image_container_empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:screenshot/screenshot.dart';

import '../enums/operation_status.dart';
import '../methods/change_date.dart';
import '../methods/save_image_to_gallery.dart';
import '../models/patient_model.dart';
import '../utils/colors.dart';
import '../widgets/drop_down_menu.dart';
import '../widgets/big_button.dart';
import '../widgets/patient_form_field.dart';
import '../widgets/qr_image_container.dart';
import '../widgets/small_button.dart';

class PatientRegisterView extends StatefulWidget {
  static const String routeName = '/registerpatient/';

  const PatientRegisterView({Key? key}) : super(key: key);

  @override
  State<PatientRegisterView> createState() => _PatientRegisterViewState();
}

class _PatientRegisterViewState extends State<PatientRegisterView> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController idNumber = TextEditingController();
  final TextEditingController birthDate = TextEditingController();
  final TextEditingController resultDate = TextEditingController();

  final ScreenshotController screenshotController = ScreenshotController();

  DateTime today = DateTime.now();
  DateTime? resultTakenDate;

  List<String> genderList = ['Male', 'Female'];
  String? selectedGender;
  List<String> resultList = ['Negative', 'Positive'];
  String? selectedResult;
  List<String> countryList = ['Ethiopia', 'Kenya', 'Sudan', 'Dubai', 'Others'];
  String? selectedCountry;

  bool flag = true;
  String qrDataHolder = '';
  Color? activeBorderColor;
  bool easyLoading = false;
  Enum? loadingType;

  @override
  void initState() {
    birthDate.text = '${today.day} / ${today.month} / ${today.year}';
    resultDate.text = '${today.day} / ${today.month} / ${today.year}';

    idNumber.addListener(() => setState(() {
          flag = true;
          qrDataHolder = '';
        }));

    super.initState();
  }

  void setActiveBorderColor() {
    activeBorderColor = const Color(0x55628ec5);
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    idNumber.dispose();
    birthDate.dispose();
    resultDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setActiveBorderColor();
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 93,
            decoration: BoxDecoration(
              gradient: gradient1,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBar(
            backgroundColor: const Color(0xFF628ec5),
            title: 'Patient form',
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: PatientFormField(
                        editingController: firstName,
                        text: 'first name',
                        hintText: 'enter first name',
                        activeBorderColor: activeBorderColor!,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PatientFormField(
                        editingController: lastName,
                        text: 'last name',
                        hintText: 'enter last name',
                        activeBorderColor: activeBorderColor!,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                PatientFormField(
                  editingController: idNumber,
                  text: 'identification code',
                  hintText: 'passport or kebele id',
                  activeBorderColor: activeBorderColor!,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: PatientFormField(
                        editingController: birthDate,
                        text: 'Date of birth',
                        readOnly: true,
                        activeBorderColor: activeBorderColor!,
                        suffixIcon: IconButton(
                          onPressed: () async {
                            var date = await changeDate(context: context);
                            setState(() {
                              if (date != null) birthDate.text = date;
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: PatientFormField(
                        text: 'Gender',
                        suffixIcon: DropDownMenu(
                          hint: 'Gender',
                          menuList: genderList,
                          selectedItem: selectedGender,
                          onChanged: (value) => setState(
                            () => selectedGender = value.toString(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                PatientFormField(
                  text: 'Nationality',
                  suffixIcon: DropDownMenu(
                    hint: 'Country',
                    menuList: countryList,
                    selectedItem: selectedCountry,
                    onChanged: (value) => setState(
                      () => selectedCountry = value.toString(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // result field
                PatientFormField(
                  text: 'Result',
                  suffixIcon: DropDownMenu(
                    hint: 'Result',
                    menuList: resultList,
                    selectedItem: selectedResult,
                    onChanged: (value) => setState(
                      () => selectedResult = value.toString(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                PatientFormField(
                  editingController: resultDate,
                  text: 'Result taken date',
                  activeBorderColor: const Color(0x55628ec5),
                  readOnly: true,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 150,
                  child: Row(
                    children: [
                      qrDataHolder.isEmpty
                          ? const QrImageContainerEmpty()
                          : QrImageContainerFull(
                              qrDataHolder: qrDataHolder,
                              firstName: firstName.text,
                              lastName: lastName.text,
                            ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              child: flag ? qrGenerateButton() : saveAndShareButtons(),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              'Make sure you shared it before saving it to the server.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Hero(
                              tag: HeroTags.bigButton,
                              child: BigButton(
                                onPressed: registerPatientData,
                                buttonColor: const Color(0xFF628ec5),
                                text: const Text(
                                  'Save',
                                  style: TextStyle(fontSize: 16, letterSpacing: 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  BigButton qrGenerateButton() {
    return BigButton(
      onPressed: _qrGenerateButtonAction,
      text: loadingType == LoadingType.qrGenerateButton
          ? const QrGenerateButtonLoading()
          : const Text(
              'Generate QR',
              style: TextStyle(fontSize: 16, letterSpacing: 1),
            ),
      buttonColor: Colors.orange,
    );
  }

  Row saveAndShareButtons() {
    return Row(
      key: const Key('2'),
      children: [
        Expanded(
          child: Hero(
            tag: HeroTags.saveFileButton,
            child: SmallButton(
              onPressed: () async {
                var shouldSave = await warningDialog(
                  context: context,
                  boxTitle: "Saving image",
                  boxDescription: "This will save the qr image to the gallery",
                  cancleText: "Don't",
                  okText: "Save",
                );
                if (shouldSave) {
                  changeLoadingState(LoadingType.saveFileButton);
                  await saveImageToGallery(
                    qrDataHolder: qrDataHolder,
                    firstName: firstName.text,
                    lastName: lastName.text,
                  );
                  displaySnackBar(
                    context: context,
                    text: 'Qr Image saved to gallery!',
                    backgroundColor: Colors.green[300],
                    iconData: Icons.check,
                  );
                }
                changeLoadingState(null);
              },
              icon: loadingType == LoadingType.saveFileButton
                  ? const SpinKitCircle(color: Colors.white, size: 30)
                  : const Icon(Icons.save),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Hero(
            tag: HeroTags.shareFileButton,
            child: SmallButton(
              onPressed: () async {
                changeLoadingState(LoadingType.shareFileButton);
                await shareImageToOthers(
                  qrDataHolder: qrDataHolder,
                  firstName: firstName.text,
                  lastName: lastName.text,
                );
                changeLoadingState(null);
              },
              icon: loadingType == LoadingType.shareFileButton
                  ? const SpinKitCircle(color: Colors.white, size: 30)
                  : const Icon(Icons.share),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _qrGenerateButtonAction() async {
    if (firstName.text.isEmpty || lastName.text.isEmpty) {
      displaySnackBar(context: context, text: "First or last name can not be empty!");
    } else if (idNumber.text.isEmpty ||
        int.tryParse(idNumber.text) is! int ||
        idNumber.text.length < 4) {
      if (idNumber.text.isEmpty) {
        displaySnackBar(context: context, text: "Id number can't be empty.");
      } else if (idNumber.text.length < 4) {
        displaySnackBar(context: context, text: "Use 4 characters or more for your ID.");
      } else {
        displaySnackBar(context: context, text: "Use only numbers for your ID");
      }
    } else if (selectedGender == null) {
      displaySnackBar(context: context, text: 'Specify the gender please!');
    } else if (selectedCountry == null) {
      displaySnackBar(context: context, text: 'Specify the country please!');
    } else if (selectedResult == null) {
      displaySnackBar(context: context, text: 'Specify the result please!');
    } else {
      setState(() => loadingType = LoadingType.qrGenerateButton);
      await Future.delayed(const Duration(milliseconds: 800));
      setState(() {
        flag = false;
        loadingType = null;
        qrDataHolder =
            'https://covid-result-tester.herokuapp.com/test-result-using-qr-code/${idNumber.text}';
      });
    }
  }

  Future<void> registerPatientData() async {
    EasyLoadingStyle.custom;
    if (qrDataHolder.isEmpty) {
      displaySnackBar(context: context, text: "QR Image is required!");
    } else {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          await EasyLoading.show(status: 'Saving patient data');
          PatientModel patientModel = PatientModel(
            fullName: '${firstName.text.trim()} ${lastName.text.trim()}',
            passportNumber: idNumber.text.trim(),
            dateOfBirth: birthDate.text,
            gender: selectedGender!,
            nationality: selectedCountry!,
            result: selectedResult!,
            resultTakenDate: "${today.day}-${today.month}-${today.year}",
          );

          var result = await DatabaseServices.mongoDb().singlePatientData(
            idNumber: idNumber.text,
          );

          if (result == OperationStatus.failed) {
            OperationStatus newResult = await DatabaseServices.mongoDb().registerPatient(
              patientModel: patientModel,
            );
            if (newResult == OperationStatus.succeed) {
              await EasyLoading.showSuccess('Data saved successfully.');
              resetDataEntry();
            } else {
              await EasyLoading.showError('There is a problem, please try again!');
            }
          } else {
            var from = DateTime.parse(result.resultTakenDate);
            var to = today;

            final dateDifference = (to.difference(from).inHours / 24).round();
            if (patientModel.fullName != result.fullName ||
                patientModel.gender != result.gender ||
                patientModel.nationality != result.nationality) {
              await EasyLoading.showError(
                'This ID belongs to another patient, Please use another one, OR make sure you put the data correctly!',
                duration: const Duration(seconds: 2),
              );
            } else if (dateDifference < 14) {
              await EasyLoading.showError(
                'This patient already taken the test, Should be more than 14 days to take a test again.',
                duration: const Duration(seconds: 2),
              );
            } else {
              OperationStatus newResult = await DatabaseServices.mongoDb().registerPatient(
                patientModel: patientModel,
              );
              if (newResult == OperationStatus.succeed) {
                await EasyLoading.showSuccess('Data saved successfully.');
                resetDataEntry();
              } else {
                await EasyLoading.showError('There is a problem, please try again!');
              }
            }
          }
        }
      } on SocketException catch (_) {
        displaySnackBar(
          context: context,
          text: 'No internet connection found!',
          backgroundColor: Colors.red[300],
        );
      }
    }
  }

  changeLoadingState(Enum? loadingButton) => setState(() => loadingType = loadingButton);

  void resetDataEntry() {
    firstName.text = '';
    lastName.text = '';
    idNumber.text = '';
    birthDate.text = '${today.day} / ${today.month} / ${today.year}';
    selectedGender = null;
    selectedResult = null;
    selectedCountry = null;
    resultDate.text = '${today.day} / ${today.month} / ${today.year}';
    qrDataHolder = '';
    flag = true;
  }
}

class QrGenerateButtonLoading extends StatelessWidget {
  const QrGenerateButtonLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SpinKitCircle(
          color: Colors.white,
          size: 30,
        ),
        SizedBox(width: 10),
        Text(
          'Generating',
          style: TextStyle(letterSpacing: 1, fontSize: 14),
        ),
      ],
    );
  }
}
