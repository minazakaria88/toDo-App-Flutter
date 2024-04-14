import 'package:flutter/material.dart';
import 'package:todo/feature/home/data/models/category_model.dart';

class CategoryTasks extends StatelessWidget {
  const CategoryTasks({
    super.key, required this.categoryModel, required this.function,
  });
  final CategoryModel categoryModel;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        function();
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: categoryModel.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              categoryModel.iconData,
              color: Colors.white,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              categoryModel.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${categoryModel.data.length} Tasks',
              style: const TextStyle(
                  color: Colors.
                  white,
                  fontSize: 18
              ),
            ),
          ],
        ),
      ),
    );
  }
}