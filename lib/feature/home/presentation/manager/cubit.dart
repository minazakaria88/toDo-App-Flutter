import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/feature/home/presentation/manager/state.dart';

import '../../../../core/utils/app_strings.dart';
import '../../data/models/category_model.dart';
import '../../data/models/list_view_model.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitState());

  bool isOpen = false;
  TextEditingController title = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController date = TextEditingController();
  var category = '';

  List<Map> chooseCategory=[];
  void changeCategory(value) {
    category=value;
    emit(ChangeCategoryState());
  }
  void changeBottomSheet() {
    isOpen = !isOpen;
    emit(ChangeBottomSheetState());
  }

  List<ListViewModel> listViewModel = [
    ListViewModel(iconData: Icons.sunny, numberOfTasks: 0, text: 'My Day'),
    ListViewModel(iconData: Icons.star, numberOfTasks: 0, text: 'Important'),
  ];

  List<CategoryModel> categoryModel = [
    CategoryModel(Icons.person, AppStrings.personal, Colors.orange),
    CategoryModel(Icons.person, AppStrings.learning, Colors.red),
    CategoryModel(Icons.work, AppStrings.work, Colors.green),
    CategoryModel(Icons.shopping_cart, AppStrings.shopping, Colors.brown),
  ];

  //database
  Database ? database;

  void createDataBase() {
    openDatabase('todo.db', version: 1,
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE ${DataBaseTablesNames.table} (id INTEGER PRIMARY KEY,${DataBaseTablesNames.title}'
          ' TEXT,${DataBaseTablesNames.time} TEXT,${DataBaseTablesNames.date}'
          ' TEXT,${DataBaseTablesNames.category} TEXT,${DataBaseTablesNames.important} TEXT)');
      debugPrint('database created');
    }, onOpen: (database) {
      getFromDataBase(database);
      debugPrint('database opened');
    }).then((value) {
      database=value;
    });
  }

  void insertIntoDataBase(
      {required String title,
      required String date,
      required String time,
      required String category}) async {
    await database!.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO ${DataBaseTablesNames.table} (${DataBaseTablesNames.title},'
          '${DataBaseTablesNames.time},${DataBaseTablesNames.date},${DataBaseTablesNames.category},${DataBaseTablesNames.important}) '
          'VALUES ("$title","$time","$date","$category","0")');
    }).then((value) {
      debugPrint('Insert successfully ');
      getFromDataBase(database!);

    });
  }
  void upDateDataBase({required int id,required String important})
  {
    database!.rawUpdate('UPDATE ${DataBaseTablesNames.table} SET ${DataBaseTablesNames.important}=? '
        'WHERE id=?',[important,id]).then((value) {
          getFromDataBase(database!);
    });
  }



  List<Map> important=[];
  List<Map> myDay=[];
  void getFromDataBase(Database database) {
    categoryModel[0].data=[];
    categoryModel[1].data=[];
    categoryModel[2].data=[];
    categoryModel[3].data=[];
    important=[];
    myDay=[];
    database
        .rawQuery('SELECT * FROM ${DataBaseTablesNames.table}')
        .then((value) {
      for (var e in value) {
        if (e[DataBaseTablesNames.category] == AppStrings.shopping) {
          categoryModel[3].data.add(e);
        } else if (e[DataBaseTablesNames.category] == AppStrings.personal) {
          categoryModel[0].data.add(e);
        } else if (e[DataBaseTablesNames.category] == AppStrings.learning) {
          categoryModel[1].data.add(e);
        } else {
          categoryModel[2].data.add(e);
        }
        if(e[DataBaseTablesNames.important]=='1')
          {
            important.add(e);
          }
        if(e[DataBaseTablesNames.date]==formatDate(DateTime.now().toString()))
        {
          print(e[DataBaseTablesNames.date]);
          print(formatDate(DateTime.now().toString()));
          myDay.add(e);
        }
      }
      if(chooseCategory.isNotEmpty)
        {
          if(chooseCategory[0][DataBaseTablesNames.category]==AppStrings.shopping)
          {
            chooseCategory=categoryModel[3].data;
          }
          else if(chooseCategory[0][DataBaseTablesNames.category]==AppStrings.personal)
          {
            chooseCategory=categoryModel[0].data;
          }
          else if(chooseCategory[0][DataBaseTablesNames.category]==AppStrings.learning)
          {
            chooseCategory=categoryModel[1].data;
          }
          else
          {
            chooseCategory=categoryModel[2].data;
          }
        }

      listViewModel[1].numberOfTasks=important.length;
      listViewModel[0].numberOfTasks=myDay.length;
      emit(GetDataBaseSuccessState());
    });
  }

  void deleteFromDatabase({
    required int id,
  })
  {
    database!.rawDelete(
        'DELETE FROM  ${DataBaseTablesNames.table}  WHERE id = ?',
        [id]).then((value) {
      getFromDataBase(database!);
      print("$value  successfully deleted");
    });
  }
}
