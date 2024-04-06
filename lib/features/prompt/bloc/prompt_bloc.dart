import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_generator/features/prompt/repos/prompt_repo.dart';

part 'prompt_event.dart';
part 'prompt_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  PromptBloc() : super(PromptInitial()) {
    on<PromptGenerateClicked>(promptGenerateClicked);
  }

  FutureOr<void> promptGenerateClicked(
      PromptGenerateClicked event, Emitter<PromptState> emit) async {
    emit(PromptGeneratImageLoadingState());
    try {
      Uint8List? file = await PromptRepo.generateImage(event.prompt);
      if (file != null) {
        emit(PromptGeneratImageSuccessState(file: Uint8List.fromList(file)));
      } else {
        emit(PromptGeneratImageErrorState());
      }
    } catch (e) {
      emit(PromptGeneratImageErrorState());
    }
  }
}
