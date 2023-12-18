import 'dart:convert' as convert;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/books.dart';

// open api를 통해 데이터를 가져옴


class BooksRepository {
  // static final SearchRepository instance = SearchRepository._internal();
  // factory SearchRepository() => instance;
  // SearchRepository._internal();

  String clientId = "El5rwGrHE9B4szflEyPi";
  String clientSecret = "p8rqTm4y4w";
  String query = "크리스마스"; // 검색어. UTF-8 인코딩 되어 있어야 함. 필수!!!!
  var display = 10; // 한 번에 표시할 검색 결과 개수 (기본10, 최대100) 필수는 아님
  var start = 1; // 검색 시작 위치 (기본1, 최대100) 필수 아님
  String sort = "sim"; // 검색 결과 정렬 방법 (sim> 정확도 순으로 내림차, date> 출간일 순으로 내림차) 필수 아님

  get logger => null;

  //void GetNaverBookSearch() async {
  Future<List<Book>?> GetNaverBookSearch() async {
    String baseUrl =
        "https://openapi.naver.com/v1/search/book.json?query=$query&display=$display&start=$start&sort=$sort";
    try {
      http.Response response = await http.get(
          Uri.parse(baseUrl),
          headers: {
            "X-Naver-Client-Id": clientId,
            "X-Naver-Client-Secret": clientSecret,
          });
      if (response.statusCode == 200) {
        //logger.e(response.body);
        // json 데이터
        String jsonData = response.body;
        print(jsonData);
        //Map BookData = jsonDecode(jsonData);



      } else {
        print('Failed to load data. Status cod: ${response.statusCode}');
      }
    } catch (error) {
      print('Failed to load data. Error: $error');
    }
    return null;
  }
}
