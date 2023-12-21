import 'package:flutter/material.dart';
import 'package:helloflutter/pages/bookDetail/Detail.dart';
import 'package:helloflutter/pages/bookList/List.dart';


import 'package:helloflutter/views/bookList.dart';
import 'package:helloflutter/views/list.dart';
import 'package:get/get.dart';


void main() {
  runApp(const MyApp());
}

/// stateless 로 구현해 GetX 사용한 버전

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Naver Book',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      initialRoute: '/', // 리스트로 화면 시작

      // 경로 이름 설정
      getPages: [
        GetPage(name: '/', page: () => BookAllList()),
        // 디테일 페이지엔 해당 도서의 고유번호와 같이 이동
        GetPage(name: '/detail/:isbn', page:  () => BookInfo())
      ],

    );

  }
}


/// stateful 로 구현한 버전

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Naver Book',
//         theme: ThemeData(scaffoldBackgroundColor: Colors.white),
//         // ui
//         //home: const BookList(), // 버전 1 -- 한 페이지에 모든 기능 구현
//         home: const AllList(), // 버전 2 -- 파일을 나눠 기능 구현
//
//     );
//
//   }
// }



/// hello flutter  실습

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

