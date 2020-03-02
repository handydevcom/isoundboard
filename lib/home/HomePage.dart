import 'package:flutter/material.dart';
import 'package:isoundboard/api/SoundCategory.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<SoundCategory> categories = <SoundCategory>[
    SoundCategory(id: 1, name: 'Популярные'),
    SoundCategory(id: 1, name: 'Новые'),
    SoundCategory(id: 1, name: 'Рекомендации'),
    SoundCategory(id: 1, name: 'Видеоигры'),
    SoundCategory(id: 1, name: 'Блоги'),
    SoundCategory(id: 1, name: 'ТВ')
  ];

  double cardWidth = 200;
  double cardHeight = 200;

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int categoryIndex) {
                return Container(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                        child: Text(
                          categories[categoryIndex].name,
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        height: cardHeight,
                        child: new ListView.builder(
                          itemCount: categories[categoryIndex].sounds.length,
                          itemBuilder: (context, soundIndex) {
                            return Container(
                              width: cardWidth,
                              height: cardHeight,
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
                              child: InkWell(
                                onTap: () {},
                                child: new Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              ClipOval(
                                                child: FadeInImage.assetNetwork(
                                                  width: 40,
                                                  height: 40,
                                                  fit: BoxFit.contain,
                                                  placeholder:
                                                      'images/profile.png',
                                                  image:
                                                      'https://picsum.photos/250?image=9',
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                'Папич',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            width: cardWidth,
                                            child: Text(
                                              'Да, это жёстко,Да, это жёстко, Да, это жёстко,Да, это жёстко,',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              InkWell(
                                                child: Icon(
                                                  Icons.favorite,
                                                  color: Colors.grey,
                                                ),
                                                onTap: () {
                                                  print("like");
                                                },
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              FloatingActionButton(
                                                mini: true,
                                                child: Icon(Icons.play_arrow),
                                                heroTag: null,
                                                onPressed: () {
                                                  print('play');
                                                },
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      )
                    ],
                  ),
                );
              })),
    );
  }
}
