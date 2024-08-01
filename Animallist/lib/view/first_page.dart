import 'package:flutter/material.dart';
import '../model/animal.dart';

class FirstPage extends StatefulWidget {
  final List<Animal> initialAnimals;
  final Function(int) onRemove;

  const FirstPage({
    super.key,
    required this.initialAnimals,
    required this.onRemove,
  });

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  // 변수 설정
  late List<Animal> animals;

  @override
  void initState() {
    super.initState();
    animals = List.from(widget.initialAnimals);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: animals.length,
      itemBuilder: (context, index) {
        return _buildAnimalItem(index);
      },
    );
  }

  // UI 구성 함수
  Widget _buildAnimalItem(int index) {
    return Dismissible(
      key: ValueKey(animals[index]),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        _removeAnimal(index);
      },
      confirmDismiss: (direction) => _confirmDismiss(index),
      background: _buildDismissBackground(),
      child: _buildAnimalCard(index),
    );
  }

  Widget _buildDismissBackground() {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Icon(Icons.delete, color: Colors.white),
    );
  }

  Widget _buildAnimalCard(int index) {
    return GestureDetector(
      onTap: () => _showAlert(context, animals[index]),
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.all(17.0),
        child: ListTile(
          leading: Image.asset(animals[index].imagePath, width: 50, height: 50),
          title: Text(animals[index].name),
        ),
      ),
    );
  }

  // 기능 함수
  void _removeAnimal(int index) {
    setState(() {
      animals.removeAt(index);
    });
    widget.onRemove(index);
  }

  Future<bool?> _confirmDismiss(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('삭제 확인'),
          content: Text('${animals[index].name}을(를) 삭제하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('삭제'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${animals[index].name} 삭제됨')),
      );
    }

    return confirmed;
  }

  void _showAlert(BuildContext context, Animal animal) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(animal.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("이 동물은 ${animal.classification} 입니다."),
              const SizedBox(height: 8),
              Text(animal.canFly ? "이 동물은 날 수 있습니다." : "이 동물은 날 수 없습니다."),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("확인"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
