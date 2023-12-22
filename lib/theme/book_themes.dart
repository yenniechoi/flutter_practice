import 'dart:io' show Platform;

import 'package:flutter/material.dart';

/// 테마별 컬러 속성 지정한 클래스

class BookThemes {
  /// 라이트 테마 재정의
  static final lightTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white, // Scaffold 위젯의 배경색
      colorScheme: const ColorScheme.light(), // ColorScheme: 주로 버튼, 텍스트 필드 등에서 사용되는 색상들의 집합
      primaryColor: const Color(0xFF17B752), // 앱의 주요 컬러
      primaryColorDark: Colors.black, // 프라이머리 컬러의 어두운 버전

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black26,
        ),
        titleTextStyle: TextStyle(
          color: Color(0xFF17B752),
        ),
      ),

      // list 검색입력창
      inputDecorationTheme: const InputDecorationTheme(
        prefixIconColor: Color(0xFF17B752), // 돋보기 아이콘
        suffixIconColor: Colors.black26, // X 아이콘
        hintStyle: TextStyle(color: Colors.black26), // 입력창 플레이스홀더
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF17B752)), // 커서 올라가면 보더 색상 바뀜
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black26), // 커서 안올리고 있을 때
        ),
      ),

      // 리스트 카드
      cardTheme: const CardTheme(
        surfaceTintColor: Colors.white, // 이거를 써야 카드가 하얗게 나옴
        shadowColor: Colors.black87,
      )
  );


  /// 다크 테마 재정의
  static final darkTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.grey.shade900,
      colorScheme: const ColorScheme.dark(),
      primaryColor: const Color(0xFF17B752),
      primaryColorLight: Colors.white,

      // AppBar
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: Color(0xFF17B752),
        ),
      ),

      // list 검색입력창
      inputDecorationTheme: const InputDecorationTheme(
        prefixIconColor: Color(0xFF17B752), // 돋보기 아이콘
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF17B752)), // 커서 올라가면 보더 색상 바뀜
        ),
      ),

      // 리스트 카드
      cardTheme: const CardTheme(
        surfaceTintColor: Colors.white12, // 이거를 써야 카드가 하얗게 나옴
        shadowColor: Colors.white54,
      )


  );



}
