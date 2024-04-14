class AppStrings
{
  static const appTitle='Notes';
  static const shopping='shopping';
  static const personal='personal';
  static const work='Work';
  static const learning='Learning';
}

class DataBaseTablesNames
{
  static const String table='tasks';
  static const String title='title';
  static const String date='date';
  static const String time='time';
  static const String important='important';
  static const String category='category';
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