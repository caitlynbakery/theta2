import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'buttons/to_do_button.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => MainResponseWindow(),
    ),
    ChangeNotifierProvider(create: (_) => MainRequestWindow(),),
    ChangeNotifierProvider(create: (_) => PictureWindow(),)
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

class MainRequestWindow with ChangeNotifier {
  String _requestText = "";
  String get requestText => _requestText;

  void updateRequestWindow(request){
    _requestText = request;
    notifyListeners();
  }
}

class PictureWindow with ChangeNotifier {
  bool _toggleImage = false;
  bool get toggleImage => _toggleImage;

  void toggleImageMethod(){
    _toggleImage = !_toggleImage;
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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
               
                ToDoButton(),
                MaterialButton(
                  onPressed: () async {
                    var response = await http
                        .get('https://jsonplaceholder.typicode.com/users');
                    var responseBody = response.body;

                    var request = 'https://jsonplaceholder.typicode.com/users';

                    context
                        .read<MainResponseWindow>()
                        .updateResponseWindow(responseBody);

                    context
                      .read<MainRequestWindow>()
                      .updateRequestWindow(request);
                  },
                  child: Text("Users"),
                ),
                MaterialButton(onPressed: (){
                  context
                    .read<PictureWindow>()
                    .toggleImageMethod();
                    
                  print("Toggle image");
                },child: Text("Toggle Image"),)
              ]),
              Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 300,
                        child: SingleChildScrollView(
                child:
                          Text(Provider.of<MainRequestWindow>(context).requestText),
              ),
                      ),
                      SizedBox(width: 100),
                      Container(
                        width: 300,
                        child: SingleChildScrollView(
                child:
                          Text(Provider.of<MainResponseWindow>(context).responseText),
              ),
                      ),
                      Container(
                        width: 300,
                        child: Provider.of<PictureWindow>(context)._toggleImage ? ListView(children: [
                          Image.network('https://picsum.photos/400/200?random=1'),
                          SizedBox(height: 12),
                           Image.network('https://picsum.photos/400/200?random=2'),
SizedBox(height: 12),
                            Image.network('https://picsum.photos/400/200?random=3'),
SizedBox(height: 12),
                             Image.network('https://picsum.photos/400/200?random=4'),
SizedBox(height: 12),
                              Image.network('https://picsum.photos/400/200?random=5'),
                        ],) : Container())

                    ],
                  )),
            ],
          )),
    );
  }
}
