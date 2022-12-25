import 'package:deepo/content_model.dart';
import 'package:deepo/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;

  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(children: [
        Expanded(
          child: PageView.builder(
            controller: _controller,
            itemCount: contents.length,
            onPageChanged: (int index) {
              setState(
                () {
                  currentIndex = index;
                },
              );
            },
            itemBuilder: (_, i) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 35, horizontal: 40),
                child: Column(
                  children: [
                    //SvgPicture
                    SvgPicture.asset(
                      contents[i].image,
                      height: 300,
                      width: 428,
                    ),
                    //Text
                    Text(
                      contents[i].text,
                      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(contents.length, (index) => buildDot(index, context)),
        ),
        SizedBox(height: 20),
        SizedBox(
          height: 55,
          width: double.infinity,
          child: MaterialButton(
            onPressed: () {
              if (currentIndex == contents.length - 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HomePage(),
                  ),
                );
              }
              _controller.nextPage(
                duration: Duration(milliseconds: 100),
                curve: Curves.bounceIn,
              );
            },
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            child: Text(currentIndex == contents.length - 1 ? 'Get Started' : 'NEXT'),
          ),
        ),
      ]),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 50),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Theme.of(context).primaryColor),
    );
  }
}
