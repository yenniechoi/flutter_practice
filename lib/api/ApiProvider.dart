
import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../items/ListItem.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'package:intl/intl.dart';

import '../items/DetailItem.dart';




/// 각 컨트롤러에서 호출하면 네이버 도서 검색 api (리스트/디테일) 조회해서 반환
/// 1. 네이버 책 리스트 검색
/// 2. 네이버 책 디테일 검색


/// 1. 네이버 책 검색 결과 조회 -- JSON
class BooksProvider {

  static Future<List<Book>> getBookList(String query) async {
    //String query = "크리스마스"; // 검색어. UTF-8 인코딩 되어 있어야 함. 필수!!!!
    var display = 10; // 한 번에 표시할 검색 결과 개수 (기본10, 최대100) 필수x
    var start = 1; // 검색 시작 위치 (기본1, 최대100) 필수x
    String sort = "sim"; // 검색 결과 정렬 방법 (sim> 정확도 순으로 내림차, date> 출간일 순으로 내림차) 필수x
    String baseUrl =
        "https://openapi.naver.com/v1/search/book.json?query=$query&display=$display&start=$start&sort=$sort";

    /// http api 통신
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
        List<Book> listInfo = (jsonData['items'] as List) // as 키워드로 명시적으로 타입 지정
            .map((item) => Book.fromJson(item)) // 리스트 각 항목을 item에 담아 Book 객체로 변환
            .toList(); // map 결과를 다시 리스트로 변환
        return listInfo;

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



/// 2. 네이버 책 상세 검색 결과 조회 - XML

class BookDetailProvider {

  static Future <Detail> getBookInfo(String isbn) async { // 책 제목이나 ISBN 필요함
    //print(isbn);
    String baseUrl =
        "https://openapi.naver.com/v1/search/book_adv.xml?d_isbn=$isbn";

    /// http api 통신
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

        String xmlData = response.body; // API로부터 응답을 가져옴

        /// Xml 데이터를 Json으로 변환
        final Xml2Json xml2Json = Xml2Json(); // Xml 데이터를 Json으로 변환하기 위해 xml2json 객체 생성
        xml2Json.parse(xmlData);
        var jsonString = xml2Json.toParker();
        var jsonData = jsonDecode(jsonString);
        //debugPrint('jsonData: $jsonData');

        // Json 데이터를 저장
        Map<String, dynamic> itemData = jsonData['rss']['channel']['item'];


        /// 데이터 가공 작업
        // 출판일 20231229 -> 2023.12.29
        String pubdate = itemData['pubdate'] ?? '';
        DateTime parsedPubdate = DateTime.parse(pubdate); // 원래 날짜 문자열을 DateTime 객체로 파싱
        String formattedPubdate = "${parsedPubdate.year}.${parsedPubdate.month}.${parsedPubdate.day}"; // 포맷을 변경하고자 하는 문자열로 변환

        // 가격 29930 -> 29,930원
        String discount = itemData['discount'] ?? '';
        if (discount != '') {
          int discountAmount = int.parse(discount); // int 로 파싱해서
          NumberFormat formatter = NumberFormat('###,###,###,###'); // 설정해둔 포맷으로
          discount = '${formatter.format(discountAmount)}원'; // 포맷팅을 적용한 후 '원' 붙이기
        }

        // 상세설명 \\n -> \n
        // xml -> json 과정에서 \n -> \\n 이 되어버림.
        String description = itemData['description'] ?? '';  // null일 경우 빈 문자열로 대체 -- 설명 없는 경우도 있음
        description = description.replaceAll('\\n', '\n').replaceAll('\\\\', ' ').replaceAll('\\', '\n');

        /// Detail 객체에 데이터 할당 후 리턴
        Detail detail = Detail(
          detailTitle: itemData['title'],
          detailLink: itemData['link'],
          detailImage: itemData['image'],
          detailAuthor: itemData['author'],
          detailDiscount: discount,
          detailPublisher: itemData['publisher'],
          detailPubdate: formattedPubdate,
          detailIsbn: itemData['isbn'],
          detailDescription: description,
        );
        return detail;

      } else {
        debugPrint('Error occurred. Please try again');
        return Detail(
          detailTitle: 'Error',
          detailLink: '',
          detailImage: '',
          detailAuthor: '',
          detailDiscount: '',
          detailPublisher: '',
          detailPubdate: '',
          detailIsbn: '',
          detailDescription: '',
        );

      }
    } catch(e) {
      debugPrint('통신오류');
      debugPrint(e.toString());
      return Detail(
        detailTitle: 'Error',
        detailLink: '',
        detailImage: '',
        detailAuthor: '',
        detailDiscount: '',
        detailPublisher: '',
        detailPubdate: '',
        detailIsbn: '',
        detailDescription: '',
      );

    }
  }
}

/// 1. 네이버 책 리스트 api 조회시 오는 JSON Raw Data
/*
{
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
*/

/// 2. 네이버 책 디테일 api 조회시 오는 XML Raw Data
/*
<rss version="2.0">
    <channel>
        <title>Naver Open API - book_adv ::&apos;&apos;</title>
        <link>https://search.naver.com</link>
        <description>Naver Search Result</description>
        <lastBuildDate>Wed, 20 Dec 2023 11:24:42 +0900</lastBuildDate>
        <total>1</total>
        <start>1</start>
        <display>1</display>
        <item>
            <title>크리스마스 전날 밤에</title>
            <link>https://search.shopping.naver.com/book/catalog/44289483629</link>
            <image>https://shopping-phinf.pstatic.net/main_4428948/44289483629.20231128081333.jpg</image>
            <author>홀리 하비</author>
            <discount>13500</discount>
            <publisher>미운오리새끼</publisher>
            <pubdate>20231130</pubdate>
            <isbn>9791165182786</isbn>
            <description>1년 중 가장 마법 같은 시간, 크리스마스!
크리스마스 전날 밤에는 무슨 일이 일어날까?

크리스마스 전날 밤, 벽난로에는 소원이 담긴 긴 양말들이 나란히 걸려 있습니다. 모두가 잠든 한밤중에 잠에서 깬 아기는 형제자매들이 보지 못하는 은밀한 손님을 만나게 됩니다. 커다란 자루를 등에 짊어지고 굴뚝을 타고 내려온 재투성이 조그만 할아버지. 발그레한 뺨에 장난스런 미소를 머금고, 불룩 나온 배가 출렁거리는 작고 포동포동한 이 할아버지는 우리 모두가 기다리던 손님이 맞을까요?
크리스마스 전날 밤, 어떤 일이든 일어날 수 있는 마법의 시간으로 떠나 보세요.</description>
        </item>
    </channel>
</rss>
*/

