import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/utils/app_strings.dart';
import 'package:todo/feature/home/presentation/manager/cubit.dart';
import 'package:todo/feature/home/presentation/manager/state.dart';

class DetailsListViewItem extends StatelessWidget {
    DetailsListViewItem({
    super.key,
    required this.color,
    required this.title, required this.data, required this.onTap, required this.index,
  });

  final Color color;
  final String title;
   final Map data;
    final int index;
   final Function onTap;
   final keyD=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
      builder: (context, state) {
        var cubit=BlocProvider.of<AppCubit>(context);
        return Dismissible(
          key: keyD,
          onDismissed: (d){
              cubit.deleteFromDatabase(id: data['id']);
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              elevation: 2,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 1),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${data[DataBaseTablesNames.title]}',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            '${data[DataBaseTablesNames.time]}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${data[DataBaseTablesNames.date]}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: color,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                title,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: (){
                            onTap();
                        },
                        icon: cubit.chooseCategory[index][DataBaseTablesNames.important]=='0'?  const Icon(
                          Icons.star_border_purple500_sharp,
                          size: 30,
                        ):const Icon(
                          Icons.star,
                          size: 30,
                          color: Colors.red,
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}