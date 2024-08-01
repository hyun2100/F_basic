import 'package:flutter/material.dart';
import '../model/animal.dart';

class SecondPage extends StatefulWidget {
  final Function(Animal) onAnimalAdded;

  const SecondPage({super.key, required this.onAnimalAdded});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  // 변수 설정
  final TextEditingController _nameController = TextEditingController();
  String _classification = '포유류';
  bool _canFly = false;
  int _selectedImageIndex = 0;
  final int _maxNameLength = 20; // 최대 글자 수 설정

  final List<String> _classifications = ['양서류', '포유류', '파충류', '곤충류', '영장류'];
  final List<String> _imagePaths = [
    'images/bee.png',
    'images/cat.png',
    'images/cow.png',
    'images/dog.png',
    'images/fox.png',
    'images/monkey.png',
    'images/pig.png',
    'images/wolf.png',
  ];

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_updateCharCount);
  }

  @override
  void dispose() {
    _nameController.removeListener(_updateCharCount);
    _nameController.dispose();
    super.dispose();
  }

  void _updateCharCount() {
    setState(() {
      // 이 setState 호출로 인해 build 메서드가 다시 호출되어 UI가 갱신됩니다.
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNameInput(),
            const SizedBox(height: 20),
            _buildClassificationSelection(),
            const SizedBox(height: 20),
            _buildFlyingAbilityCheckbox(),
            const SizedBox(height: 20),
            _buildImageSelection(),
            const SizedBox(height: 20),
            _buildSelectedImage(), // 새로 추가된 부분
            const SizedBox(height: 20),
            _buildAddButton(),
          ],
        ),
      ),
    );
  }

  // UI 구성 함수들
  Widget _buildNameInput() {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: '동물 이름',
      ),
      keyboardType: TextInputType.text,
      maxLength: _maxNameLength,
      buildCounter: (
        BuildContext context, {
        required int currentLength,
        required bool isFocused,
        required int? maxLength,
      }) {
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            '$currentLength/$maxLength',
            style: TextStyle(color: Colors.grey),
          ),
        );
      },
    );
  }

  Widget _buildClassificationSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('동물의 종류'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: _classifications.map(_buildClassificationOption).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildClassificationOption(String type) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: type,
            groupValue: _classification,
            onChanged: (String? value) =>
                setState(() => _classification = value!),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          Text(type, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildFlyingAbilityCheckbox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('이 동물은 날 수 있나요?'),
        Checkbox(
          value: _canFly,
          onChanged: (bool? value) => setState(() => _canFly = value!),
        ),
      ],
    );
  }

  Widget _buildImageSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('이미지 선택'),
        SizedBox(
          height: 70, // PageView의 전체 높이를 조정
          child: PageView.builder(
            itemCount: _imagePaths.length,
            controller:
                PageController(viewportFraction: 0.2), // 각 아이템이 차지하는 비율 조정
            onPageChanged: (int index) =>
                setState(() => _selectedImageIndex = index),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 50, // Container의 너비 설정
                  height: 50, // Container의 높이 설정
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Image.asset(
                    _imagePaths[index],
                    fit: BoxFit.cover, // 이미지를 Container 크기에 맞게 조정
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedImage() {
    return Column(
      children: [
        const Center(
          // 텍스트를 감싸는 Center 위젯
          child: Text('선택된 이미지:'),
        ),
        const SizedBox(height: 10),
        Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(0),
            ),
            child: Image.asset(_imagePaths[_selectedImageIndex]),
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _showAddAnimalDialog,
        child: const Text('동물 추가하기'),
      ),
    );
  }

  // 기능 함수
  void _showAddAnimalDialog() {
    final String animalName = _nameController.text;
    final String animalClassification = _classification;
    final bool animalCanFly = _canFly;
    final String animalImagePath = _imagePaths[_selectedImageIndex];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('동물 추가하기'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("이 동물은 $animalName 입니다. \n"
                  "동물의 종류는 $animalClassification 입니다."),
              Text(animalCanFly ? "이 동물은 날 수 있습니다." : "이 동물은 날 수 없습니다."),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("아니오"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("예"),
              onPressed: () {
                widget.onAnimalAdded(Animal(
                  name: animalName,
                  imagePath: animalImagePath,
                  classification: animalClassification,
                  canFly: animalCanFly,
                ));
                Navigator.of(context).pop();
                _nameController.clear();
              },
            ),
          ],
        );
      },
    );
  }
}
