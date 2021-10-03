import 'package:flutter/material.dart';
import 'package:flutter_application_7/database.dart';
import 'package:flutter_application_7/pages/homepage.dart';

// The widget "Tile" here is the layout of each task getting displayed dynamically on the screen
class Tile extends StatefulWidget {
  final bool isCompleted;
  final String task;
  final String documentId;
  Tile(this.isCompleted, this.task, this.documentId);

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  late bool edittext;
  TextEditingController taskEdittingControler = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        child: Row(
          children: [
            GestureDetector(
                onTap: () {
                  Map<String, dynamic> taskMap = {
                    "isCompleted": !widget.isCompleted
                  };
                  DatabaseServices()
                      .updateTask(taskMap, widget.documentId);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          width: 1), // Mark Todo as Updated
                      borderRadius: BorderRadius.circular(30)),
                  child: widget.isCompleted
                      ? Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      : Container(),
                )),
            SizedBox(
              width: 6,
            ),
            edittext
                ? Text(
                    widget.task, // Text Editor for each task
                    style: TextStyle(fontSize: 15),
                  )
                : Expanded(
                    child: TextField(
                      controller: taskEdittingControler,
                      onChanged: (text) {
                        taskEdittingControler.text = text;
                        setState(() {});
                      },
                    ),
                  ),
            SizedBox(
              width: 180,
            ),
            GestureDetector(
                // Edit Todo
                child: Icon(
                  Icons.edit,
                  size: 20,
                  color: Colors.black,
                ),
                onTap: () {
                  Map<String, dynamic> taskMap = {
                    "task": taskEdittingControler.text,
                    "isCompleted": false
                  };
                  edittext = true;
                  DatabaseServices().updateTask(taskMap, widget.documentId); //Edit Todo
                }),
            SizedBox(
              width: 8,
            ),
            GestureDetector(
              onTap: () {
                DatabaseServices().deleteTask(widget.documentId);
              },
              child: Icon(Icons.close,
                  size: 20, color: Colors.black), // Delete Todo
            )
          ],
        ));
  }
}
