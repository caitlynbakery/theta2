import 'package:flutter/material.dart';
import '../main.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class ToDoButton extends StatelessWidget {
  const ToDoButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: () async{
      var response = await http.get('https://jsonplaceholder.typicode.com/todos/1');
      var responseBody = response.body;

      context
        .read<MainResponseWindow>()
        .updateResponseWindow(responseBody);
    },
    child: Text('To Do'),
    );
  }
}