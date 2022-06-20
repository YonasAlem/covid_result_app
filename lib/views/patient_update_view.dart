import 'package:covid_result_app/methods/my_app_bar.dart';
import 'package:covid_result_app/methods/update_patient_data.dart';
import 'package:covid_result_app/services/db_services/database_services.dart';
import 'package:covid_result_app/views/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:screenshot/screenshot.dart';

import '../enums/hero_tags.dart';
import '../enums/loading_type.dart';
import '../methods/change_date.dart';
import '../methods/display_snackbar.dart';
import '../methods/register_patient_data.dart';
import '../methods/save_image_to_gallery.dart';
import '../methods/share_image_to_others.dart';
import '../methods/warning_dialog.dart';
import '../models/patient_model.dart';
import '../widgets/big_button.dart';
import '../widgets/drop_down_menu.dart';
import '../widgets/patient_form_field.dart';
import '../widgets/small_button.dart';
import 'full_screen_qr_view.dart';

class PatientUpdateView extends StatefulWidget {
  static const String routeName = '/updatePatient/';
  const PatientUpdateView({Key? key}) : super(key: key);

  @override
  State<PatientUpdateView> createState() => _PatientUpdateViewState();
}

class _PatientUpdateViewState extends State<PatientUpdateView> {
  late final TextEditingController firstName;
  late final TextEditingController lastName;
  late final TextEditingController idNumber;
  late final TextEditingController birthDate;
  late final TextEditingController resultDate;

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
  bool isFullScreenModeOn = false;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments as PatientModel;

    setActiveBorderColor();

    final fullNameList = args.fullName.split(' ');
    if (fullNameList.length == 1) {
      firstName = TextEditingController(text: args.fullName.split(' ')[0]);
      lastName = TextEditingController(text: '');
    } else {
      firstName = TextEditingController(text: args.fullName.split(' ')[0]);
      lastName = TextEditingController(text: args.fullName.split(' ')[1]);
    }

    idNumber = TextEditingController(text: args.passportNumber);
    birthDate = TextEditingController(text: args.dateOfBirth);
    selectedCountry = args.nationality;
    selectedGender = args.gender;
    selectedResult = args.result;
    resultDate = TextEditingController(text: args.resultTakenDate.split("T")[0]);

    super.didChangeDependencies();
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

  void setActiveBorderColor() {
    activeBorderColor = const Color(0x55b774bd);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: "Update patient",
        backgroundColor: const Color(0xffb774bd),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              readOnly: true,
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
                  InkWell(
                    onTap: () async {
                      await Navigator.of(context).pushNamed(
                        FullScreenQRView.routeName,
                        arguments: [
                          qrDataHolder,
                          PatientModel(
                            fullName: '${firstName.text.trim()} ${lastName.text.trim()}',
                            passportNumber: idNumber.text.trim(),
                            dateOfBirth: birthDate.text,
                            gender: selectedGender!,
                            nationality: selectedCountry!,
                            result: selectedResult!,
                            resultTakenDate: "${today.day}-${today.month}-${today.year}",
                          ),
                        ],
                      );
                    },
                    child: Hero(
                      tag: 'qr',
                      child: Column(
                        children: [
                          PrettyQr(
                            size: 150,
                            data: qrDataHolder,
                            roundEdges: true,
                            errorCorrectLevel: QrErrorCorrectLevel.M,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      children: [
                        saveAndShareButtons(),
                        const Spacer(),
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
                            onPressed: () async {
                              if (firstName.text.isEmpty || lastName.text.isEmpty) {
                                displaySnackBar(
                                  context: context,
                                  text: "First or last name can not be empty!",
                                );
                              } else {
                                await updatePatientData(
                                  context,
                                  patientModel: PatientModel(
                                    fullName:
                                        '${firstName.text.trim()} ${lastName.text.trim()}',
                                    passportNumber: idNumber.text.trim(),
                                    dateOfBirth: birthDate.text,
                                    gender: selectedGender!,
                                    nationality: selectedCountry!,
                                    result: selectedResult!,
                                    resultTakenDate:
                                        "${today.day}-${today.month}-${today.year}",
                                  ),
                                );

                                if (mounted) {
                                  Navigator.of(context).pushReplacementNamed(
                                    HomeView.routeName,
                                  );
                                }
                              }
                            },
                            buttonColor: const Color(0xffb774bd),
                            text: const Text(
                              'Update',
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
    );
  }

  Row saveAndShareButtons() {
    return Row(
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
                    fullName: '${firstName.text.trim()} ${lastName.text.trim()}',
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
                  fullName: '${firstName.text.trim()} ${lastName.text.trim()}',
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

  changeLoadingState(Enum? loadingButton) => setState(() => loadingType = loadingButton);
}
