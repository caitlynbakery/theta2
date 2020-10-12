import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'buttons/to_do_button.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => MainResponseWindow(),
    )
  ], child: MyApp()));
}

class MainResponseWindow with ChangeNotifier {
  String _responseText = "";
  String get responseText => _responseText;

  void updateResponseWindow(response) {
    _responseText = response;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Theta App'),
        ),
          
          body:  SingleChildScrollView(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ToDoButton(),
                MaterialButton(
                  onPressed: () async {
                    var response = await http
                        .get('https://jsonplaceholder.typicode.com/users');
                    var responseBody = response.body;

                    context
                        .read<MainResponseWindow>()
                        .updateResponseWindow(responseBody);
                  },
                  child: Text("Users"),
                ),

                 
                      Text(Provider.of<MainResponseWindow>(context).responseText),
                  
            
              ],
            ), 
          )
            
          
          
       
      ),
    );
  }
}
