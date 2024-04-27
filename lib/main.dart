import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mining_mechs_map/application/di/injection.dart';
import 'package:mining_mechs_map/application/presentation/home/home_cubit.dart';
import 'package:mining_mechs_map/application/presentation/home/home_page.dart';

Future<void> main() async {
  await configureDependencies();
  runApp(const MiningMechsMapApp());
}

class MiningMechsMapApp extends StatelessWidget {
  const MiningMechsMapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mining Mechs Map',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<HomeCubit>(create: (final _) => getIt<HomeCubit>(), child: const HomePage()),
    );
  }
}
