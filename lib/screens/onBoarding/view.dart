
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class OnBoardingScreen extends GetView<OnBoardingController> {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final c =PageController();
    final list=[
      onBoard(title: 'Rental cars delivered to your door',
          subtittle: 'The easiest way to rent a car',
          image: ''),
      onBoard(title: 'Tell us where and when',
          subtittle: 'Reserve a new, clean car and a driver will bring it to your, whenever you need it.',
          image: ''),
      onBoard(title: 'We deliver car with love',
          subtittle: "Let's face it... Picking up a rental car is painful so don't do it, Reserve a ybride, a driver will bring it to you, on demand",
          image: ''),
      onBoard(title: 'We fuel up for you',
          subtittle: "It's your adventure! No need to refuel your car before you return it. We'll fuel up for you at transparent rates! No hidden fees. ",
          image: ''),
      onBoard(title: 'We pick up YBCars',
          subtittle: "When you're done! A driver will pick up the car from a location of your choice",
          image: ''),
      onBoard(title: 'We fuel up for you',
          subtittle: "It's your adventure! No need to refuel your car before you return it. We'll fuel up for you at transparent rates! No hidden fees. ",
          image: ''),
    ];

    return Scaffold(
      body:PageView.builder(
          itemCount:list.length ,
          itemBuilder: (ctx,ind){
        return Column(
          children: [
            Image(image: AssetImage('')),
            Text(list[ind].title,),
            // SizedBox(height: mq.height *.01,),
            SizedBox(
              // width: mq.width* .7,
              child: Text(list[ind].subtittle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13.5,
                    letterSpacing: .5
                ),
              ),
            ),
            Spacer(),




          ],
        );
      })
    );
  }
}
class onBoard{
  final String title,subtittle;
  final String image;
  onBoard({
    required this.title,required this.subtittle,required this.image
  });

}
