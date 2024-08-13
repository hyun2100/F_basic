import 'package:flutter/material.dart';

class InsertHero extends StatefulWidget {
  final Function(String) onHeroAdded;

  InsertHero({required this.onHeroAdded});

  @override
  _InsertHeroState createState() => _InsertHeroState();
}

class _InsertHeroState extends State<InsertHero> {
  final TextEditingController _controller = TextEditingController();

  void _addHero() {
    if (_controller.text.isNotEmpty) {
      widget.onHeroAdded(_controller.text.trim());
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('새로운 영웅 추가'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: '영웅 이름'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addHero,
              child: Text('영웅 추가'),
            ),
          ],
        ),
      ),
    );
  }
}
