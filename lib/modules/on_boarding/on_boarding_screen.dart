import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/modules/register/register_screen.dart';
import 'package:shopapp/modules/signin/shop_login_screen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local.dart';
import 'package:simple_page_indicator/simple_page_indicator.dart';

class Content {
  final String image;
  final String title;
  final String body;
  Content(this.title, this.body, this.image);
}

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<Content> boardingContent = [
    Content('title1', 'body1', 'assets/images/2-2-shopping-png-file.png'),
    Content('title2', 'body2', 'assets/images/2-2-shopping-png-file.png'),
    Content('title3', 'body3', 'assets/images/2-2-shopping-png-file.png'),
  ];

  var pageController = PageController();
  bool isLast = false;

  void submit()  {
     CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, SignIn());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          textButton(
              name: 'skip',
              function: submit,),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder (
                physics: BouncingScrollPhysics(),
                controller: pageController,
                onPageChanged: (int index) {
                  if (index == boardingContent.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    isLast = false;
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boardingContent[index]),
                itemCount: boardingContent.length,
              ),
            ),
            Row(
              children: [
                SimplePageIndicator(
                  controller: pageController,
                  itemCount: boardingContent.length,
                  indicatorColor: Colors.blue,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == true) {
                      submit();
                    }
                    pageController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn);
                  },
                  child: Icon(Icons.forward),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(Content model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            child: Center(child: Image(image: AssetImage('${model.image}')))),
        SizedBox(height: 50),
        Text(
          '${model.title}',
          style: TextStyle(fontSize: 30, fontFamily: 'Tajawal'),
        ),
        SizedBox(height: 50),
        Text(
          '${model.body}',
          style: TextStyle(fontFamily: 'Tajawal', fontSize: 20),
        ),
        SizedBox(height: 100),
      ],
    );
  }
}
