import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../widgets/big_button.dart';
import '../widgets/patient_form_field.dart';
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

  DateTime today = DateTime.now();

  List<String> genderList = ['Male', 'Female'];
  String? selectedGender;

  List<String> resultList = ['Negative', 'Positive'];
  String? selectedResult;

  List<String> countryList = ['Ethiopia', 'Kenya', 'Sudan', 'Dubai', 'Others'];
  String? selectedCountry;

  bool flag = true;

  bool saveLoad = false;

  @override
  void initState() {
    birthDate.text = '${today.day} / ${today.month} / ${today.year}';
    resultDate.text = '${today.day} / ${today.month} / ${today.year}';

    super.initState();
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
                    activeBorderColor: const Color(0x55628ec5),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: PatientFormField(
                    editingController: lastName,
                    text: 'last name',
                    hintText: 'enter last name',
                    activeBorderColor: const Color(0x55628ec5),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            PatientFormField(
              editingController: idNumber,
              text: 'identification code',
              hintText: 'passport or kebele id',
              activeBorderColor: const Color(0x55628ec5),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: PatientFormField(
                    editingController: birthDate,
                    text: 'Date of birth',
                    readOnly: true,
                    activeBorderColor: const Color(0x55628ec5),
                    suffixIcon: IconButton(
                      onPressed: () => changeDate(field: 'birth'),
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
                    suffixIcon: dropDownMenu(
                      hint: 'Gender',
                      menuList: genderList,
                      selectedItem: selectedGender,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            PatientFormField(
              text: 'Nationality',
              suffixIcon: dropDownMenu(
                hint: 'Country',
                menuList: countryList,
                selectedItem: selectedCountry,
              ),
            ),
            const SizedBox(height: 15),
            // result field
            PatientFormField(
              text: 'Result',
              suffixIcon: dropDownMenu(
                hint: 'Result',
                menuList: resultList,
                selectedItem: selectedResult,
              ),
            ),
            const SizedBox(height: 15),
            PatientFormField(
              editingController: resultDate,
              text: 'Result taken date',
              activeBorderColor: const Color(0x55628ec5),
              readOnly: true,
              suffixIcon: IconButton(
                onPressed: () => changeDate(field: 'result'),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  size: 26,
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 150,
              child: Row(
                children: [
                  Container(
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
                                  onPressed: () async {
                                    setState(() {
                                      saveLoad = true;
                                    });
                                    await Future.delayed(const Duration(seconds: 1));
                                    setState(() {
                                      flag = false;
                                      saveLoad = false;
                                    });
                                  },
                                  text: qrGenerateButton(),
                                  buttonColor: Colors.orange,
                                )
                              : saveAndShareButtons(),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'make sure you shared it before saving it to the server.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 5),
                        BigButton(
                          onPressed: () {},
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

  qrGenerateButton() {
    return saveLoad
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
          );
  }

  Row saveAndShareButtons() {
    return Row(
      key: const Key('2'),
      children: [
        Expanded(
          child: SmallButton(
            onPressed: () {
              setState(() {
                flag = true;
              });
            },
            iconData: Icons.save,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SmallButton(
            onPressed: () {
              setState(() {
                flag = true;
              });
            },
            iconData: Icons.share,
          ),
        ),
      ],
    );
  }

  DropdownButtonHideUnderline dropDownMenu({
    required String hint,
    required List<String> menuList,
    String? selectedItem,
  }) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        value: selectedItem,
        hint: Text(
          hint,
          style: TextStyle(
            color: Colors.grey.shade700,
            letterSpacing: 1,
          ),
        ),
        items: menuList.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                color: Colors.grey.shade700,
                letterSpacing: 1,
              ),
            ),
          );
        }).toList(),
        style: TextStyle(
          color: Colors.grey.shade700,
          letterSpacing: 1,
        ),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        onChanged: (value) => setState(() {
          if (hint.toLowerCase() == 'gender') selectedGender = value.toString();
          if (hint.toLowerCase() == 'result') selectedResult = value.toString();
          if (hint.toLowerCase() == 'country') selectedCountry = value.toString();
        }),
        buttonHeight: 42,
        buttonWidth: double.maxFinite,
        buttonPadding: const EdgeInsets.only(left: 20, right: 10),
        itemHeight: 40,
      ),
    );
  }

  changeDate({required String field}) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != today) {
      setState(() {
        if (field == 'birth') {
          birthDate.text = "${selected.day} / ${selected.month} / ${selected.year}";
        }
        if (field == 'result') {
          resultDate.text = "${selected.day} / ${selected.month} / ${selected.year}";
        }
      });
    }
  }
}
