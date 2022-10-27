// import 'package:flutter/material.dart';
// import 'package:news_app/screens/home_screen.dart';
// import 'package:news_app/widgets/header.dart';

// class NewsApp extends StatelessWidget {
//   const NewsApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;

//     return DefaultTabController(
//         length: 2,
//         child: SafeArea(
//           child: Scaffold(
//             body: NestedScrollView(
//               headerSliverBuilder:
//                   (BuildContext context, bool innerBoxIsScrolled) {
//                 return [
//                   const SliverAppBar(
//                     pinned: true,
//                     floating: true,
//                     title: Text('Fresh News'),
//                     centerTitle: true,
//                     bottom: TabBar(
//                       tabs: [
//                         Tab(icon: Icon(Icons.line_style)),
//                         Tab(icon: Icon(Icons.list)),
//                       ],
//                     ),
//                   ),
//                 ];
//               },
//               body: TabBarView(children: [
//                 //top news
//                 HomeScreen(),

//                 //all news
//                 Column(
//                   children: [
//                     Header(textHeader: 'All News'),
//                   ],
//                 ),
//               ]),
//             ),
//           ),
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:news_app/screens/all_news_screen.dart';
import 'package:news_app/screens/favorites_screen.dart';
import 'package:news_app/screens/top_news_screen.dart';
import 'package:news_app/widgets/header.dart';

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  var indexClicked = 0;
  final pages = [
    //main page
    const MainPageWidget(),
    //fav page
    const FavoritesScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[indexClicked],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        elevation: 60,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        currentIndex: indexClicked,
        onTap: (value) {
          setState(() {
            indexClicked = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(
              Icons.newspaper,
            ),
            label: 'News',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(
              Icons.favorite_border,
            ),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

class MainPageWidget extends StatelessWidget {
  const MainPageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  const SliverAppBar(
                    pinned: true,
                    floating: true,
                    title: Text('Fresh News'),
                    centerTitle: true,
                    bottom: TabBar(
                      tabs: [
                        Tab(icon: Icon(Icons.line_style)),
                        Tab(icon: Icon(Icons.list)),
                      ],
                    ),
                  ),
                ];
              },
              body: const TabBarView(children: [
                //top news
                HomeScreen(),
                //all news
                AllNewsScreen(),
              ]),
            ),
          ),
        ));
  }
}
