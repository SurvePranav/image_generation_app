part of 'prompt_bloc.dart';

sealed class PromptEvent extends Equatable {
  const PromptEvent();

  @override
  List<Object> get props => [];
}

class PromptGenerateClicked extends PromptEvent {
  final String prompt;
  const PromptGenerateClicked({required this.prompt});
}

class ImageClickedEvent extends PromptEvent {
  final Uint8List imageList;
  const ImageClickedEvent({required this.imageList});
}

class DownloadClickedEvent extends PromptEvent {}
