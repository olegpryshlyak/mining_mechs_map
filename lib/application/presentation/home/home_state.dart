part of 'home_cubit.dart';

class HomeState extends Equatable {
  final SaveFileEntity? saveFile;
  final String? currentCoordinates;

  const HomeState({
    this.saveFile,
    this.currentCoordinates,
  });
  @override
  List<Object?> get props => [saveFile, currentCoordinates];

  HomeState copyWith({
    final SaveFileEntity? saveFile,
    final String? currentCoordinates,
  }) =>
      HomeState(
        saveFile: saveFile ?? this.saveFile,
        currentCoordinates: currentCoordinates ?? this.currentCoordinates,
      );
}
