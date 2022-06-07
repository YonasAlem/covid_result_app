import 'dart:io';

import 'package:covid_result_app/methods/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../db/database_manager.dart';
import '../methods/change_date.dart';
import '../models/patient_model.dart';
import '../widgets/drop_down_menu.dart';
import '../widgets/big_button.dart';
import '../widgets/patient_form_field.dart';
import '../widgets/small_button.dart';
import 'full_screen_qr_view.dart';

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

  DateTime today = DateTime.now();

  List<String> genderList = ['Male', 'Female'];
  String? selectedGender;
  List<String> resultList = ['Negative', 'Positive'];
  String? selectedResult;
  List<String> countryList = ['Ethiopia', 'Kenya', 'Sudan', 'Dubai', 'Others'];
  String? selectedCountry;

  bool flag = true;
  bool isGeneratingLoading = false;
  String qrDataHolder = '';

  Color? activeBorderColor;

  bool easyLoading = false;

  @override
  void initState() {
    birthDate.text = '${today.day} / ${today.month} / ${today.year}';
    resultDate.text = '${today.day} / ${today.month} / ${today.year}';

    idNumber.addListener(() => setState(() => qrDataHolder = ''));

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF628ec5),
        title: const Text(
          'Patient form',
          style: TextStyle(letterSpacing: 1),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
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
                          if (date != null) {
                            birthDate.text = date;
                          }
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
              suffixIcon: IconButton(
                onPressed: () => setState(() async {
                  resultDate.text = await changeDate(context: context);
                }),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  size: 26,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: Row(
                children: [
                  qrDataHolder.isNotEmpty
                      ? InkWell(
                          onTap: () => Navigator.of(context).pushNamed(
                            FullScreenQRView.routeName,
                            arguments: qrDataHolder,
                          ),
                          child: Hero(
                            tag: 'qr',
                            child: PrettyQr(
                              size: 150,
                              data: qrDataHolder,
                              roundEdges: true,
                              errorCorrectLevel: QrErrorCorrectLevel.M,
                            ),
                          ),
                        )
                      : Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.qr_code,
                                color: Colors.grey.withOpacity(0.5),
                                size: 50,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Generating...',
                                style: TextStyle(
                                  letterSpacing: 1,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: flag
                              ? BigButton(
                                  onPressed: _qrGenerateButtonAction,
                                  text: isGeneratingLoading
                                      ? Row(
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
                                        )
                                      : const Text(
                                          'Generate QR',
                                          style: TextStyle(fontSize: 16, letterSpacing: 1),
                                        ),
                                  buttonColor: Colors.orange,
                                )
                              : Row(
                                  key: const Key('2'),
                                  children: [
                                    Expanded(
                                      child: Hero(
                                        tag: 'b1',
                                        child: SmallButton(
                                          onPressed: () {
                                            setState(() {
                                              flag = true;
                                            });
                                          },
                                          iconData: Icons.save,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Hero(
                                        tag: 'b2',
                                        child: SmallButton(
                                          onPressed: () {
                                            setState(() {
                                              flag = true;
                                            });
                                          },
                                          iconData: Icons.share,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                        BigButton(
                          onPressed: registerPatientData,
                          buttonColor: const Color(0xFF628ec5),
                          text: const Text(
                            'Save',
                            style: TextStyle(fontSize: 16, letterSpacing: 1),
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
    );
  }

  Future<void> _qrGenerateButtonAction() async {
    if (firstName.text.isEmpty || lastName.text.isEmpty) {
      displayToast(message: "First or last name can't be empty.");
    } else if (idNumber.text.isEmpty ||
        int.tryParse(idNumber.text) is! int ||
        idNumber.text.length < 4) {
      if (idNumber.text.isEmpty) {
        displayToast(message: "Id number can't be empty.");
      } else if (idNumber.text.length < 4) {
        displayToast(message: "Id number can't hold less than 4 numbers.");
      } else {
        displayToast(message: "Id number can't hold Strings or doubles, Try using numbers");
      }
    } else if (selectedGender == null) {
      displayToast(message: 'Select a gender please');
    } else if (selectedCountry == null) {
      displayToast(message: 'Select a country please');
    } else if (selectedResult == null) {
      displayToast(message: 'Select a result please');
    } else {
      setState(() => isGeneratingLoading = true);
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        flag = false;
        isGeneratingLoading = false;
        qrDataHolder =
            'https://covid-result-tester.herokuapp.com/test-result-using-qr-code/${idNumber.text}';
      });
    }
  }

  Future<void> registerPatientData() async {
    EasyLoadingStyle.custom;
    if (qrDataHolder.isEmpty) {
      displayToast(message: 'Generate qr code first please');
    } else {
      final PatientModel patientData = PatientModel(
        fullName: '${firstName.text.trim()} ${lastName.text.trim()}',
        passportNumber: idNumber.text.trim(),
        dateOfBirth: birthDate.text,
        gender: selectedGender!,
        nationality: selectedCountry!,
        result: selectedResult!,
        resultTakenDate: resultDate.text,
      );

      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          await EasyLoading.show(status: 'Saving patient data');
          OperationStatus newResult = await DatabaseManager.addNewPatient(
            patient: patientData,
          );
          if (newResult == OperationStatus.succeed) {
            await EasyLoading.showSuccess('Data saved successfully.');
          } else {
            EasyLoading.showError('There is a problem, please try again!');
          }
        }
      } on SocketException catch (_) {
        displayToast(
          message: 'No internet connection found!',
          color: Colors.red[300],
        );
      }
    }
  }
}
