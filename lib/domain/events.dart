import 'package:uevents/data/data.dart';
import 'package:uevents/services/database.dart';

class Events 
{
  static var toShow = DatabaseService().getEvents();

  //loadData(List<String> filters) async {
  //  var stream = DatabaseService().getEvents();
//
  //  stream.listen((List<Data> dataList) {
  //    if (filters != null)
  //        toShow = dataList.where((g) => g.organizer == filters.first);
  //      else 
  //        toShow = dataList;
  //    }
  //  );
  //}
//
  //Stream<Data> getData() async*
  //{
  //  for (var i = 0; i < toShow.length; i++)
  //    yield toShow[i];
  //}

}