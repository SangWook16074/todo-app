import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  late TextEditingController controller;

  Future<void> _create(String todo) async {
    await FirebaseFirestore.instance.collection('todo').doc().set({
      'todo': todo,
      'time': Timestamp.now(),
      'isDone': false,
    });
  }

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('할일추가'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    _create(controller.text.toString());
                    Navigator.of(context).pop();
                  },
                  child: const Text('추가')),
            ],
          ),
        ),
      ),
    );
  }
}
