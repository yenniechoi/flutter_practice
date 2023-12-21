// 가져올 데이터를 클래스로 만들어 관리
// https://quicktype.io/

import 'dart:convert';

class Book { // 리스트 조회 후 결과 담는 아이템
  String title;
  String link;
  String image;
  String author;
  String discount;
  String publisher;
  String pubdate;
  String isbn;
  String description;

  // '' (빈 문자열)을 기본값으로 설정하여 값을 null로 받을 경우 빈 문자열로 초기화
  Book({
    this.title = '',
    this.link = '',
    this.image = '',
    this.author = '',
    this.discount = '',
    this.publisher = '',
    this.pubdate = '',
    this.isbn = '',
    this.description = '',
  });

  // json 값 넣을때 쓰임
  // 들어오는 값이 null 인 경우를 대비
  factory Book.fromJson(Map<String, dynamic> json) => Book(
    title: json["title"] ?? '',
    link: json["link"] ?? '',
    image: json["image"] ?? '',
    author: json["author"] ?? '',
    discount: json["discount"] ?? '',
    publisher: json["publisher"] ?? '',
    pubdate: json["pubdate"] ?? '',
    isbn: json["isbn"] ?? '',
    description: json["description"] ?? '',
  );

}