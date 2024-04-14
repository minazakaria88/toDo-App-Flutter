import 'package:flutter/material.dart';
import 'package:todo/core/utils/navigation.dart';
import 'package:todo/feature/home/presentation/screens/details_screen.dart';

import '../manager/cubit.dart';
import 'list_view_item.dart';

class MyDayAndImportant extends StatelessWidget {
  const MyDayAndImportant({
    super.key,
    required this.cubit,
  });

  final AppCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        child: SizedBox(
          height: 155,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              itemBuilder: (context, index) =>ListViewItem(
                onTap: (){
                   goTO(context: context, screen:  Details(title: index==1? 'important': 'my Day', color: Colors.deepOrange));
                   if(index==1)
                     {
                       cubit.chooseCategory=cubit.important;
                     }
                   else
                     {
                       cubit.chooseCategory=cubit.myDay;
                     }
                },
                listViewModel: cubit.listViewModel[index],
              ),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.blue,
                ),
              ),
              itemCount: 2,
            ),
          ),
        ),
      ),
    );
  }
}