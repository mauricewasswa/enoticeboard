import 'package:enoticeboard/onboarding/onboarding_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../nav_pages/main_page.dart';

class Onboarding extends StatefulWidget {
   Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex =0;
  late PageController _controller =PageController(initialPage: 0);


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
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
                onPageChanged: (int index){
                  setState((){
                    currentIndex =index;
                  });
                },
                itemBuilder: (_,i){
                return Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      SvgPicture.asset(contents[i].image,
                      height: 300,),
                      Text(contents[i].title,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,

                      ),),
                      SizedBox(height: 20,),
                      Text(contents[i].description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),)
                    ],
                  ),
                );

            }),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(contents.length,
                      (index) =>
                          buildDot(index, context)),
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.all(40),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if(currentIndex == contents.length -1){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>HomePage()));
                }
                _controller.nextPage(duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
              },
              child: Text(currentIndex == contents.length -1 ? "Continue":"Next",
              style: TextStyle(
                fontSize: 20
              ),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff76ca71)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context){
    return Container(
      height: 10,
      width: currentIndex == index ? 25:10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
      ),
    );
  }

}
