import 'package:flutter/material.dart';

import 'package:helloflutter/views/bookList.dart';
import 'package:helloflutter/views/list.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Naver Book',
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        // ui
        //home: const BookList(), // 버전 1
        home: const AllList(), // 버전 2

    ); // home.dart

  }
}





// // StatelessWidget vs. StatefulWidget
// // 앱 상태 즉각 반영 : StatefulWidget + setState 메서드
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(   // 구글 Material 디자인 -- 전체 앱의 테마, 색깔, 화면구성, 라우팅, 초기화면연결 등을 지정.
//       title: '플러터 앱',
//       debugShowCheckedModeBanner: false, // debug 표시를 보지 않습니다.
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: Scaffold(   // Scaffold: 기본적인 Material 디자인 구조 정의. 뼈대.
//           appBar: AppBar(title: const Text("hello flutter")), // 앱 최상단 타이틀
//           body : const Column( // 위젯을 세로로 배치
//             mainAxisAlignment: MainAxisAlignment.spaceAround, // 주 방향(Column(세로), Row(가로))으로 위젯 간격이 서로 일정하게 벌려줌
//             children: [
//               Text("hello flutter!!!"),
//               //Icon(Icons.send, color: Colors.blueAccent)
//             ],
//           )
//       ),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
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
