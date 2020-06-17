import 'package:uevents/domain/accessLevel.dart';

class Access 
{
  int level;

  Access(this.level);

  bool isValid(int level)
  {
    return level >= AccessLevel.USER.index && level <= AccessLevel.ADMIN.index;
  }

  @override 
  String toString() {
    switch(level)
    {
      case 0:
        return "Пользователь";
      break;
      case 1: 
        return "Организатор";
      break;
      case 2: 
        return "Администратор";
      break;
    }

    return "ошибка";
  }
}