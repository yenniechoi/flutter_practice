
/*
* [ 버전 1 ] (현재 사용 안함)
*  api 호출부터 show 까지 한 페이지에서 해결.
*  버튼 눌렀을 때 api 호출되게 함.
*  model 안쓰고 json에서 필요값 추출해서 보여주는 로직
*
* */


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// main.dart 에서 바로 넘어온다.
// 앱 상태 즉각 반영 : StatefulWidget + setState 메서드
class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  bool _loading = false; // 검색 버튼을 누르면 로딩이 활성화된다. 처음엔 누르기 전이니 비활성화.
  List<dynamic> _books = []; // api 에서 json 으로 받은 데이터를 넣을 빈 리스트

  @override
  Widget build(BuildContext context) { // 화면에 띄울 ui
    return Scaffold(
      appBar: AppBar(
        title: const Text('네이버 도서 검색'),
      ),
      body: _books.isNotEmpty ? ListView.builder( // 검색 버튼을 눌러 api 통신을 해 _books 배열에 값이 들어온다면
        //scrollDirection: Axis.vertical,
        itemCount: _books.length, // _books 배열 길이 만큼 item 생성
        itemBuilder: ((context, index) {
          return Card(
            margin: const EdgeInsets.symmetric( // 대칭적 여백 지정
              horizontal: 15.0, // 수평 (왼오)
              vertical: 10.0, // 수직 (위아래)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0), // 전체 여백 지정
              child: Row( // 이미지와 텍스트를 가로로 나열
                children: [
                  Expanded( // 부모의 남은 부분을 전부 채움. 기본 flex값을 1 가지고 있음.
                    child: SizedBox(
                      width: 100, // 이미지 너비 조절
                      child: Image.network(
                          _books[index]['image'],
                          //fit: BoxFit.cover, // 이미지를 화면에 맞게 조정
                      ),
                    )
                  ),
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_books[index]['title']),
                          Text(_books[index]['author']),
                          Text(_books[index]['discount']),
                        ],
                      )
                  )
                ],
              ),
            ),
          );
        }),
      )
          : Center(
              child: _loading
                    ? const CircularProgressIndicator() // 로딩 화면
                    : ElevatedButton( // 버튼을 누르면
                      onPressed: getBookList, // api 통신이 시작되고
                      child: const Text("크리스마스 검색"),
                    ),
          ),
    );
  }

  // api 호출 메서드
  getBookList() async {
    setState(() {
      _loading = true; // api 통신이 시작되면 로딩 화면이 뜬다.
    });

    // url 파라메터 값 지정 변수
    String clientId = "El5rwGrHE9B4szflEyPi";
    String clientSecret = "p8rqTm4y4w";
    String query = "크리스마스"; // 검색어. UTF-8 인코딩 되어 있어야 함. 필수!!!!
    var display = 10; // 한 번에 표시할 검색 결과 개수 (기본10, 최대100) 필수x
    var start = 1; // 검색 시작 위치 (기본1, 최대100) 필수x
    String sort = "sim"; // 검색 결과 정렬 방법 (sim> 정확도 순으로 내림차, date> 출간일 순으로 내림차) 필수x

    String baseUrl =
        "https://openapi.naver.com/v1/search/book.json?query=$query&display=$display&start=$start&sort=$sort";

    // http api 통신
    var response = await http.get(
        Uri.parse(baseUrl), // String 을 uri 로 파싱
        headers: { // 헤더에 api 통신에 필요한 id 와 secret 코드 싣기
          "X-Naver-Client-Id": clientId,
          "X-Naver-Client-Secret": clientSecret,
        }
    );

    // 통신이 제대로 됐다면
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body); // 받아온 json 데이터를 디코딩
      if (jsonData['items'].isNotEmpty) { // decoding 한 데이터에 items 항목이 있다면
        setState(() {
          _books = jsonData['items']; // 앞서 선언한 빈 리스트에 해당 내용 넣기
          _loading = false; // 로딩 화면 멈추기 위해 비활성화
        });
      }
    }
  }
}
