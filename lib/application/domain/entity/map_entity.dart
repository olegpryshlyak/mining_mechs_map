import 'dart:convert';

import 'package:equatable/equatable.dart';

class MapEntity extends Equatable {
  final double mapWidth;
  final double mapHeight;
  final List<List<double>> mapInfo;

  const MapEntity({required this.mapWidth, required this.mapHeight, required this.mapInfo});

  factory MapEntity.fromJson(final Map<String, dynamic> json) {
    print('yoba ${jsonDecode(json['map_array'])[0].runtimeType}');
    return MapEntity(
        mapWidth: json['map_array_w'],
        mapHeight: json['map_array_h'],
        mapInfo: jsonDecode(json['map_array'])
            .map((dynamic sublist) {
              if (sublist is List) {
                return sublist
                    .map<double>((item) {
                      // Attempt to convert each item to a double
                      if (item is int) {
                        return item.toDouble();
                      } else if (item is String) {
                        return double.tryParse(item) ?? 0;
                      } else if (item is double) {
                        return item;
                      } else {
                        return 0;
                      }
                    })
                    .toList()
                    .cast<double>();
              } else {
                return [];
              }
            })
            .toList()
            .cast<List<double>>());
  }

  @override
  List<Object?> get props => [mapWidth, mapHeight, mapInfo];
}
