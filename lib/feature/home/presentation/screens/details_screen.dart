import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/utils/app_strings.dart';
import 'package:todo/feature/home/presentation/manager/cubit.dart';
import 'package:todo/feature/home/presentation/manager/state.dart';

import '../widget/details_list_view_item.dart';

class Details extends StatelessWidget {
  const Details({super.key, required this.title, required this.color});
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<AppCubit>(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            centerTitle: true,
          ),
          body: cubit.chooseCategory.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (context, index) => DetailsListViewItem(
                        onTap: () {
                          String x=cubit.chooseCategory[index][DataBaseTablesNames.important];
                          if(x=='0')
                            {
                              x='1';
                            }
                          else
                            {
                              x='0';
                            }
                          cubit.upDateDataBase(
                            id: cubit.chooseCategory[index]['id'],
                            important: x,
                          );
                        },
                        color: color,
                        title: title,
                        index:index,
                        data: cubit.chooseCategory[index],
                      ),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: cubit.chooseCategory.length)
              : Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.hourglass_empty_outlined,
                        color: Colors.black,
                        size: 40,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'No Items',
                        style: TextStyle(
                          color: color,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
