part of 'prompt_bloc.dart';

sealed class PromptState extends Equatable {
  const PromptState();

  @override
  List<Object> get props => [];
}

final class PromptInitial extends PromptState {}

class PromptGeneratImageLoadingState extends PromptState {}

class PromptGeneratImageSuccessState extends PromptState {
  final Uint8List file;
  const PromptGeneratImageSuccessState({required this.file});
}

class PromptGeneratImageErrorState extends PromptState {}
