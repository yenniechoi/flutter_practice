import 'package:flutter/material.dart';
import '../models/books.dart';
import '../repository/books_repository.dart';

// 데이터를 사용자에게 알려주기

class BooksProvider extends ChangeNotifier {
  // EvRepository를 접근(데이터를 받아와야 하기 때문에)
  BooksRepository _booksRepository = BooksRepository();

  List<Book> _books = [];
  List<Book> get books => _books;

  // 데이터 로드
  loadBooks() async {
    // BooksRepository 접근해서 데이터를 로드
    // listBooks에 _books를 바로 작성해도 되지만 예외 처리와 추가적인 가공을 위해 나눠서 작성한다.
    List<Book>? listBooks = await _booksRepository.GetNaverBookSearch();
    _books = listBooks!;
    notifyListeners(); // 데이터가 업데이트가 됐으면 구독자에게 알린다.
  }
}