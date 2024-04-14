import 'package:flutter/material.dart';
import 'package:todo/feature/home/data/models/list_view_model.dart';

class ListViewItem extends StatelessWidget {
  const ListViewItem({
    super.key, required this.onTap, required this.listViewModel,
  });

 final Function onTap;
  final ListViewModel listViewModel;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: ()
        {
          onTap();
        },
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                listViewModel.iconData,
                color: Colors.blue,
                size: 25,
              ),
              const SizedBox(
                width:30 ,
              ),
              Column(
                children: [
                  Text(
                    listViewModel.text,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.blue
                    ),
                  ),
                  Text(
                    '${listViewModel.numberOfTasks} tasks',
                    style: const TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}