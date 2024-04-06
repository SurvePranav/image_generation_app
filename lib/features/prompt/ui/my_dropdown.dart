import 'package:flutter/material.dart';
import 'package:image_generator/features/prompt/repos/prompt_repo.dart';

class MyDropdown extends StatefulWidget {
  const MyDropdown({super.key});

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  Map<String, String> optionsMap = {
    'Anime': '21',
    'Potrait': '26',
    'Realistic': '29',
    'Imagine V1': '27',
    'Imagine V3': '28',
    'Imagine V4': '30',
    'Imagine V4.1': '32',
    'Imagine V4.2': '31',
    'Imagine V5': '33',
    'Anime V5': '34',
    'SDXL 1.0': '122',
  };

  String selectedOption = '21';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: generateDropdownItems(),
      value: selectedOption,
      underline: const SizedBox(),
      onChanged: (String? newValue) {
        setState(() {
          selectedOption = newValue!;
          // changing the image type in prompt repo logic
          PromptRepo.styleId = selectedOption;
        });
      },
    );
  }

  List<DropdownMenuItem<String>> generateDropdownItems() {
    return optionsMap.keys.map((String key) {
      return DropdownMenuItem<String>(
        value: optionsMap[key],
        child: Text(key),
      );
    }).toList();
  }
}
