// 가져올 데이터를 클래스로 만들어 관리
// https://quicktype.io/

import 'dart:convert';

class Book {
  String title;
  String link;
  String image;
  String author;
  String discount;
  String publisher;
  String pubdate;
  String isbn;
  String description;

  Book({
    required this.title,
    required this.link,
    required this.image,
    required this.author,
    required this.discount,
    required this.publisher,
    required this.pubdate,
    required this.isbn,
    required this.description,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    title: json["title"],
    link: json["link"],
    image: json["image"],
    author: json["author"],
    discount: json["discount"],
    publisher: json["publisher"],
    pubdate: json["pubdate"],
    isbn: json["isbn"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "link": link,
    "image": image,
    "author": author,
    "discount": discount,
    "publisher": publisher,
    "pubdate": pubdate,
    "isbn": isbn,
    "description": description,
  };
}