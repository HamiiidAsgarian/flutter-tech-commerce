import 'package:commerce_app/screens/search_limit_screen.dart';
import 'package:commerce_app/style/my_flutter_app_icons.dart';
import 'package:commerce_app/widgets/appbar.dart';
import 'package:commerce_app/widgets/item.dart';
import 'package:flutter/material.dart';

import '../consts.dart';

class ListedItemsScreen extends StatelessWidget {
  ListedItemsScreen({this.title, this.itemsList, Key? key}) : super(key: key);

  final String? title;

  final List<dynamic>? itemsList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cBackgroundGrey,
        appBar: MyAppBar(
          title: Text(
            title!,
            style: itemBrandFontStyle.copyWith(fontSize: 20),
          ),
          leadingIcon: const Icon(
            MyFlutterApp.left_open,
            color: appBargrey,
          ),
          leadingIconFunction: () {
            Navigator.pop(context);
          },
        ),
        body: Column(children: [
          Divider(
            height: 1,
            color: cBackgroundGrey,
          ),
          const SizedBox(height: 7),
          BrandItemsList(itemsList: itemsList!)
        ]));
  }
}

class BrandItemsList extends StatefulWidget {
  const BrandItemsList({Key? key, required this.itemsList}) : super(key: key);
  final List<dynamic> itemsList;

  @override
  _BrandItemsListState createState() => _BrandItemsListState();
}

class _BrandItemsListState extends State<BrandItemsList> {
  ScrollController _scrollControllerGrid = new ScrollController();
  late int _maxLimit =
      widget.itemsList.length > 6 ? 6 : widget.itemsList.length;
  @override
  void initState() {
    super.initState();
    // _maxLimit = widget.itemsList.length > 6 ? 6 : widget.itemsList.length;
    print("widget.itemsList.length ${widget.itemsList.length} init");

    _scrollControllerGrid.addListener(() {
      if (_scrollControllerGrid.position.pixels ==
          _scrollControllerGrid.position.maxScrollExtent) {
        print("ended");
        setState(() {
          // print(
          //     "listLength => ${widget.itemsList.length} | maxLimit=> $_maxLimit");
          _maxLimit = (_maxLimit + 6 <= widget.itemsList.length)
              ? _maxLimit + 6
              : _maxLimit;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
            controller: _scrollControllerGrid,
            itemCount: widget.itemsList.length > 6
                ? _maxLimit
                : widget.itemsList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 3 / 5),
            itemBuilder: (context, index) {
              return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      color: Colors.white,
                      // width:
                      //     (MediaQuery.of(context).size.width / 2) - 5,
                      child: Item(
                        id: widget.itemsList[index]['id'],
                        title: widget.itemsList[index]['title'],
                        company: widget.itemsList[index]['company'],
                        price: widget.itemsList[index]['price'].toDouble(),
                        imgTumbnailUrl: widget.itemsList[index]['thumbnail'],
                        imgUrl: "data['imageUrl']",
                        rate: widget.itemsList[index]['rate'].toDouble(),
                        data: widget.itemsList[index],
                      ),
                    ),
                  ));
            }));
  }
}

//////////////////////////////////////////////////////////////////////////////////
class OtherBrandsSection extends StatelessWidget {
  const OtherBrandsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        children: [
          const SizedBox(width: 25),
          Text("Other brands :",
              style: itemBrandFontStyle.copyWith(fontSize: 15)),
          const SizedBox(width: 7),
          Expanded(
              child: ListView(
            scrollDirection: Axis.horizontal,
            children: ['Aftabe', 'ven', 'Adorabamma', 'Puma', 'S']
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2.5, vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: cBorderGrey),
                        ),
                        height: 30,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: RawMaterialButton(
                            fillColor: Colors.white,
                            constraints: BoxConstraints(minWidth: 50),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ListedItemsScreen(title: e)));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(e,
                                  style: itemBrandFontStyle.copyWith(
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ))
        ],
      ),
    );
  }
}

class FilterAndSortSection extends StatelessWidget {
  const FilterAndSortSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //NOTE Filter and sort Section
      padding: const EdgeInsets.symmetric(vertical: 5),
      color: Colors.white,
      child: Row(children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchLimitScreen(function: () {
                  print("from FilterAndSortSection/listed items");
                });
              }));
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(
                Icons.filter_list,
                size: 25,
                color: appBargrey,
              ),
              const SizedBox(width: 5),
              Text("Filter", style: itemTitleFontStyle.copyWith(fontSize: 18))
            ]),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              sortPopup(context);
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(
                Icons.sort,
                size: 25,
                color: appBargrey,
              ),
              const SizedBox(width: 5),
              Text("Sort", style: itemTitleFontStyle.copyWith(fontSize: 18))
            ]),
          ),
        ),
      ]),
    );
  }
}

//////////////////////////////////////////////////////

void sortPopup(BuildContext context) {
  {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Container(
                //NOTE: popup sort height
                height: MediaQuery.of(context).size.height / 2,
                color: Colors.white,
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    color: Colors.black, //NOTE Title section color
                    child: ListTile(
                      // tileColor: Colors.amber,
                      title: Align(
                        alignment: Alignment(0.3, 0),
                        child: Text("Sort",
                            style: itemBrandFontStyle.copyWith(
                                fontSize: 25, color: Colors.white)),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.cancel,
                              size: 30, color: Colors.white)),
                    ),
                  ),
                  const Divider(height: 0),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          PopupItem(text: "highest Value"),
                          PopupItem(text: "Lowestt Value"),
                          PopupItem(text: "Lowestt Value"),
                          PopupItem(text: "Lowestt Value"),
                          PopupItem(text: "Lowestt Value"),
                        ],
                      ),
                    ),
                  )
                ]),
              ));
        });
  }
}

class PopupItem extends StatelessWidget {
  final String? text;
  const PopupItem({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        print("object");
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        width: double.infinity,
        // height: 50,
        // color: Colors.amber,
        child: Center(
            child: Text(this.text ?? 'no text',
                style: itemBrandFontStyle.copyWith(fontSize: 25))),
      ),
    );
  }
}

//////////////////////////////////////////////////
