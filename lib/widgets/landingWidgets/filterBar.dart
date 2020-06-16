import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterBar extends StatefulWidget
{
  bool _filterBarExpanded;
  void Function() _onPressed;
  Map<String, List<String>> _filters = {
    "Тематика" : ["Программирование", "Анализ данных", "Маркетинг", "Экономика"],
    "Организатор" : ["УрФУ", "УФрУ", "Лестех", "Техлес"]
  }; 

  bool isExpanded()
  {
    return _filterBarExpanded;
  }

  void setFilters(Map<String, List<String>> filters)
  {
    _filters = filters;
  }

  void setExpansion(bool isExpanded)
  {
    _filterBarExpanded = isExpanded;
  }

  FilterBar(this._filterBarExpanded, this._onPressed);

  @override
  State<StatefulWidget> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> 
{
  double _filterBarHeight = 40;
  double _filterBarWidth = 150;
  Map<String, String> _filterSelectedValues = Map<String, String>();

  Widget build(BuildContext context) 
  {
    return widget._filterBarExpanded ? _createExtendedFilterBar(context) : _createFilterBar(context);
  }

  Widget _createFilterBar(BuildContext context) 
  {
    var widgetBorderRadius = BorderRadius.only(bottomLeft: Radius.circular(10)).add(BorderRadius.only(bottomRight: Radius.circular(10)));
    var widgetBorder = Border.fromBorderSide(BorderSide(color: Color.fromRGBO(216, 216, 216, 1)));

    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: widgetBorderRadius),
        child: InkWell( 
          onTap: () { setState(() { widget._filterBarExpanded = true; }); },
          borderRadius: widgetBorderRadius,
          child: AnimatedContainer(
            duration: Duration(seconds: 5),
            curve: Curves.bounceIn,
            height: _filterBarHeight,
            width: _filterBarWidth,
            decoration: BoxDecoration(
              border: widgetBorder,
              borderRadius: widgetBorderRadius,
             // color: Colors.white
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[ 
                Container(
                  child: Icon(Icons.tune)
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text('Фильтрация')
                )
            ])
          ),
      ),
    );
  }

  Widget _createExtendedFilterBar(BuildContext context) 
  {
    var content = List<Widget>();

    content.add(Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Text('Доступные критерии',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
      ));

      widget._filters.forEach((key, value) {
        content.add(Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Text(key, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300))
        ));
        content.add(_createFilterElement(context, key, value));
      }
    );

    content.add(Padding(padding: EdgeInsets.symmetric(vertical: 8)));

    content.add(FlatButton(
      onPressed: () => widget._onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: Colors.red)),
      color: Colors.pinkAccent,
      textColor: Colors.white,
      child: Container(
        height: 30,
        alignment: Alignment.center,
        child: Text(
          'ПРИМЕНИТЬ',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ));

    return Container(
      decoration: BoxDecoration( 
        boxShadow: [BoxShadow(blurRadius: 5, offset: Offset(2, 2), color: Color.fromRGBO(0, 0, 0, 0.1))],
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0)
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
        width: 300,
        child: ScrollConfiguration(
          behavior: _CustomScrollBehaviour(),
          child: ListView(
            shrinkWrap: true,
            children: content
          ),
        )
      ),
    );
  }

  Widget _createFilterElement(BuildContext context, String filtersTitle, List<String> filters) //text = Filter()
  {//вынести в зацикленный конструктор
    return FormField<String>(
        builder: (FormFieldState<String> state) {
          return Container(
            child: InputDecorator(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding: EdgeInsets.only(left: 10)
              ),
              child: _createFilterItem(filtersTitle, filters, (val) => { setState(() { _filterSelectedValues[filtersTitle] = val; })})
            ),
          );
        }
    );
  }

  Widget _createFilterItem(String groupName, List<String> filters, void Function(String arg) onChangedFunc)
  {
    List<Widget> items = List<Widget>();

    for (var filter in filters)
    {
      items.add(Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: ChoiceChip( 
          selected: false,
          label: Text(filter),
          onSelected: (val) {},
        ),
      ));
    }

    return Container(height: 50, child:
      ScrollConfiguration(
        behavior: _CustomScrollBehaviour(),
          child: ListView(        
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: items
        ),
      )
    );
  }
}

class _CustomScrollBehaviour extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}