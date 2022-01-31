import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TodoApp",
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Colors.purple[800],
        brightness: Brightness.dark,
      ),
      home: const Start(),
    );
  }
}

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);
  @override
  _StartAppState createState() => _StartAppState();
}

class _StartAppState extends State<Start> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fieldController = TextEditingController();
  final List<Map> _todos = <Map>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo App")),
      body: Column(children: [
        Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _fieldController,
                  decoration: const InputDecoration(hintText: "Enter a Todo"),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _todos.add({
                          "value": _fieldController.value.text,
                          "done": false
                        });
                        _fieldController.clear();
                      });
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(fontSize: 24),
                    ))
              ],
            )),
        Expanded(
            child: SizedBox(
                height: 200,
                child: ListView(
                  children: _todos
                      .map((Map todo) => ListTile(
                          title: Text(todo["value"],
                              style: TextStyle(
                                  fontSize: 24,
                                  decoration: todo["done"]
                                      ? TextDecoration.lineThrough
                                      : null)),
                          leading: IconButton(
                            onPressed: () {
                              setState(() {
                                _todos.remove(todo);
                              });
                            },
                            icon: const Icon(Icons.delete),
                            color: Colors.purple,
                          ),
                          trailing: IconButton(
                            icon: Icon(todo["done"]
                                ? Icons.check_box
                                : Icons.check_box_outline_blank),
                            onPressed: () {
                              setState(() {
                                todo["done"] = !todo["done"];
                              });
                            },
                          )))
                      .toList(),
                )))
      ]),
    );
  }
}
