import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:donate_platelets/constants/color_constants.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'https://i1.wp.com/www.bms.co.in/wp-content/uploads/2015/06/World-Blood-Donor-Day-Images-8.jpg',
  'https://res.cloudinary.com/teepublic/image/private/s--mgXgV-6V--/t_Preview/t_watermark_lock/b_rgb:191919,c_lpad,f_jpg,h_630,q_90,w_1200/v1607635903/production/designs/17186274_0.jpg',
  'https://i.pinimg.com/originals/db/31/20/db31205404421ee66f3aebba09871098.png',
  'https://th.bing.com/th/id/OIP.H2EiuDunOfkz71OvfaxgHwHaEq?pid=ImgDet&rs=1',
  'https://wallpapercave.com/wp/wp7898008.jpg',
];

final themeMode = ValueNotifier(2);

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InkWell(
        // to make the container clickable wrap it inside inkwell
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => NextPage(index: _current),
          //   ),
          // );
        },
        child: Container(
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              height: 200.0,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              enlargeFactor: 0.25,
              viewportFraction: 0.8,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : kPrimaryColor)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ]);
  }
}

final List<Widget> imageSliders = imgList
    .map(
      (item) => Container(
        child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: Image.network(item, fit: BoxFit.fill, width: 1000.0),
            )),
      ),
    )
    .toList();
