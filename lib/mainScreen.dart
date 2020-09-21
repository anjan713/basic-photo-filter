import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// import './colorFilters.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isImageNotLoaded = true;
  int currentIndex = 0;
  List<int> imageBytes;
  Future clickImage() async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      this.imageBytes = File(image.path).readAsBytesSync();
      isImageNotLoaded = !isImageNotLoaded;
    });
  }

  List<List<double>> myFilterColor = [
    [
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ],
    [
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0,
      0,
      0,
      1,
      0
    ],
    [
      0.393,
      0.769,
      0.189,
      0,
      0,
      0.349,
      0.686,
      0.168,
      0,
      0,
      0.272,
      0.534,
      0.131,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ],
    [
      -1,
      0,
      0,
      0,
      255,
      0,
      -1,
      0,
      0,
      255,
      0,
      0,
      -1,
      0,
      255,
      0,
      0,
      0,
      1,
      0,
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
          title: Text('Photo Filters'),
          backgroundColor: Colors.deepPurple,
          actions: [
            IconButton(icon: Icon(Icons.camera_alt), onPressed: clickImage)
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            isImageNotLoaded
                ? Center(child: Text('No Image has been Selected'))
                : Column(children: <Widget>[
                    ColorFiltered(
                      colorFilter:
                          ColorFilter.matrix(myFilterColor[currentIndex]),
                      child: Image.memory(
                        imageBytes,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SelectImage()
                  ])
          ],
        ));
  }
//TODO:: https://www.youtube.com/watch?v=v3doTuJF-lE

  // Widget CreateImage() {
  //   return Container(
  //       height: 500,
  //       width: 400,
  //       child: Image.memory(
  //         imageBytes,
  //         fit: BoxFit.cover,
  //       ));
  // }

  Widget SelectImage() {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, ind) {
          return GestureDetector(
            onTap: () {
              setState(() {
                currentIndex = ind;
              });
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(2),
              color: Colors.red,
              child: ColorFiltered(
                colorFilter: ColorFilter.matrix(myFilterColor[ind]),
                child: Image.memory(
                  imageBytes,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: myFilterColor.length,
      ),
    );
  }
}
