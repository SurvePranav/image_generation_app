import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_generator/features/full_screen_image/ui/full_image_screen.dart';
import 'package:image_generator/features/prompt/bloc/prompt_bloc.dart';
import 'package:image_generator/features/prompt/repos/prompt_repo.dart';
import 'package:image_generator/features/prompt/ui/my_dropdown.dart';

class PromptScreen extends StatefulWidget {
  const PromptScreen({super.key});

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  final promptBloc = PromptBloc();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    log("building prompt screen");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Image'),
      ),
      body: Column(
        children: [
          BlocConsumer<PromptBloc, PromptState>(
            bloc: promptBloc,
            listener: (context, state) {},
            builder: (context, state) {
              switch (state.runtimeType) {
                case PromptInitial:
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      padding: const EdgeInsets.all(
                        20,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.cyan,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(
                            'assets/monalisa.png',
                          ),
                        ),
                      ),
                      width: double.maxFinite,
                      alignment: Alignment.bottomCenter,
                      child: const Text(
                        'Your Image will appear here',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                );
                case PromptGeneratImageLoadingState:
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.cyan,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: double.maxFinite,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.cyan,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Generating.....',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                case PromptGeneratImageSuccessState:
                  final successState = state as PromptGeneratImageSuccessState;
                  return Expanded(
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ImageFullScreen(
                                uint8list: successState.file,
                              ),
                            ));
                          },
                          child: Hero(
                            tag: 'hero_image',
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: MemoryImage(successState.file)),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.cyan,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              width: double.maxFinite,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 11,
                          right: 25,
                          child: FloatingActionButton(
                            onPressed: () async {
                              await PromptRepo.saveToGallery(successState.file)
                                  .then((success) {
                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Image Download Successfully!"),
                                      backgroundColor: Colors.cyan,
                                      behavior: SnackBarBehavior.floating,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Could Not Download Image!"),
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                    ),
                                  );
                                }
                              });
                            },
                            child: const Icon(Icons.download),
                          ),
                        ),
                      ],
                    ),
                  );
                case PromptGeneratImageErrorState:
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.cyan,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: double.maxFinite,
                      child: const Center(
                        child: Text(
                          'Something Went Wrong Try Again.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  );
                default:
                  return const SizedBox();
              }
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.30,
            width: double.maxFinite,
            margin: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      'Image Type',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 150,
                      child: MyDropdown(),
                    ),
                  ],
                ),
                const Text(
                  'Enter your Prompts',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: controller,
                  cursorColor: Colors.cyan,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.cyan),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 45,
                  child: BlocBuilder<PromptBloc, PromptState>(
                    bloc: promptBloc,
                    builder: (context, state) {
                      if (state is! PromptGeneratImageLoadingState) {
                        return ElevatedButton.icon(
                          onPressed: () {
                            if (controller.text.trim() != '') {
                              promptBloc.add(
                                PromptGenerateClicked(prompt: controller.text),
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.cyan,
                            ),
                            foregroundColor: MaterialStateProperty.all(
                              Colors.white,
                            ),
                          ),
                          icon: const Icon(Icons.generating_tokens),
                          label: const Text('Generate'),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
