import 'package:flutter/material.dart';
import 'view/first_page.dart';
import 'view/second_page.dart';
import 'model/animal.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController controller;
  List<Animal> animals = [
    Animal(
        name: "Bee",
        imagePath: "images/bee.png",
        classification: "곤충류",
        canFly: true),
    Animal(
        name: "Cat",
        imagePath: "images/cat.png",
        classification: "포유류",
        canFly: false),
    Animal(
        name: "Cow",
        imagePath: "images/cow.png",
        classification: "포유류",
        canFly: false),
    Animal(
        name: "Dog",
        imagePath: "images/dog.png",
        classification: "포유류",
        canFly: false),
    Animal(
        name: "Fox",
        imagePath: "images/fox.png",
        classification: "포유류",
        canFly: false),
    Animal(
        name: "Monkey",
        imagePath: "images/monkey.png",
        classification: "영장류",
        canFly: false),
    Animal(
        name: "Pig",
        imagePath: "images/pig.png",
        classification: "포유류",
        canFly: false),
    Animal(
        name: "Wolf",
        imagePath: "images/wolf.png",
        classification: "포유류",
        canFly: false),
  ];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _addAnimal(Animal animal) {
    setState(() {
      animals.add(animal);
    });
  }

  void _removeAnimal(int index) {
    setState(() {
      animals.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pets, color: Colors.white),
            const SizedBox(width: 12), // 아이콘과 텍스트 사이에 간격 추가
            Text(
              'Animal List',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold, // 폰트 굵기 조정
                color: Colors.white, // 텍스트 색상
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(2.0, 2.0),
                  ),
                ], // 그림자 추가
              ),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 0, 153, 204),
      ),
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      body: TabBarView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          FirstPage(initialAnimals: animals, onRemove: _removeAnimal),
          SecondPage(onAnimalAdded: _addAnimal),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.amber,
        child: TabBar(
          controller: controller,
          labelColor: Colors.blue,
          indicatorColor: Colors.red,
          tabs: const [
            Tab(
              icon: Icon(Icons.list),
              text: "동물 목록",
            ),
            Tab(
              icon: Icon(Icons.add),
              text: "동물 추가",
            ),
          ],
        ),
      ),
    );
  }
}
