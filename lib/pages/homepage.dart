import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_7/tile_layout.dart';
import 'package:flutter_application_7/database.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  Stream? taskStream;

  DatabaseServices databaseServices = new DatabaseServices();
  TextEditingController taskEdittingControler = new TextEditingController();
  @override
  void initState() {
    databaseServices.getTasks().then((val) {
      taskStream = val;
      setState(() {});
    });

    super.initState();
  }

  Widget taskList() {
    return StreamBuilder(
      stream: taskStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.only(top: 10),
                itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Tile(
                    (snapshot.data! as QuerySnapshot).docs[index]
                        ["isCompleted"],
                    (snapshot.data! as QuerySnapshot).docs[index]["task"],
                    (snapshot.data! as QuerySnapshot).docs[index].id,
                  );
                })
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,centerTitle: true,
          title: Text("Todo App"),
        ),
        body: Container(
          child: Column(margin:EdgeInsets.symmetric(horizonal:50),
            children: [
              const Text("TO DO APP"),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: taskEdittingControler,
                      decoration: const InputDecoration(hintText: "task"),
                      onChanged: (text) {
                        taskEdittingControler.text = text;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  taskEdittingControler.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            Map<String, dynamic> taskMap = {
                              "task": taskEdittingControler.text,
                              "isCompleted": false
                            };

                            databaseServices.createTask(taskMap); // Create Todo
                            taskEdittingControler.text = "";
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              child: Text("ADD")))
                      : Container()
                ],
              ),
              taskList()
            ],
          ),
        ));
  }
}
