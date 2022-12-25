import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ImageProvider a = AssetImage('images/pictira_background_1.jpg');
    var screenSize = MediaQuery.of(context).size;

    try {
      return Container(
        height: screenSize.height * 0.25,
        width: 500,
        child: ListView(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: screenSize.height * 0.24,
                enlargeCenterPage: true,
                autoPlay: true,
                viewportFraction: 2.0,
                // autoPlayCurve: Curves.ease,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
              ),
              items: [
                Container(
                  width: 400,
                  height: screenSize.height * 0.24,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0, sigmaY: 1),
                    child: Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Best place to ace your subject',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.orange[500],
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      decoration: new BoxDecoration(
                          color: Colors.black.withOpacity(0.0)),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('images/idk_background_1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  height: screenSize.height * 0.24,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                    child: Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'The one place for all your academic needs',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.amber,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      decoration: new BoxDecoration(
                          color: Colors.black.withOpacity(0.0)),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('images/idk_background_2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  height: screenSize.height * 0.24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('images/idk_background_3.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                    child: Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'All the best resources at your desposal',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.greenAccent,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      decoration: new BoxDecoration(
                          color: Colors.black.withOpacity(0.0)),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    } on Exception catch (e) {
      return CircularProgressIndicator();
    }
  }
}
