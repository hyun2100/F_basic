import 'package:flutter/material.dart';

class DetailHero extends StatelessWidget {
  final String heroName;

  DetailHero({required this.heroName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$heroName 상세 정보'),
      ),
      body: Center(
        child: Hero(
          tag: heroName,
          child: Material(
            color: Colors.transparent,
            child: Text(
              '$heroName에 대한 상세 정보',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}
