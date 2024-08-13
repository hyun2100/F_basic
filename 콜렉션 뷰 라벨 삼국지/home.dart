import 'package:flutter/material.dart';
import 'view/insert_hero.dart';
import 'view/detail_hero.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> characters = [
    '유비',
    '관우',
    '장비',
    '조조',
    '여포',
    '초선',
    '손건',
    '장료',
    '손책'
  ];

  void _addNewHero(String heroName) {
    setState(() {
      characters.add(heroName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('삼국지 인물 콜렉션'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InsertHero(onHeroAdded: _addNewHero),
                ),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: characters.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailHero(heroName: characters[index]),
                ),
              );
            },
            child: Hero(
              tag: characters[index],
              child: Container(
                margin: EdgeInsets.all(8.0), // 카드 주위에 여백을 줘서 외곽선이 보이도록 설정
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red,
                      Colors.orange,
                      Colors.yellow,
                      Colors.green,
                      Colors.blue,
                      Colors.indigo,
                      Colors.purple,
                    ], // 무지개 색상 배열
                    begin: Alignment.topLeft, // 그라데이션 시작점
                    end: Alignment.bottomRight, // 그라데이션 끝점
                  ),
                  borderRadius: BorderRadius.circular(12), // 외곽선의 모서리를 둥글게 설정
                ),
                child: Container(
                  margin: EdgeInsets.all(3.0), // 내부 컨테이너에 여백을 줘서 외곽선 두께를 설정
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(201, 249, 247, 125), // 카드의 배경색
                    borderRadius:
                        BorderRadius.circular(12), // 내부 컨테이너의 모서리를 둥글게 설정
                  ),
                  child: Center(
                    child: Text(characters[index],
                        style: TextStyle(
                          fontSize: 30,
                          color:
                              const Color.fromARGB(255, 22, 96, 62), // 텍스트 색상
                        ),
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


/*

  functions
  rebuildData(String value) {
    if(value.isNotEmpty && value != 'null') {
      heroList.add(value);
    }
    setState(() {});
    
  }  
  get.to
  받을땐 .then
  get.back(result: resultMessage);

*/