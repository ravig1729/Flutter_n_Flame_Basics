// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter = _counter + 2;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

import 'package:flutter/material.dart';

import './question.dart';
import 'Quiz App/answer.dart';

void main() {
  runApp(MyApp());
}

//making StatelessWidget to StatefulWidget: creating a separate class for state<MyApp> and MyApp as a StatefulWidget and createState inside and do setState(), inside where we want to change the state of the thing.
//_MyAppState '_' makes public to private and it can do changes inside the main.dart not from outside.
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  void answerQuestion() {
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    //print('Answer Chosen!!!!!!!');
  }

  @override
  Widget build(BuildContext context) {
    var questions = [
      // 'What\'s your name?',
      // 'What\'s your mother\'s name?',
      // 'What\'s your father\'s name?',
      //mapping the answer and question:
      {
        'questionText': 'What\'s your favourite Color?',
        'answers': ['Black', 'green', 'blue', 'red'],
      },
      {
        'questionText': 'What\'s your favourite Cricket Player?',
        'answers': ['Sachin', 'Dhoni', 'Kohli', 'Sehwag'],
      },
      {
        'questionText': 'What\'s your favourite Place in AP?',
        'answers': ['Vijayawada', 'Srikakulam', 'Rajhamundry', 'Vizag'],
      }
    ];
    return MaterialApp(
      // home: Text('Hello! Viswa'),
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First Quiz App'),
        ),
        // body: Text('This is my Default'),
        body: Column(
          children: [
            // Text(questions.elementAt(1)),
            Question(
              //questionIndex is the index ,we get from array of questions.
              // questions[_questionIndex],
              questions[_questionIndex]["questionText"],
            ),
            // ElevatedButton(
            //   child: Text('Answer1'),
            //   onPressed: answerQuestion,
            // ),
            // ElevatedButton(
            //   child: Text('Answer2'),
            //   onPressed: () => print('Answer2 Chosen!!!!!!!!!!'),
            // ),
            // ElevatedButton(
            //   child: Text('Answer3'),
            //   onPressed: () {
            //     //........
            //     print('Answer3Chosen');
            //   },
            // ),
            // ElevatedButton(
            //   child: Text('Answer4'),
            //   onPressed: answerQuestion,
            // ),
//inplace of ElevatedButton in this we can directly write Answer();
            // Answer(answerQuestion),
            // Answer(answerQuestion),
            // Answer(answerQuestion),
            // Answer(answerQuestion),
            ...(questions[_questionIndex]['answers'] as List<String>)
                .map((answer) {
              return Answer(answerQuestion, answer);
            }).toList()
          ],
        ),
      ),
    );
  }
}
