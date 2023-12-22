import 'package:flutter/material.dart';
import 'package:helloflutter/pages/bookDetail/Detail.dart';
import 'package:helloflutter/pages/bookList/List.dart';
import 'package:helloflutter/theme/ThemeController.dart';
import 'package:helloflutter/theme/book_themes.dart';

import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

/// GetX 사용해 stateless 로 구현한 버전

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final ThemeController _themeController = ThemeController(); // 테마 변경 관리하는 컨트롤 의존성 주입

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false, // 상단에 뜨는 디버그 띠 없애기

          /// 테마 변경
          // 앱을 처음 구동할 때에는 시스템 설정을 따라 테마 결정
          // themeMode: ThemeMode.system, // Theme Mode 설정 .system : 시스템에 따라 변경됨을 의미
          // 자체적으로 테마를 바꾸고 싶어서 아이콘 생성
          theme: _themeController.isDarkMode.value ? BookThemes.darkTheme : BookThemes.lightTheme,

          /// 경로 설정
          initialRoute: '/', // 리스트로 화면 시작
          getPages: [ // 경로 이름 설정
            GetPage(name: '/', page: () => BookAllList()),
            GetPage(name: '/detail/:isbn', page: () => BookInfo()) // 디테일 페이지엔 해당 도서의 고유번호와 같이 이동
          ],

          /// 경로가 이동될 때, body 영역 안에서만 바뀌게 하기
          defaultTransition: Transition.cupertino, // body 컨텐츠만 바뀌기
          defaultGlobalState: true, // 공통 AppBar 설정 유지하기

          /// 공통 AppBar 설정
          builder: (context, child) {
            return Scaffold(
              appBar: AppBar(
                forceMaterialTransparency: true, // 스크롤 시 색상 변경 안되게.
                title: const Text(
                  'Naver Book',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),

                /// 테마 변경 아이콘
                actions: [
                  IconButton(
                    icon: Icon(_themeController.isDarkMode.value
                        ? Icons.light_mode_rounded
                        : Icons.nightlight),
                    onPressed: _themeController.toggleTheme,
                  ),
                ],
              ),
              body: child,
            );
          },
        ));
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
