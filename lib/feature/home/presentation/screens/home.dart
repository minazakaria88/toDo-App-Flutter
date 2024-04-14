import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/utils/app_strings.dart';
import 'package:todo/core/utils/navigation.dart';
import 'package:todo/feature/home/presentation/manager/cubit.dart';
import 'package:todo/feature/home/presentation/manager/state.dart';
import 'package:todo/feature/home/presentation/screens/details_screen.dart';
import '../../../../core/utils/custom_bottom_sheet.dart';
import '../widget/category_tasks.dart';
import '../widget/float_button.dart';
import '../widget/my_day_and_important.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<AppCubit>(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: const Text(
              AppStrings.appTitle,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          floatingActionButton: FloatButton(
            onPressed: () {
              if (cubit.isOpen) {
                if (fromKey.currentState!.validate() &&
                    cubit.category != '') {
                  cubit.insertIntoDataBase(
                    title: cubit.title.text,
                    date: cubit.date.text,
                    time: cubit.time.text,
                    category: cubit.category,
                  );
                  Navigator.pop(context);
                  cubit.time.clear();
                  cubit.date.clear();
                  cubit.title.clear();
                  cubit.category='';
                  cubit.changeBottomSheet();
                }
              } else {
                showCustomBottomSheet(cubit, scaffoldKey, fromKey);
                cubit.changeBottomSheet();
              }
            },
            iconData: cubit.isOpen ? Icons.add : Icons.edit,
          ),
          body: Column(
            children: [
              MyDayAndImportant(cubit: cubit),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: List.generate(
                      cubit.categoryModel.length,
                      (index) => CategoryTasks(
                        function: () {
                          goTO(
                            context: context,
                            screen: Details(
                              color: cubit.categoryModel[index].color,
                              title: cubit.categoryModel[index].title,
                            ),
                          );
                          cubit.chooseCategory=cubit.categoryModel[index].data;
                        },
                        categoryModel: cubit.categoryModel[index],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}
