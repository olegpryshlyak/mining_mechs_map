import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mining_mechs_map/application/core/extensions/context_x.dart';
import 'package:mining_mechs_map/application/domain/entity/map_entity.dart';
import 'package:mining_mechs_map/application/presentation/home/home_cubit.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _readSaveFile(final BuildContext context) async {
    const XTypeGroup typeGroup = XTypeGroup(
      label: 'Save file',
      extensions: <String>['sav'],
    );
    final XFile? file = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
    final saveString = await file?.readAsString();
    if (saveString != null && context.mounted) {
      context.read<HomeCubit>().loadSaveFile(saveString);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Container(
            height: 50,
            color: context.theme.primaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  ElevatedButton(onPressed: () => _readSaveFile(context), child: const Text('Load save')),
                  const Spacer(),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) => state.currentCoordinates == null
                        ? const SizedBox.shrink()
                        : Text(
                            'Current coordinates: ${state.currentCoordinates}',
                            style: context.theme.textTheme.headlineSmall!
                                .copyWith(color: context.theme.colorScheme.onPrimary),
                          ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) => previous.saveFile != current.saveFile,
              builder: (context, state) => state.saveFile == null
                  ? const Text('no data')
                  : MapWidget(
                      map: state.saveFile!.map,
                    ),
            ),
          )
        ],
      ),
    );
  }
}

class MapWidget extends StatelessWidget {
  final MapEntity map;

  const MapWidget({super.key, required this.map});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 50,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: map.mapWidth.toInt(),
        ),
        itemBuilder: (final context, final index) {
          int gridStateLength = map.mapWidth.toInt();
          int x, y = 0;
          y = (index / gridStateLength).floor();
          x = (index % gridStateLength);
          return TileWidget(
            value: map.mapInfo[x][y],
            x: x,
            y: y,
          );
        },
        itemCount: (map.mapWidth * map.mapHeight).toInt(),
      ),
    );
  }
}

class TileWidget extends StatelessWidget {
  final double value;
  final int x;
  final int y;

  const TileWidget({super.key, required this.value, required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => context.read<HomeCubit>().setHoveringCoordinates(x, y, valueToName(value)),
      child: Container(
        height: 2,
        width: 2,
        color: valueToColor(value),
        child: Center(
          child: Text(
            value.toString(),
            style: context.theme.textTheme.labelSmall,
          ),
        ),
      ),
    );
  }
}

Color valueToColor(final double value) =>
    {
      0.0: Colors.black12, // empty
      1.0: Colors.brown, // earth
      6.0: Colors.grey, // concrete
      34.0: Colors.yellow, // pipe
      35.0: Colors.yellow, // pipe
      36.0: Colors.yellow, // pipe
      37.0: Colors.yellow, // pipe
      38.0: Colors.deepPurpleAccent, // mine
    }[value] ??
    Colors.red;

String valueToName(final double value) =>
    {
      0.0: 'Empty',
      1.0: 'Earth',
      6.0: 'Concrete',
      34.0: 'Pipe',
      35.0: 'Pipe',
      36.0: 'Pipe',
      37.0: 'Pipe',
      38.0: 'Mine',
    }[value] ??
    'Not mapped';
