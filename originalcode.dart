

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'GeeksForGeeks';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.green,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 550.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                height: 480.0,
                width: 240.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://4kwallpapers.com/images/walls/thumbs_2t/13495.jpg'),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.rectangle,
                ),
              ),
              Container(
                height: 480.0,
                width: 240.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://wallpapercat.com/w/full/0/a/8/319915-3840x2160-desktop-4k-iron-man-background.jpg'),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.rectangle,
                ),
              ),
              Container(
                height: 240.0,
                width: 240.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://c4.wallpaperflare.com/wallpaper/1022/408/961/tv-show-ben-10-ben-tennyson-wallpaper-preview.jpg'),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.rectangle,
                ),
              ),
              Container(
                height: 480.0,
                width: 240.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://c4.wallpaperflare.com/wallpaper/724/879/773/prabhas-bahubali-part-2-wallpaper-preview.jpg'),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.rectangle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}