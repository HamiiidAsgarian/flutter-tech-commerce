import 'package:commerce_app/provider_model.dart';
import 'package:commerce_app/widgets/appbar.dart';
import 'package:commerce_app/widgets/carousel.dart';
import 'package:commerce_app/widgets/forCategorySection.dart';
import 'package:commerce_app/widgets/windows_category-section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../consts.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Map<String, dynamic>> _firstPageData;

  @override
  void initState() {
    super.initState();
    setState(() {
      _firstPageData = Provider.of<ProviderModel>(context, listen: false)
          .getDataFromApi(url: "http://localhost:3000/firstPage");
    });
  }

  Widget build(BuildContext context) {
    return Consumer<ProviderModel>(builder: (context, val, child) {
      return Navigator(onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          return Scaffold(
            backgroundColor: cBackgroundGrey,
            appBar: const MyAppBar(
                // leadingIcon: Icon(
                //   MyFlutterApp.menu,
                //   color: cIconGrey,
                // ),
                ),
            body: RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FutureBuilder(
                        future: _firstPageData,
                        builder: (context,
                            AsyncSnapshot<Map<String, dynamic>> snapshot) {
                          if (snapshot.hasData) {
                            return Column(children: [
                              CarouselSection(
                                  items: snapshot.data!['Carousels']
                                      ['FirstCarousel']),
                              HorizontalItemsList(
                                  sectionTitle: "Watches",
                                  ListItemsMargin: EdgeInsets.only(right: 10),
                                  ListFramePadding:
                                      EdgeInsets.symmetric(horizontal: 15),
                                  itemsList: snapshot.data!['scrollableItems']
                                      ['Watches']),
                              WindowsCategorySection(
                                  items: snapshot.data!['Windows']
                                      ['FirstWindow'])
                            ]);
                          }
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        });
      });
    });
  }
}

// sum of two numbers
