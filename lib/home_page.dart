import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'database.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  final GlobalKey<AnimatedListState> _key = GlobalKey();
  final _textController = TextEditingController();
  String userPost = " i am";

  void initState() {
    // if this is the 1st time ever openin the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }

    super.initState();
  }




  void _addItem() {
    db.toDoList.insert(0, userPost);
    _key.currentState!.insertItem(
        0,
      duration: const Duration(seconds: 1),
    );
    db.updateDataBase();
  }


  void _removeItem(int index) {
    _key.currentState!.removeItem(
      index,
      (_, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: const Card(
            margin: EdgeInsets.all(10),
            color: Colors.red,
            child: ListTile(
              title: Text(
                "Deleted",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        );
      },
      duration: const Duration(milliseconds: 300),
    );
    db.toDoList.removeAt(index);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
      AppBar(
        title: Text("T O D O"),
        backgroundColor: Colors.blueGrey,
      ),
      body:
      Center(
          child: Column(
        children: [

          const SizedBox(height: 10),

          Padding(

            padding: const EdgeInsets.all(20.0),
          child :TextField(
            controller: _textController, // this is assigning the controller
            decoration: InputDecoration(
                hintText: "Add Task",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    _textController.clear();
                  },
                  icon: const Icon(Icons.clear),
                )),
          ),),
          MaterialButton(
            onPressed: () {
              //when the button is pressed controller will store the input text into the variable
              setState(() {
                userPost = _textController.text;
                _textController.clear();
                _addItem();

              });
            },
            color: Colors.blueGrey,
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),


          Expanded(

            child: AnimatedList(
              key: _key,
              initialItemCount: db.toDoList.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index, animation) {
                return SizeTransition(
                  key: UniqueKey(),
                  sizeFactor: animation,
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    color: Colors.blueGrey[100],
                    child: ListTile(
                      title: Text(
                        db.toDoList[index],
                        style: const TextStyle(fontSize: 24),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _removeItem(index);
                          db.updateDataBase();
                        },
                      ),
                    ),
                  ),
                );
              },
            ),)

        ],
      )),
    );
  }
}
