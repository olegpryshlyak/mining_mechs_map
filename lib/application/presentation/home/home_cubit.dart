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
    final json = jsonDecode(value);
    final saveFile = SaveFileEntity.fromJson(json);
    emit(state.copyWith(saveFile: saveFile));
  }
}
