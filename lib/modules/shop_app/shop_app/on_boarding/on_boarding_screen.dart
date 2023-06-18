import 'package:afandina/modules/basics_app/home/home_screen.dart';
import 'package:afandina/shared/components/componentes.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login/shop_login.dart';

class BoardingModel {
  final String image;
  final String tittle;
  final String body;

  BoardingModel({
    required this.image,
    required this.tittle,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/rousy2.jpg',
      tittle: 'on board 1 tittle',
      body: 'on board 1 body',
    ),
    BoardingModel(
      image: 'assets/images/rousy2.jpg',
      tittle: 'on board 2 tittle',
      body: 'on board 2 body',
    ),
    BoardingModel(
      image: 'assets/images/rousy2.jpg',
      tittle: 'on board 3 tittle',
      body: 'on board 3 body',
    ),
    BoardingModel(
      image: 'assets/images/rousy2.jpg',
      tittle: 'on board 4 tittle',
      body: 'on board 4 body',
    ),
    BoardingModel(
      image: 'assets/images/rousy2.jpg',
      tittle: 'on board 5 tittle',
      body: 'on board 5 body',
    ),
  ];
  bool isLast = false;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => navigateAndFinish(
                    context,
                    ShopLoginScreen(),
                  ),
              icon: Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBordingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Row(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    boardController.previousPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.bounceOut);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
                Spacer(),
                SmoothPageIndicator(
                  effect: SlideEffect(
                    activeDotColor: Colors.orange,
                    dotColor: Colors.red,
                    paintStyle: PaintingStyle.stroke,
                    strokeWidth: 1.5,
                    spacing: 7.0,
                  ),
                  controller: boardController,
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      navigateAndFinish(
                        context,
                        ShopLoginScreen(),
                      );
                    } else {
                      boardController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.bounceIn);
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBordingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Text(
            '${model.tittle}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
}
