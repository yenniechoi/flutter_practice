// api 통신

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../models/book.dart';
import 'package:http/http.dart' as http;

/*
* {
	"lastBuildDate":"Tue, 19 Dec 2023 08:57:58 +0900",
	"total":927,
	"start":1,
	"display":10,
	"items":[
		{
			"title":"크리스마스 전날 밤에",
			"link":"https://search.shopping.naver.com/book/catalog/44289483629",
			"image":"https://shopping-phinf.pstatic.net/main_4428948/44289483629.20231128081333.jpg",
			"author":"홀리 하비",
			"discount":"13500",
			"publisher":"미운오리새끼",
			"pubdate":"20231130",
			"isbn":"9791165182786",
			"description":"1년 중 가장 마법 같은 시간, 크리스마스!\n크리스마스 전날 밤에는 무슨 일이 일어날까?\n\n크리스마스 전날 밤, 벽난로에는 소원이 담긴 긴 양말들이 나란히 걸려 있습니다. 모두가 잠든 한밤중에 잠에서 깬 아기는 형제자매들이 보지 못하는 은밀한 손님을 만나게 됩니다. 커다란 자루를 등에 짊어지고 굴뚝을 타고 내려온 재투성이 조그만 할아버지. 발그레한 뺨에 장난스런 미소를 머금고, 불룩 나온 배가 출렁거리는 작고 포동포동한 이 할아버지는 우리 모두가 기다리던 손님이 맞을까요?\n크리스마스 전날 밤, 어떤 일이든 일어날 수 있는 마법의 시간으로 떠나 보세요."
		},
* */

class BooksProvider {

  static Future<List<Book>> getBookInfo() async {
    String query = "크리스마스"; // 검색어. UTF-8 인코딩 되어 있어야 함. 필수!!!!
    var display = 10; // 한 번에 표시할 검색 결과 개수 (기본10, 최대100) 필수x
    var start = 1; // 검색 시작 위치 (기본1, 최대100) 필수x
    String sort = "sim"; // 검색 결과 정렬 방법 (sim> 정확도 순으로 내림차, date> 출간일 순으로 내림차) 필수x
    String baseUrl =
        "https://openapi.naver.com/v1/search/book.json?query=$query&display=$display&start=$start&sort=$sort";

    // http api 통신
    try {
      var response = await http.get(
          Uri.parse(baseUrl), // String 을 uri 로 파싱
          headers: { // 헤더에 api 통신에 필요한 id 와 secret 코드 싣기
            "X-Naver-Client-Id": "El5rwGrHE9B4szflEyPi",
            "X-Naver-Client-Secret": "p8rqTm4y4w",
          }
      );

      // 통신이 제대로 됐다면
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body); // 받아온 json 데이터를 디코딩
        // json 데이터에서 'items' 에 매칭된 배열을 담아야 함.
        List<Book> bookInfo = (jsonData['items'] as List) // as 키워드로 명시적으로 타입 지정
            .map((item) => Book.fromJson(item)) // 리스트 각 항목을 item에 담아 Book 객체로 변환
            .toList(); // map 결과를 다시 리스트로 변환
        return bookInfo;

      } else {
        debugPrint('Error occurred. Please try again');
        return <Book>[];
      }
    } catch(e) {
      debugPrint(e.toString());
      return <Book>[];
    }
  }


}