import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/patient_form_field.dart';

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
            ElevatedButton(
              onPressed: () {
                print("Full Name: ${firstName.text} ${lastName.text}");
                print("Passport number: ${idNumber.text}");
                print("Birth date: ${birthDate.text}");
                print("Gender: $selectedGender");
                print("Country: $selectedCountry");
                print("Result: $selectedResult");
                print("Result Date: ${resultDate.text}");
              },
              child: const Text('save'),
            ),
          ],
        ),
      ),
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
