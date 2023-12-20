

class Detail { // 디테일 조회 후 결과 담는 생성자
  String detailTitle;
  String detailLink;
  String detailImage;
  String detailAuthor;
  String detailDiscount;
  String detailPublisher;
  String detailPubdate;
  String detailIsbn;
  String detailDescription;

  // '' (빈 문자열)을 기본값으로 설정하여 값을 null로 받을 경우 빈 문자열로 초기화
  Detail({
    this.detailTitle = '',
    this.detailLink = '',
    this.detailImage = '',
    this.detailAuthor = '',
    this.detailDiscount = '',
    this.detailPublisher = '',
    this.detailPubdate = '',
    this.detailIsbn = '',
    this.detailDescription = '',
  });

  // 들어오는 값이 null 인 경우를 대비
  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    detailTitle: json["title"] ?? '',
    detailLink: json["link"] ?? '',
    detailImage: json["image"] ?? '',
    detailAuthor: json["author"] ?? '',
    detailDiscount: json["discount"] ?? '',
    detailPublisher: json["publisher"] ?? '',
    detailPubdate: json["pubdate"] ?? '',
    detailIsbn: json["isbn"] ?? '',
    detailDescription: json["description"] ?? '',
  );
}