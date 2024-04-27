import 'package:equatable/equatable.dart';
import 'package:mining_mechs_map/application/domain/entity/map_entity.dart';

class SaveFileEntity extends Equatable {
  final MapEntity map;

  factory SaveFileEntity.fromJson(final Map<String, dynamic> json) =>
      SaveFileEntity(map: MapEntity.fromJson(json['map']));

  const SaveFileEntity({required this.map});

  @override
  List<Object?> get props => [map];
}
