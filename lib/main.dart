import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/config/routes.dart';
import 'package:todo/feature/home/presentation/manager/cubit.dart';

void main() {
  runApp(const TODo());
}
class TODo extends StatelessWidget {
  const TODo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDataBase(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute:AppRoute.onGenerateRoute,
      ),
    );
  }
}

