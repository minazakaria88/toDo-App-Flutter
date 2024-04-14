import 'package:flutter/material.dart';
import 'package:todo/core/utils/app_strings.dart';

import '../../feature/home/presentation/manager/cubit.dart';
import '../../feature/home/presentation/widget/input_widget.dart';

void showCustomBottomSheet(AppCubit cubit, scaffoldKey, formKey) {
  scaffoldKey.currentState!.showBottomSheet(
    enableDrag: false,
    (context) =>  BottomSheetWidget(formKey: formKey,cubit: cubit,scaffoldKey: scaffoldKey),
  );
}

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({
    super.key, required this.formKey, required this.cubit, required this.scaffoldKey,
  });
  final GlobalKey<FormState> formKey;
  final AppCubit cubit;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: widget.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputWidget(
                  controller: widget.cubit.title,
                  title: 'title',
                  onTap: (){
            
                  },
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'required';
                    }
                  },
                  iconData: Icons.title,
                ),
                InputWidget(
                  controller: widget.cubit.time,
                  title: 'time',
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((value) {
                      widget.cubit.time.text = value!.format(context).toString();
                    });
                  },
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'required';
                    }
                  },
                  iconData: Icons.timer,
                ),
                InputWidget(
                  controller: widget.cubit.date,
                  title: 'date',
                  onTap: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(3030),
                    ).then((value) {
                      widget.cubit.date.text = formatDate(value.toString());
                    });
                  },
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'required';
                    }
                  },
                  iconData: Icons.date_range,
                ),
                Wrap(
                  children: [
                    RadioListTile(
                      title: const Text(AppStrings.shopping),
                        value: AppStrings.shopping,
                        groupValue: widget.cubit.category,
                        onChanged: (value){
                          setState(() {
                            widget.cubit.changeCategory(value);
                          });
                          print(widget.cubit.category);
                        }
                    ),
                    RadioListTile(
                      title: const Text(AppStrings.personal),
                        value: AppStrings.personal,
                        groupValue: widget.cubit.category,
                        onChanged: (value){
                          setState(() {
                            widget.cubit.changeCategory(value);
                          });
                          print(widget.cubit.category);
                        }
                    ),
                    RadioListTile(
                        title: const Text(AppStrings.work),
                        value: AppStrings.work,
                        groupValue: widget.cubit.category,
                        onChanged: (value){
                          setState(() {
                            widget.cubit.changeCategory(value);
                          });
                          print(widget.cubit.category);
                        }
                    ),
            
                    RadioListTile(
                        title: const Text(AppStrings.learning),
                        value: AppStrings.learning,
                        groupValue: widget.cubit.category,
                        onChanged: (value){
                          setState(() {
                            widget.cubit.changeCategory(value);
                          });
                          print(widget.cubit.category);
                        }
                    ),
                  ],
                ),
            
            
              ],
            
            ),
          ),
        ),
      ),
    );
  }
  String formatDate(String date)
  {
    String newDate='';
    for(int i=0;i<10;i++)
    {
      newDate+=date[i];
    }

    return newDate;
  }
}
