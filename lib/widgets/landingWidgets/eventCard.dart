import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uevents/data/data.dart';

class EventWidget extends StatefulWidget 
{
  final Data _eventData;
  final void Function() _onDetailsButtonPressed;
  final void Function() _onRemoveButtonPressed;
  final void Function() _onEditButtonPressed;

  EventWidget(this._eventData, this._onDetailsButtonPressed, this._onRemoveButtonPressed, this._onEditButtonPressed);

  @override
  State<StatefulWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> 
{
  double _backContainerHeight = 475;
  double _backContainerWidth = 375;
  double _frontContainerWidth = 390;
  double _frontContainerHeight = 400;
  BorderRadius _backContainerBorderRadius = BorderRadius.circular(5);
  BorderRadius _frontContainerBorderRadius = BorderRadius.circular(5);
  Color _backContainerColor = Color.fromRGBO(220, 220, 220, 1);
  Color _frontContainerColor = Color.fromRGBO(240, 240, 240, 1);


  @override
  Widget build(BuildContext context) {
    DateTime startTime = widget._eventData.startTime.toDate();
    DateTime endTime = widget._eventData.endTime.toDate();
    double addressSpaceHeight = (_backContainerHeight - _frontContainerHeight) / 2;
    double contentPadding = 40;

    return Container(
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [  
          Material(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: _backContainerBorderRadius),

            child: Container(
              width: _backContainerWidth,
              height: _backContainerHeight,
              decoration: BoxDecoration(
                color: _backContainerColor,
                borderRadius: _backContainerBorderRadius
              ),

              child: Column( 
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 33
                    ),
                    height: addressSpaceHeight,
                    child: Row( 
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row( 
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.location_on, color: Colors.pinkAccent, size: 30,),
                              Container(
                                margin: EdgeInsets.only(
                                  left: 5,
                                  top: 1
                                ),
                                child: Text(widget._eventData.address, style: TextStyle(fontSize: 16))
                              )
                            ],
                          ),
                        ),
                        Container( 
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //Container(
                              //  margin: EdgeInsets.only(right: 7),
                              //  child: Icon(Icons.access_time)
                              //),
                              Text(
                                DateFormat("HH:mm").format(startTime) + ' - ' + DateFormat("HH:mm").format(endTime),
                                style: TextStyle(fontSize: 16)
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container( 
                    padding: EdgeInsets.only(
                      left: 26,
                      right: 33
                    ),
                    height: addressSpaceHeight,

                    child: Row( 
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration( 
                                border: Border.all(width: 2, color: Colors.pinkAccent),
                                borderRadius: BorderRadius.circular(100),
                              ),

                              child: ClipRRect( 
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  "https://pbs.twimg.com/profile_images/1194221563949862913/LcIsIOZR_400x400.jpg",
                                  fit: BoxFit.cover
                                ),
                              ),
                            ),
                            Container( 
                              margin: EdgeInsets.only(
                                left: 15,
                                top: 1
                              ),
                              child: Text(widget._eventData.organizer, style: TextStyle(fontSize: 16)),
                            )
                          ],
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Icon(Icons.people)
                              ),
                              Text(widget._eventData.participants.length.toString())
                            ],
                          )
                        )
                      ],
                    ),
                  )
                ],
              )
            ),
          ),
          Material(
            elevation: 3,
            borderRadius: _frontContainerBorderRadius,
            color: _frontContainerColor,
            
            child: InkWell(
              onDoubleTap: widget._onRemoveButtonPressed,
              onLongPress: widget._onEditButtonPressed,

              child: Container(
                width: _frontContainerWidth,
                height: _frontContainerHeight,
                decoration: BoxDecoration(
                  borderRadius: _frontContainerBorderRadius
                ),

                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: contentPadding),

                  child: Column( 
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container( 
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 15),

                        child: Text(
                          widget._eventData.title,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
                        ),
                      ),
                      Container( 
                        child: ClipRRect(
                          borderRadius: _frontContainerBorderRadius,
                          child: Image.network(
                            "https://cdn.app.compendium.com/uploads/user/e7c690e8-6ff9-102a-ac6d-e4aebca50425/b99b532f-aedc-4dae-9830-5d6570359232/Image/ca202e9bc6abbfe35aac045248b4784e/ai_machinelearning.jpg",

                          ),
                        )
                      ),
                      Container( 
                        //margin: EdgeInsets.only(top: 20),
                        child: Text(
                          widget._eventData.shortDescription
                        )
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FlatButton(
                              onPressed: widget._onDetailsButtonPressed,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: Colors.red)),
                              color: Colors.pinkAccent,

                              child: Container(
                                width: 160,
                                height: 30,
                                alignment: Alignment.center,
                                child: Text(
                                  'УЗНАТЬ БОЛЬШЕ',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                          ),
                          ]
                        ),
                      ),
                    ],
                    
                  ),
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
  
}