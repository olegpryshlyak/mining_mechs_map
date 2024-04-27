part of 'home_cubit.dart';

class HomeState extends Equatable {
  final SaveFileEntity? saveFile;

  const HomeState({
    this.saveFile,
  });
  @override
  List<Object?> get props => [saveFile];

  HomeState copyWith({final SaveFileEntity? saveFile}) => HomeState(saveFile: saveFile ?? this.saveFile);
}
