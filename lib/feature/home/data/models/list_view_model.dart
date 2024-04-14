import 'package:flutter/cupertino.dart';

class ListViewModel
{
  late final String text;
  late final IconData iconData;
  late  int numberOfTasks;

  ListViewModel({required this.iconData,required this.numberOfTasks,required this.text});
}