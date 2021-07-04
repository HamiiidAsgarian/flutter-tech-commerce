// To parse this JSON data, do
//
//     final firstPage = firstPageFromJson(jsonString);

import 'dart:convert';

FirstPage firstPageFromJson(String str) => FirstPage.fromJson(json.decode(str));

String firstPageToJson(FirstPage data) => json.encode(data.toJson());

class FirstPage {
  FirstPage({
    required this.firstpage,
  });

  Firstpage firstpage;

  factory FirstPage.fromJson(Map<String, dynamic> json) => FirstPage(
        firstpage: Firstpage.fromJson(json["firstpage"]),
      );

  Map<String, dynamic> toJson() => {
        "firstpage": firstpage.toJson(),
      };
}

class Firstpage {
  Firstpage({
    required this.carousels,
    required this.scrollableItems,
    required this.windows,
  });

  Carousels carousels;
  ScrollableItems scrollableItems;
  Windows windows;

  factory Firstpage.fromJson(Map<String, dynamic> json) => Firstpage(
        carousels: Carousels.fromJson(json["Carousels"]),
        scrollableItems: ScrollableItems.fromJson(json["scrollableItems"]),
        windows: Windows.fromJson(json["windows"]),
      );

  Map<String, dynamic> toJson() => {
        "Carousels": carousels.toJson(),
        "scrollableItems": scrollableItems.toJson(),
        "windows": windows.toJson(),
      };
}

class Carousels {
  Carousels({
    required this.firstCarousel,
    required this.secondCarousel,
    required this.thirdCarousel,
  });

  Carousel firstCarousel;
  Carousel secondCarousel;
  Carousel thirdCarousel;

  factory Carousels.fromJson(Map<String, dynamic> json) => Carousels(
        firstCarousel: Carousel.fromJson(json["firstCarousel"]),
        secondCarousel: Carousel.fromJson(json["secondCarousel"]),
        thirdCarousel: Carousel.fromJson(json["thirdCarousel"]),
      );

  Map<String, dynamic> toJson() => {
        "firstCarousel": firstCarousel.toJson(),
        "secondCarousel": secondCarousel.toJson(),
        "thirdCarousel": thirdCarousel.toJson(),
      };
}

class Carousel {
  Carousel({
    required this.id,
    required this.imageUrl,
    required this.label,
  });

  int id;
  String imageUrl;
  String label;

  factory Carousel.fromJson(Map<String, dynamic> json) => Carousel(
        id: json["id"],
        imageUrl: json["imageUrl"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imageUrl": imageUrl,
        "label": label,
      };
}

class ScrollableItems {
  ScrollableItems({
    required this.watches,
  });

  List<Watch> watches;

  factory ScrollableItems.fromJson(Map<String, dynamic> json) =>
      ScrollableItems(
        watches:
            List<Watch>.from(json["Watches"].map((x) => Watch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Watches": List<dynamic>.from(watches.map((x) => x.toJson())),
      };
}

class Watch {
  Watch({
    required this.id,
    required this.title,
    required this.company,
    required this.price,
    required this.imageUrl,
    required this.thumbnail,
  });

  int id;
  Title title;
  Company company;
  int price;
  String imageUrl;
  String thumbnail;

  factory Watch.fromJson(Map<String, dynamic> json) => Watch(
        id: json["id"],
        title: (titleValues.map[json["title"]])!,
        company: (companyValues.map[json["company"]])!,
        price: json["price"],
        imageUrl: json["imageUrl"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": titleValues.reverse[title],
        "company": companyValues.reverse[company],
        "price": price,
        "imageUrl": imageUrl,
        "thumbnail": thumbnail,
      };
}

enum Company { SHEVORLET, ORLET }

final companyValues =
    EnumValues({"orlet": Company.ORLET, "Shevorlet": Company.SHEVORLET});

enum Title { MARTIN, SGTIR }

final titleValues = EnumValues({"martin": Title.MARTIN, "sgtir": Title.SGTIR});

class Windows {
  Windows({
    required this.firstWindows,
    required this.secondWindows,
  });

  SecondWindowsClass firstWindows;
  SecondWindowsClass secondWindows;

  factory Windows.fromJson(Map<String, dynamic> json) => Windows(
        firstWindows: SecondWindowsClass.fromJson(json["firstWindows"]),
        secondWindows: SecondWindowsClass.fromJson(json["SecondWindows"]),
      );

  Map<String, dynamic> toJson() => {
        "firstWindows": firstWindows.toJson(),
        "SecondWindows": secondWindows.toJson(),
      };
}

class SecondWindowsClass {
  SecondWindowsClass({
    required this.id,
    required this.imageUrl,
    required this.title,
  });

  int id;
  String imageUrl;
  String title;

  factory SecondWindowsClass.fromJson(Map<String, dynamic> json) =>
      SecondWindowsClass(
        id: json["id"],
        imageUrl: json["imageUrl"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imageUrl": imageUrl,
        "title": title,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    // ignore: unnecessary_null_comparison
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
