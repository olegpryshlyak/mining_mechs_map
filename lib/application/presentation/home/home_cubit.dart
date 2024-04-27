import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mining_mechs_map/application/core/cubit/cubit_base.dart';
import 'package:mining_mechs_map/application/domain/entity/save_file_entity.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends CubitBase<HomeState> {
  HomeCubit() : super(const HomeState());

  void loadSaveFile(final String value) {
    final string = value.substring(0, value.lastIndexOf('}') + 1);
    final json = jsonDecode(string);
    final saveFile = SaveFileEntity.fromJson(json);
    emit(state.copyWith(saveFile: saveFile));
  }

  void setHoveringCoordinates(final int x, final int y, final String element) =>
      emit(state.copyWith(currentCoordinates: 'x: $x, y: ${y + 1}, element: $element'));
}
